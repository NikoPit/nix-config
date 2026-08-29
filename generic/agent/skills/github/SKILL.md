---
name: github
description: Use the GitHub CLI (`gh`) for common GitHub operations — issues, pull requests, reviews, releases, gists, Actions, repos, search, and more. Use whenever a task involves interacting with GitHub and require doing these operations.
---

# GitHub CLI (`gh`)

Use `gh` for all GitHub operations. All commands assume the current directory is inside a git repo with a configured remote, or use `-R OWNER/REPO` to target another repo.

## Common flags

| Flag | Meaning |
|------|---------|
| `-R, --repo [HOST/]OWNER/REPO` | Target a different repo |
| `--json fields` | Output JSON with specified fields |
| `-q, --jq expression` | Filter JSON output with jq |
| `-t, --template string` | Format with Go template |
| `-w, --web` | Open in browser |

---

## Authentication

```bash
# Check auth status
gh auth status

# Login
gh auth login

# Logout
gh auth logout

# Refresh token with additional scopes
gh auth refresh -s project
```

---

## Issues

### Create

```bash
# Interactive
gh issue create

# With title and body
gh issue create --title "Bug: login fails on empty input" --body "Steps to reproduce..."

# With labels and assignee
gh issue create --title "Refactor auth module" \
  --label "enhancement" --label "good first issue" \
  --assignee "@me"

# From template
gh issue create --template "Bug Report"

# As sub-issue
gh issue create --title "Sub-task" --parent 123

# With blocking/blocked-by relationships
gh issue create --title "Blocked task" --blocked-by 200,201 --blocking 300

# Open browser to create
gh issue create --web
```

### List

```bash
# Open issues (default)
gh issue list

# All states
gh issue list --state all

# Filter by label, assignee, author
gh issue list --label bug --label "help wanted"
gh issue list --assignee "@me"
gh issue list --author monalisa

# Filter by milestone
gh issue list --milestone "The big 1.0"

# Search with query syntax
gh issue list --search "error no:assignee sort:created-asc"

# JSON output
gh issue list --json number,title,labels,assignees --jq '.[] | {number, title}'
```

### View

```bash
# View issue details
gh issue view 123

# View with comments
gh issue view 123 --comments

# JSON output with specific fields
gh issue view 123 --json title,body,labels,state

# Open in browser
gh issue view 123 --web
```

### Comment

```bash
# Add comment
gh issue comment 12 --body "Fixed in PR #42"

# Read body from file
gh issue comment 12 --body-file notes.txt

# Edit last comment
gh issue comment 12 --edit-last --body "Updated comment"

# Delete last comment
gh issue comment 12 --delete-last
```

### Edit / Close / Reopen

```bash
# Edit title, body, labels, milestone
gh issue edit 23 --title "New title" --body "Updated body"
gh issue edit 23 --add-label "bug" --remove-label "question"
gh issue edit 23 --add-assignee "@me" --remove-assignee monalisa

# Close
gh issue close 23 --reason "completed"   # or "not_planned"

# Reopen
gh issue reopen 23
```

---

## Pull Requests

### Create

```bash
# Interactive (prompts for title, body, etc.)
gh pr create

# With title and body
gh pr create --title "Add user authentication" --body "Implements OAuth2 login flow"

# Fill from commits
gh pr create --fill
gh pr create --fill-verbose   # use commit message + body

# Draft PR
gh pr create --draft

# Specify base branch
gh pr create --base develop --head my-feature

# With labels, reviewers, assignee, project
gh pr create --label "enhancement" \
  --reviewer monalisa,hubot \
  --assignee "@me" \
  --project "Roadmap"

# Use template
gh pr create --template "pull_request_template.md"

# Open browser to create
gh pr create --web

# Dry run (print details without creating)
gh pr create --dry-run
```

### List

```bash
# Open PRs (default)
gh pr list

# All states
gh pr list --state all         # open, closed, merged, all

# Filter by author, assignee, label, base branch
gh pr list --author "@me"
gh pr list --assignee monalisa
gh pr list --label bug --label "priority 1"
gh pr list --base main

# Search with query syntax
gh pr list --search "status:success review:required"

# Find a PR that introduced a given commit
gh pr list --search "<SHA>" --state merged

# JSON output
gh pr list --json number,title,headRefName,state --jq '.[] | {number, title}'
```

### View

```bash
# View PR details (current branch or by number)
gh pr view
gh pr view 123

# View with comments
gh pr view 123 --comments

# JSON with specific fields
gh pr view 123 --json title,body,additions,deletions,files,reviews

# Open in browser
gh pr view 123 --web
```

### Checkout

