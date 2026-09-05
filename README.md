# homebrew-tokenration

Homebrew tap for **[TokenRation](https://github.com/MilosRandelovic/tokenration)** — a native macOS menu-bar gauge for your Claude and Codex usage (session and weekly windows, per-model limits, and spend).

## Install

```sh
brew tap MilosRandelovic/tokenration
brew trust MilosRandelovic/tokenration
brew install tokenration
```

Launch **TokenRation** from your Applications folder — it runs in the menu bar (no Dock icon). It needs at least one of the Claude Code or Codex CLIs installed and signed in; whichever are present are detected automatically. For Claude, click **Always Allow** on the one-time macOS Keychain prompt on first launch, so TokenRation can read the access token Claude Code saved there. There's no separate sign-in.

## Agent access (MCP)

The cask also puts `tokenration-mcp` on your PATH — a small MCP server that reports the usage TokenRation has already fetched, so agents can check remaining quota before expensive work. Register it once per client:

```sh
claude mcp add tokenration -- tokenration-mcp     # Claude Code
codex mcp add tokenration -- tokenration-mcp      # Codex
```

It exposes one tool, `get_usage`, and only reads what the app has published — polling it costs nothing upstream. See the [TokenRation repo](https://github.com/MilosRandelovic/tokenration#agent-access-mcp) for the details of what it returns.

## Update

```sh
brew upgrade tokenration
```

## Uninstall

```sh
brew uninstall tokenration          # add --zap to also remove its preferences
```

---

Releases (the notarized `TokenRation.zip` this cask downloads) live in the [TokenRation repo](https://github.com/MilosRandelovic/tokenration/releases); `release.sh` there builds them and updates this cask's `version`/`sha256`.
