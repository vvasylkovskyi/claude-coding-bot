---
name: init
description: Initializes a repo for autopilot-workflow by discovering validation commands, writing CLAUDE.md, creating roadmap folders, extracting agent context files (workflow.md, testing-checklist.md). Use this skill when setting up a new repo or when CLAUDE.md needs to be generated or refreshed. Trigger when the user says "init repo", "set up autopilot workflow", "initialize context", or when starting work in a new repository.
---

# Repo Initialization

One-command setup for autopilot-workflow. This skill:

1. Inspects the repo to discover validation commands
2. Writes or updates `CLAUDE.md` with discovered commands and conventions
3. Creates `context/feature-docs/` and `context/bug-docs/` directories
4. Updates `.gitignore` to exclude roadmap directories and worktrees
5. Extracts agent-consumable files: `context/workflow.md` and `context/testing-checklist.md`

After running this skill, the repo is ready for `/autopilot-workflow:implementation-orchestrator`.

---

## Parameters

No parameters required. The current working directory is the repo root.

---

## Step 1 — Discover repo type and validation commands

Inspect the repo to identify the tech stack:

```bash
# Package managers and build tools
ls package.json yarn.lock pnpm-lock.yaml bun.lockb Gemfile Cargo.toml go.mod requirements.txt pyproject.toml mix.exs 2>/dev/null

# Package manager scripts
cat package.json 2>/dev/null | grep -E '"scripts"' -A 30
cat Makefile 2>/dev/null

# CI configuration
cat .github/workflows/*.yml 2>/dev/null | head -100
cat .buildkite/pipeline.yml 2>/dev/null | head -60

# Existing docs
cat README.md 2>/dev/null | head -80
```

Based on what you find, determine validation commands using this logic:

### Node / pnpm

If `pnpm-lock.yaml` exists: `pnpm lint`, `pnpm build`, `pnpm test`, `pnpm typecheck` (whichever scripts exist in package.json)

### Node / npm or yarn

Same priority list but with `npm run` or `yarn` prefix.

### Ansible

If `playbooks/` exists: `ansible-lint playbooks/`

### Shell scripts

If `scripts/*.sh` exists: `shellcheck scripts/*.sh`

### Python

If `pyproject.toml` exists: `pytest`, `ruff check .`, `black --check .`, `mypy .` (whichever are configured)

### Go

If `go.mod` exists: `go build ./...`, `go test ./...`, `go vet ./...`

### Terraform

If `.tf` files exist: `terraform fmt -check`, `terraform validate`

### Make

If `Makefile` has `test`, `lint`, or `check` targets, use those.

---

## Step 2 — Write or update CLAUDE.md

Check if CLAUDE.md exists:

```bash
cat CLAUDE.md 2>/dev/null
```

**If CLAUDE.md exists:** Preserve all existing content. Only add missing sections.

**If CLAUDE.md does not exist:** Write it from scratch using this template:

````markdown
# Development Conventions

## Branch Naming

- `feat/<description>` — new features
- `fix/<description>` — bug fixes
- `docs/<description>` — documentation
- `refactor/<description>` — code refactoring
- `issue-<number>-<slug>` — issue-driven work

## Commit Messages

Format: `type: description`

Types: `feat`, `fix`, `docs`, `refactor`, `test`, `chore`

Example: `feat: add ARM64 validation check`

Include `Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>` for AI-assisted commits.

# Validation Commands

Run in order. Stop and fix before continuing if any command fails.

```bash
<discovered command 1>
<discovered command 2>
```

# Testing Checklist

All commands must exit 0. A non-zero exit code is a hard failure — do not commit, do not mark PASS.

- [ ] Branch follows naming convention
- [ ] Commits follow format (`type: description`)
- [ ] No merge conflicts with base branch
- [ ] All validation commands pass
````

**If no validation commands were discovered**, write:

```markdown
# Validation Commands

> ⚠️ No validation commands were auto-detected for this repo.
> Add the commands that should run before every commit here.
```

---

## Step 3 — Extract workflow.md and testing-checklist.md

From the CLAUDE.md you just wrote or updated, extract two agent-consumable files.

Create the context directory:

```bash
mkdir -p context
```

**Extract `context/workflow.md`:**

From CLAUDE.md, extract branch naming, commit message format, and general conventions.

Write to `context/workflow.md`:

```markdown
# Workflow

> Auto-extracted from CLAUDE.md on <date>. Do not edit manually — re-run /autopilot-workflow:init to refresh.

## Branch Naming

<extracted content>

## Commit Messages

<extracted content>

## General Conventions

<extracted content, or "No additional conventions specified." if absent>
```

**Extract `context/testing-checklist.md`:**

From CLAUDE.md, extract validation commands and hard-gate rules.

Write to `context/testing-checklist.md`:

````markdown
# Testing Checklist

> Auto-extracted from CLAUDE.md on <date>. Do not edit manually — re-run /autopilot-workflow:init to refresh.

## Hard Rules

All commands must exit 0. Non-zero exit is a hard failure — do not commit, do not mark PASS.

## Validation Commands

Run in order. Stop and fix before continuing if any command fails.

```bash
<command 1>
<command 2>
```

## Acceptance Checklist

- [ ] <item 1>
- [ ] <item 2>
````

---

## Step 4 — Create roadmap folders and update .gitignore

Create directories for feature and bug specs:

```bash
mkdir -p context/feature-docs context/bug-docs
```

Update `.gitignore` to exclude roadmap directories and worktrees:

```bash
cat .gitignore 2>/dev/null
```

Append any of the following that are not already present:

```
# Autopilot workflow
context/feature-docs/
context/bug-docs/
worktrees/
```

**Important:** Only add entries that are not already present. Do not duplicate.

---

## Step 5 — Confirm to the user

```
✅ Repo initialized for autopilot-workflow

  CLAUDE.md                            — validation commands and conventions
  context/workflow.md                  — branch naming, commit format
  context/testing-checklist.md         — validation commands, hard gates
  context/feature-docs/                — created for feature specs
  context/bug-docs/                    — created for bug specs
  .gitignore                           — updated (feature-docs, bug-docs, worktrees)

Detected stack: <e.g. Node/pnpm, Python/pytest, Go>
Validation commands added:
  <command 1>
  <command 2>

Validation commands added to allowedTools:
  Bash(pnpm *)
  Bash(pytest *)
  ...

Ready for:
  /autopilot-workflow:design-doc-decomposer
  /autopilot-workflow:implementation-orchestrator
```

---

## Rules

- **Never overwrite existing CLAUDE.md content** — only add missing sections
- **Never invent commands** — only use commands evidenced by repo files
- **Use exact command names** from package.json scripts, Makefile targets, etc.
- **Never remove existing settings.json entries** — only add
- **Be a faithful transcriber** — copy commands exactly as written
- **Date the output** in extracted files so agents can tell if files are stale