```bash
# Interactive (pick from recent PRs)
gh pr checkout

# Checkout a specific PR
gh pr checkout 32
gh pr checkout https://github.com/OWNER/REPO/pull/32
gh pr checkout feature-branch

# Alias
gh co 32

# With custom local branch name
gh pr checkout 32 --branch my-local-name

# Detached HEAD
gh pr checkout 32 --detach

# Force reset local branch
gh pr checkout 32 --force
```

### Diff

```bash
# View diff for current branch PR
gh pr diff

# View diff for a specific PR
gh pr diff 123

# Only file names
gh pr diff --name-only

# Exclude files matching patterns
gh pr diff --exclude '*.lock' --exclude 'generated/*'

# Open in browser
gh pr diff 123 --web
```

### Review

```bash
# Approve
gh pr review --approve
gh pr review 123 --approve --body "LGTM!"

# Comment (without approval or change request)
gh pr review --comment --body "Have you considered..."
gh pr review 123 --comment -b "Looks good, but please fix the typo"

# Request changes
gh pr review --request-changes --body "Needs more tests"
gh pr review 123 -r -b "Please add error handling"
```

### Comment

```bash
# Add a comment
gh pr comment 13 --body "Thanks for the fix!"

# Read body from file
gh pr comment 13 --body-file review.md

# Edit last comment
gh pr comment 13 --edit-last --body "Updated review"

# Open browser
gh pr comment 13 --web
```

### Merge

```bash
# Merge (default: creates a merge commit)
gh pr merge
gh pr merge 123

# Squash
gh pr merge --squash
gh pr merge 123 --squash --body "Squash commit message"

# Rebase
gh pr merge --rebase

# Delete branch after merge
gh pr merge --squash --delete-branch

# Auto-merge (enables auto-merge, merges when CI passes)
gh pr merge --auto --squash

# With custom commit subject/body
gh pr merge --merge --subject "feat: add auth" --body "Closes #42"
```

### Edit / Close / Reopen

```bash
# Edit title, body, base branch
gh pr edit 23 --title "New title" --body "Updated description"
gh pr edit 23 --base main

# Manage labels, reviewers, assignees
gh pr edit 23 --add-label "bug" --remove-label "question"
gh pr edit 23 --add-reviewer monalisa
gh pr edit 23 --add-assignee "@me"

# Milestone
gh pr edit 23 --milestone "v1.0"

# Close
gh pr close 23

# Reopen
gh pr reopen 23

# Mark as ready for review (from draft)
gh pr ready 23
```

### Status / Checks

```bash
# Summary of relevant PRs
gh pr status

# Show CI checks
gh pr checks
gh pr checks 123

# Update branch with base
gh pr update-branch
gh pr update-branch 123
```

---

## Repositories

### Clone

```bash
gh repo clone cli/cli
gh repo clone myrepo                         # your own repo
gh repo clone cli/cli workspace/cli          # to custom directory
gh repo clone cli/cli -- --depth=1           # with extra git flags
gh repo clone myfork --no-upstream           # skip upstream remote
```

### Create

```bash
# Interactive
gh repo create

# New remote repo and clone locally
gh repo create my-project --public --clone

# In an organization
gh repo create my-org/my-project --private

# From local directory
gh repo create my-project --private --source=. --remote=upstream --push

# With README, gitignore, license
gh repo create my-project --public --add-readme --gitignore Node --license MIT
```

### Fork

```bash
gh repo fork
gh repo fork --clone                         # clone the fork locally
gh repo fork --remote-name upstream          # custom remote name
gh repo fork --org my-org                    # fork to an organization
```

### View / Sync

```bash
# View repo info
gh repo view
gh repo view cli/cli

# Open in browser
gh repo view --web

# Sync fork (fetch and merge upstream)
gh repo sync
gh repo sync --branch main                   # specific branch
gh repo sync my-fork                         # with a specific fork remote
```

### Other

```bash
# List repos
gh repo list
gh repo list cli                             # org repos
gh repo list --limit 50 --language rust      # filter by language

# Set default repo for current directory
gh repo set-default
```

---

## Releases

```bash
# Create a release
gh release create v1.2.3 --notes "bugfix release"
gh release create v1.2.3 --generate-notes   # auto-generate notes
gh release create v1.2.3 -F release-notes.md
gh release create v1.2.3 --draft            # draft release
gh release create v1.2.3 --prerelease
gh release create v1.2.3 ./dist/*.tgz       # upload assets

# List releases
gh release list
gh release list --limit 10

# View release
gh release view v1.2.3
gh release view v1.2.3 --web

# Download assets
gh release download v1.2.3
gh release download v1.2.3 --pattern "*.tar.gz"

# Delete
gh release delete v1.2.3
```

---

## Gists

