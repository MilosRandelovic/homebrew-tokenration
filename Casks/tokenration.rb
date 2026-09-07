cask "tokenration" do
  version "1.0.2"
  # Set by TokenRation CI when a release is published — not edited by hand.
  sha256 "51b5a5f4e8060efaabe66899efd5ce9776b754d4f1dac895a9f096f4b2f13873"

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
