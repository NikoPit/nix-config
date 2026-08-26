{
  kw ? (builtins.getEnv "KW"),
  exact ? false,
  nixDir ? "/home/elysia/nix",
  host ? (builtins.getEnv "HOSTNAME"),
}:

let
  nix = builtins.getFlake nixDir;
  nixpkgs = nix.inputs.nixpkgs;
  homeManager = nix.inputs.homeManager;
  pkgs = nixpkgs.legacyPackages.x86_64-linux;
  hmLib = import "${homeManager}/modules/lib/stdlib-extended.nix" nixpkgs.lib;
  settings = import "${nixDir}/settings";

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
        j = builtins.tryEval (builtins.toJSON r.value);
      in
      if j.success then j.value else "<set>"
    else
      "<" + (builtins.typeOf r.value) + ">";

  # A namespace node has no `type`; a leaf option does.
  flatten =
    prefix: node:
    builtins.concatLists (
      builtins.map (
        name:
        let
          o = node.${name};
          path = prefix ++ [ name ];
        in
        if o ? type then
          [ { inherit path o; } ]
        else if builtins.isAttrs o then
          flatten path o
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
        leaves = flatten [ ] opts;
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
          node: parts':
          if parts' == [ ] then
            if node ? type then
              [
                {
                  path = parts;
                  o = node;
                }
              ] # leaf option
            else if builtins.isAttrs node then
              [
                {
                  path = parts;
                  ns = node;
                }
              ] # namespace
            else
              [ ]
          else if !(builtins.hasAttr (builtins.head parts') node) then
            [ ]
          else
            go node.${builtins.head parts'} (builtins.tail parts');
      in
      go opts parts;

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
      "==== "
      + title
      + " ("
      + builtins.toString (builtins.length hits)
      + ") ====\n"
      + (builtins.concatStringsSep "\n\n" (builtins.map fmtLeaf hits))
      + "\n";

  # --- NixOS options from the real host configuration --------------------
  nixosOpts = nix.nixosConfigurations.${host}.options;
  nixosHits = search nixosOpts;
  nixosExactHits = exactIn nixosOpts;

  # --- Home Manager options from the real user configuration -------------
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