```bash
# Create
gh gist create file.txt
gh gist create file1.txt file2.txt
gh gist create --public file.txt            # public gist
gh gist create --description "My snippet" file.txt
gh gist create -                          # from stdin

# List
gh gist list
gh gist list --limit 20
gh gist list --public

# View
gh gist view 5b0e0062eb8e9654adad
gh gist view 5b0e0062eb8e9654adad --web

# Clone
gh gist clone 5b0e0062eb8e9654adad

# Edit
gh gist edit 5b0e0062eb8e9654adad file.txt

# Delete
gh gist delete 5b0e0062eb8e9654adad
```

---

## GitHub Actions

### Workflows

```bash
# List workflows
gh workflow list

# Run a workflow (trigger workflow_dispatch)
gh workflow run ci.yml
gh workflow run ci.yml --ref main            # specify branch
gh workflow run deploy.yml -f env=staging    # with inputs

# View workflow
gh workflow view ci.yml
```

### Runs

```bash
# List recent runs
gh run list
gh run list --limit 20
gh run list --workflow ci.yml

# View a run
gh run view 1234
gh run view 1234 --log                       # view logs
gh run view 1234 --log-failed                # only failed steps

# Cancel / Rerun
gh run cancel 1234
gh run rerun 1234
gh run rerun 1234 --failed                   # only failed jobs

# Watch a run until completion
gh run watch 1234

# Download artifacts
gh run download 1234
gh run download 1234 --name my-artifact      # download specific artifact
```

---

## Search

```bash
# Search issues
gh search issues "memory leak" --repo cli/cli
gh search issues --label bug --repo cli/cli
gh search issues --author "@me" --state open

# Search pull requests
gh search prs "feat" --reviewer monalisa
gh search prs --author "@me" --state merged

# Search repositories
gh search repos "topic:rust stars:>1000"

# Search code
gh search code "TODO" --repo cli/cli

# Search with exclusions (use `--` to avoid flag parsing issues)
gh search issues -- "error -label:bug"
```

---

## Browse

```bash
# Open repo home page
gh browse

# Open specific path
gh browse src/main.rs
gh browse src/main.rs:312                    # open at line 312

# Open issue or PR
gh browse 217

# Open commit
gh browse 77507cd

# Open other sections
gh browse --settings                        # repo settings
gh browse --actions                         # Actions tab
gh browse --projects                        # Projects tab
gh browse --releases                        # Releases tab
gh browse --wiki                            # Wiki tab

# With specific branch
gh browse main.go --branch bug-fix

# Print URL without opening
gh browse --no-browser
```

---

## API

```bash
# GET request
gh api repos/OWNER/REPO
gh api repos/OWNER/REPO/issues

# POST with parameters
gh api repos/OWNER/REPO/issues \
  -f title="New issue from API" \
  -f body="Created via gh api"

# GraphQL
gh api graphql -f query='
  query {
    repository(owner: "cli", name: "cli") {
      pullRequests(first: 5) { nodes { number title } }
    }
  }
'

# Pagination
gh api repos/OWNER/REPO/issues --paginate

# Paginate and slurp into one array
gh api repos/OWNER/REPO/issues --paginate --slurp

# Custom method
gh api -X PATCH repos/OWNER/REPO/issues/1 -f state=closed

# JSON output filtered
gh api repos/OWNER/REPO --jq '.description'
```

---

## Labels

```bash
# List labels
gh label list

# Create label
gh label create bug --color "d73a4a" --description "Something isn't working"

# Edit label
gh label edit bug --name "bug-fix" --color "c04040"

# Delete label
gh label delete bug

# Clone labels from another repo
gh label clone cli/cli --force
```

---

## Formatting with `--json` and `--jq`

Many `gh` commands support structured JSON output. Use `--json` to specify fields and `--jq` to filter/transform:

```bash
# List available JSON fields for a command
gh pr view 123 --json  # no field name → shows available fields

# Extract specific data
gh pr list --json number,title,author --jq '.[] | "\(.number): \(.title) by \(.author.login)"'

# Count
gh issue list --state all --json number --jq 'length'

# Group by state
gh pr list --state all --json number,title,state \
  --jq 'group_by(.state) | map({state: .[0].state, count: length})'

# Check if CI passed
gh pr view 123 --json statusCheckRollup \
  --jq '[.statusCheckRollup[] | select(.conclusion=="FAILURE")] | length'
```

---

## Tips

- **Default repo**: `gh` uses the repo from the current directory's git remote. Override with `-R OWNER/REPO`.
- **Non-interactive**: Use `--title` / `--body` / `--label` etc. to skip prompts in scripts.
- **Reading from stdin**: `-F -` reads body from stdin; `gh issue create --title "Title" --body-file -`
