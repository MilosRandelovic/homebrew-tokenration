cask "tokenration" do
  version "0.1.2"
  # Set by TokenRation CI when a release is published — not edited by hand.
  sha256 "71411c207f9c662f829c9468180189ede0b0f1105fd81979e42a6fdb1b117893"

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
  uninstall quit: "com.milosrandelovic.tokenration"

  zap trash: "~/Library/Preferences/com.milosrandelovic.tokenration.plist"

  # v0.1 ships ad-hoc signed rather than notarized, so Gatekeeper quarantines it on first
  # launch. Remove this once releases are signed with a Developer ID.
  caveats <<~EOS
    TokenRation is not yet notarized, so macOS will refuse to open it the first time.
    After installing, clear the quarantine flag:

      xattr -dr com.apple.quarantine "#{appdir}/TokenRation.app"

    Then launch it normally.
  EOS
end
