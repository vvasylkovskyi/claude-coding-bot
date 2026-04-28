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
shellcheck install.sh uninstall.sh scripts/*.sh
ansible-lint playbook.yml playbook-uninstall.yml
ansible-playbook playbook.yml --syntax-check -i inventory.ini
```

# Testing Checklist

All commands must exit 0. A non-zero exit code is a hard failure — do not commit, do not mark PASS.

- [ ] Branch follows naming convention
- [ ] Commits follow format (`type: description`)
- [ ] No merge conflicts with base branch
- [ ] All validation commands pass
