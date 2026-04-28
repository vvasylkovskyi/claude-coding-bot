# Interactive Token Mode

```sh

viktorvasylkovskyi@Mac claude-coding-bot % sh install.sh
Repo already exists at /Users/viktorvasylkovskyi/git/claude-coding-bot — pulling latest...
Already up to date.

Claude OAuth token (from 'claude setup-token'):
```

## Log when dropping the document

````sh
Apr 28 15:59:29 raspberry-4b systemd[1]: Started claude-coding-bot.service - Claude Code PR Bot.
Apr 28 15:59:29 raspberry-4b start.sh[2514944]: [pipeline] Watching /home/vvasylkovskyi/my-claude-code/context/feature-docs for new feature docs...
Apr 28 15:59:29 raspberry-4b start.sh[2514950]: Setting up watches.
Apr 28 15:59:29 raspberry-4b start.sh[2514950]: Watches established.
Apr 28 15:59:54 raspberry-4b start.sh[2514951]: [pipeline] Detected: print-readme-testing-headless-claude-code.md — starting pipeline...
Apr 28 15:59:59 raspberry-4b start.sh[2515185]: Warning: no stdin data received in 3s, proceeding without it. If piping from a slow command, redirect stdin explicitly: < /dev/null to skip, or wait longer.
Apr 28 16:03:24 raspberry-4b start.sh[2515185]: `🎉 Final PR opened: https://github.com/vvasylkovskyi/my-app/pull/2`
Apr 28 16:03:24 raspberry-4b start.sh[2515185]: ---
Apr 28 16:03:24 raspberry-4b start.sh[2515185]: ```
Apr 28 16:03:24 raspberry-4b start.sh[2515185]: === Autopilot Session Complete ===
Apr 28 16:03:24 raspberry-4b start.sh[2515185]: Mode: features
Apr 28 16:03:24 raspberry-4b start.sh[2515185]: Repo: /home/vvasylkovskyi/my-claude-code/repo
Apr 28 16:03:24 raspberry-4b start.sh[2515185]: ✅  print-readme-testing-headless-claude-code → PR #1 merged → feature/autopilot-2026-04-28
Apr 28 16:03:24 raspberry-4b start.sh[2515185]: Skipped:   0
Apr 28 16:03:24 raspberry-4b start.sh[2515185]: Completed: 1
Apr 28 16:03:24 raspberry-4b start.sh[2515185]: Failed:    0
Apr 28 16:03:24 raspberry-4b start.sh[2515185]: ==================================
Apr 28 16:03:24 raspberry-4b start.sh[2515185]: Final PR for your review: https://github.com/vvasylkovskyi/my-app/pull/2
````
