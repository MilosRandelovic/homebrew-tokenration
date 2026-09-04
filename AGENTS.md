# Agent Notes — homebrew-tokenration

Homebrew **cask tap** for [TokenRation](https://github.com/MilosRandelovic/tokenration).

- `Casks/tokenration.rb` is the only thing that matters here. It downloads the notarized `TokenRation.zip` from the TokenRation repo's GitHub Releases.
- **Don't hand-edit `version` / `sha256`.** TokenRation's `release.sh` rewrites them on each release (it `sed`s this file); editing by hand drifts from the released artifact.
- `brew style Casks/tokenration.rb` must pass before committing.
- Users install with: `brew tap MilosRandelovic/tokenration && brew trust MilosRandelovic/tokenration && brew install tokenration`.
