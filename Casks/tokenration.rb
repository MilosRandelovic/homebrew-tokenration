cask "tokenration" do
  version "1.1.0"
  # Set by TokenRation CI when a release is published — not edited by hand.
  sha256 "dfe318d0cf78e14ae27a288f9a6102a7e78c795b2a73aded89d95d29b85aa36c"

  url "https://github.com/MilosRandelovic/tokenration/releases/download/v#{version}/TokenRation.zip"
  name "TokenRation"
  desc "Menu-bar gauge for Claude and Codex usage (session, weekly, per-model, spend)"
  homepage "https://github.com/MilosRandelovic/tokenration"

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

  caveats <<~EOS
    To let coding agents read your usage, register the bundled MCP server:

      claude mcp add tokenration -- tokenration-mcp
      codex mcp add tokenration -- tokenration-mcp
  EOS
end
