cask "tokenration" do
  version "0.1"
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"

  url "https://github.com/MilosRandelovic/TokenRation/releases/download/v#{version}/TokenRation.zip"
  name "TokenRation"
  desc "Menu-bar gauge for Claude usage (5-hour, weekly, per-model, spend)"
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
  uninstall quit: "com.milos.tokenration"

  zap trash: "~/Library/Preferences/com.milos.tokenration.plist"
end
