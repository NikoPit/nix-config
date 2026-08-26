{
  kw ? (builtins.getEnv "KW"),
  exact ? false,
  nixDir ? "/home/elysia/nix",
  host ? (builtins.getEnv "HOSTNAME"),
  depth ? 3,
  exactDepth ? 8,
  maxResults ? 200,
}:

let
  nix = builtins.getFlake nixDir;
  nixpkgs = nix.inputs.nixpkgs;
  homeManager = nix.inputs.homeManager;
  pkgs = nixpkgs.legacyPackages.x86_64-linux;
  hmLib = import "${homeManager}/modules/lib/stdlib-extended.nix" nixpkgs.lib;
  settings = import "${nixDir}/settings";

  jsonSafe =
    v: d:
    if d <= 0 then
      false
    else if builtins.isString v || builtins.isBool v || builtins.isInt v
      || builtins.isFloat v || builtins.isPath v || builtins.isNull v then
      true
    else if builtins.isList v then
      builtins.all (x: jsonSafe x (d - 1)) v
    else if builtins.isAttrs v then
      builtins.all (n: jsonSafe v.${n} (d - 1)) (builtins.attrNames v)
    else
      false;

  toStr =
    v:
    let
      r = builtins.tryEval v;
    in
    if !r.success then
      "<unset>"
    else if builtins.isString r.value then
      r.value
    else if builtins.isBool r.value then
      builtins.toString r.value
    else if builtins.isInt r.value then
      builtins.toString r.value
    else if builtins.isFloat r.value then
      builtins.toString r.value
    else if builtins.isList r.value then
      "[" + (builtins.concatStringsSep ", " (builtins.map toStr r.value)) + "]"
    else if builtins.isAttrs r.value then
      let
        j =
          if jsonSafe r.value 32 then
            builtins.tryEval (builtins.toJSON r.value)
          else
            { success = false; value = null; };
      in
      if j.success then j.value else "<set>"
    else
      "<" + (builtins.typeOf r.value) + ">";

  subOptionsOf =
    o: prefix:
    if o ? type && o.type ? getSubOptions then
      let
        r = builtins.tryEval (o.type.getSubOptions prefix);
      in
      if r.success && builtins.isAttrs r.value then r.value else null
    else
      null;

  flatten =
    prefix: node: maxDepth:
    builtins.concatLists (
      builtins.map (
        name:
        let
          o = node.${name};
          path = prefix ++ [ name ];
        in
        if builtins.substring 0 1 name == "_" then
          [ ]
        else if o ? type then
          [ { inherit path o; } ]
          ++ (
            if maxDepth > 0 then
              let
                sub = subOptionsOf o path;
              in
              if sub != null then flatten path sub (maxDepth - 1) else [ ]
            else
              [ ]
          )
        else if builtins.isAttrs o then
          flatten path o maxDepth
        else
          [ ]
      ) (builtins.attrNames node)
    );

  search =
    opts:
    if exact then
      [ ]
    else
      let
        leaves = flatten [ ] opts depth;
        match = o: builtins.match (".*" + kw + ".*") o != null;
      in
      builtins.filter (l: match (builtins.concatStringsSep "." l.path)) leaves;

  exactIn =
    opts:
    if !exact then
      [ ]
    else
      let
        parts = builtins.filter (s: s != "") (nixpkgs.lib.splitString "." kw);
        go =
          node: parts': prefix': remaining:
          if parts' == [ ] then
            if node ? type then
              [
                {
                  path = prefix';
                  o = node;
                }
              ]
            else if builtins.isAttrs node then
              [
                {
                  path = prefix';
                  ns = node;
                }
              ]
            else
              [ ]
          else if remaining <= 0 then
            [ ]
          else if !(node ? type) && builtins.isAttrs node && builtins.hasAttr (builtins.head parts') node then
            go
              node.${builtins.head parts'}
              (builtins.tail parts')
              (prefix' ++ [ (builtins.head parts') ])
              remaining
          else if node ? type then
            let
              sub = subOptionsOf node prefix';
            in
            if sub != null && builtins.hasAttr (builtins.head parts') sub then
              go
                sub.${builtins.head parts'}
                (builtins.tail parts')
                (prefix' ++ [ (builtins.head parts') ])
                (remaining - 1)
            else
              [ ]
          else
            [ ];
      in
      go opts parts [ ] exactDepth;

  nsCount = node: builtins.length (builtins.filter (n: node.${n} ? type) (builtins.attrNames node));

  fmtOption =
    o:
    "  type: "
    + (toStr (o.type.name or null))
    + "\n  default: "
    + (toStr (o.default or null))
    + "\n  desc: "
    + (toStr (o.description or null));

  fmtLeaf = l: (builtins.concatStringsSep "." l.path) + "\n" + (fmtOption l.o);

  fmtExact =
    h:
    if h ? o then
      fmtLeaf h
    else
      (builtins.concatStringsSep "." h.path)
      + "\n  (namespace: a container, not a settable option; "
      + builtins.toString (nsCount h.ns)
      + " option(s) directly under it)";

  sectionExact =
    title: hits:
    if hits == [ ] then
      ""
    else
      "==== "
      + title
      + " ("
      + builtins.toString (builtins.length hits)
      + ") ====\n"
      + (builtins.concatStringsSep "\n\n" (builtins.map fmtExact hits))
      + "\n";

  section =
    title: hits:
    if hits == [ ] then
      ""
    else
      let
        n = builtins.length hits;
        shown = nixpkgs.lib.take maxResults hits;
      in
      "==== "
      + title
      + " ("
      + builtins.toString n
      + ") ====\n"
      + (builtins.concatStringsSep "\n\n" (builtins.map fmtLeaf shown))
      + (
        if n > maxResults then
          "\n... (" + builtins.toString (n - maxResults) + " more matches not shown)"
        else
          ""
      )
      + "\n";

  nixosOpts = nix.nixosConfigurations.${host}.options;
  nixosHits = search nixosOpts;
  nixosExactHits = exactIn nixosOpts;

  mkHome = import "${nixDir}/flake/mkHome.nix" nix.inputs;
  hmCfg = mkHome {
    username = settings.user.name;
    homeDirectory = "/home/${settings.user.name}";
    extraImports = [
      "${nixDir}/linux/home.nix"
      "${nixDir}/hosts/linux/${host}/home.nix"
    ];
  };
  hmOpts =
    (hmLib.evalModules {
      modules =
        (import "${homeManager}/modules/modules.nix" {
          inherit pkgs;
          lib = hmLib;
        })
        ++ [ hmCfg ];
      specialArgs = {
        inherit host settings;
        firefoxAddons = nix.inputs.firefoxAddons;
      };
    }).options;
  hmHits = search hmOpts;
  hmExactHits = exactIn hmOpts;

in
if kw == "" then
  "no keyword given (set KW or pass kw)"
else if host == "" then
  "no host given: set HOSTNAME, e.g. HOSTNAME=$(hostname) (or pass the `host` argument)"
else
  section "NixOS (${host})" nixosHits
  + sectionExact "NixOS (${host}, exact)" nixosExactHits
  + section "Home Manager" hmHits
  + sectionExact "Home Manager (exact)" hmExactHits
  + (
    if (exact && nixosExactHits == [ ] && hmExactHits == [ ]) then
      "NOT FOUND: '" + kw + "' is not a declared option in the current NixOS or Home Manager config.\n"
    else if (!exact && nixosHits == [ ] && hmHits == [ ]) then
      "No options match '" + kw + "' in the current NixOS or Home Manager config.\n"
    else
      ""
  )
