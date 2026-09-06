cask "tokenration" do
  version "1.0.1"
  # Set by TokenRation CI when a release is published — not edited by hand.
  sha256 "986a28c9f1e57d6a46f9db687ea3c3c90fe266b4f98ad390359a2dc8abcc4d77"

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
