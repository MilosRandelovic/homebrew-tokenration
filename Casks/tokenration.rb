cask "tokenration" do
  version "0.1.6"
  # Set by TokenRation CI when a release is published — not edited by hand.
  sha256 "5b7c189e3773767da3340101d832a43c94bc6a2945b78bc02e498b6ef653fa06"

  url "https://github.com/MilosRandelovic/TokenRation/releases/download/v#{version}/TokenRation.zip"
  name "TokenRation"
  desc "Menu-bar gauge for Claude and Codex usage (session, weekly, per-model, spend)"
  homepage "https://github.com/MilosRandelovic/TokenRation"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma

  app "TokenRation.app"
  # Bundled MCP server, so agents can read usage without a second install.
  binary "#{appdir}/TokenRation.app/Contents/MacOS/tokenration-mcp"

  # Quit the running menu-bar app before replacing it, so an upgrade doesn't leave the old
  # process running against a swapped-out bundle.
  uninstall quit: "com.milosrandelovic.tokenration"

  zap trash: "~/Library/Preferences/com.milosrandelovic.tokenration.plist"

  # v0.1 ships ad-hoc signed rather than notarized, so Gatekeeper quarantines it on first
  # launch. Remove this once releases are signed with a Developer ID.
  caveats <<~EOS
    TokenRation is not yet notarized, so macOS will refuse to open it the first time.
    After installing, clear the quarantine flag:

      xattr -dr com.apple.quarantine "#{appdir}/TokenRation.app"

    Then launch it normally.

    To let coding agents read your usage, register the bundled MCP server:

      claude mcp add tokenration -- tokenration-mcp
      codex mcp add tokenration -- tokenration-mcp
  EOS
end
