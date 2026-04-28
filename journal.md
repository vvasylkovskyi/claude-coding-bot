# Interactive Token Mode

```sh

viktorvasylkovskyi@Mac claude-coding-bot % sh install.sh
Repo already exists at /Users/viktorvasylkovskyi/git/claude-coding-bot — pulling latest...
Already up to date.

Claude OAuth token (from 'claude setup-token'):
```

## Log when dropping the document

```sh
vvasylkovskyi@raspberry-4b:~/my-claude-code/context/feature-docs $ journalctl -u claude-coding-bot -f
Apr 28 15:17:07 raspberry-4b systemd[1]: Started claude-coding-bot.service - Claude Code PR Bot.
Apr 28 15:17:07 raspberry-4b start.sh[2497062]: [pipeline] Watching /home/vvasylkovskyi/my-claude-code/context/feature-docs for new feature docs...
Apr 28 15:17:07 raspberry-4b start.sh[2497063]: Setting up watches.
Apr 28 15:17:07 raspberry-4b start.sh[2497063]: Watches established.
Apr 28 15:23:02 raspberry-4b systemd[1]: /etc/systemd/system/claude-coding-bot.service:15: Unknown key 'StartLimitIntervalSec' in section [Service], ignoring.
Apr 28 15:29:04 raspberry-4b systemd[1]: /etc/systemd/system/claude-coding-bot.service:15: Unknown key 'StartLimitIntervalSec' in section [Service], ignoring.
Apr 28 15:29:05 raspberry-4b systemd[1]: /etc/systemd/system/claude-coding-bot.service:15: Unknown key 'StartLimitIntervalSec' in section [Service], ignoring.
Apr 28 15:30:16 raspberry-4b systemd[1]: /etc/systemd/system/claude-coding-bot.service:15: Unknown key 'StartLimitIntervalSec' in section [Service], ignoring.
Apr 28 15:37:04 raspberry-4b start.sh[2497064]: [pipeline] Detected: print-readme-testing-headless-claude-code.md — starting pipeline...
Apr 28 15:37:04 raspberry-4b start.sh[2504844]: /home/vvasylkovskyi/my-claude-code/scripts/start.sh: line 21: claude: command not found
```
