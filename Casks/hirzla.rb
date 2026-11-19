cask "hirzla" do
  version "1.1.2"
  sha256 "9c91c395c4c242952f9c201046ffb578c0cd3c0615f53633c1592925384013d1"

  url "https://github.com/Phdhebde/Hirzla/releases/download/v#{version}/Hirzla_#{version}_aarch64.pkg"
  name "Hirzla"
  desc "Post-quantum password vault"
  homepage "https://github.com/Phdhebde/Hirzla"

  # Releases are published as GitHub pre-releases: read their tags, drafts excluded.
  livecheck do
    url :url
    strategy :github_releases do |json, regex|
      json.filter_map do |release|
        next if release["draft"]

        release["tag_name"]&.[](regex, 1)
      end
    end
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  depends_on arch: :arm64
  depends_on :macos

  pkg "Hirzla_#{version}_aarch64.pkg"
  binary "/Applications/Hirzla.app/Contents/MacOS/hirzla"

  uninstall quit:    "app.hirzla.desktop",
            pkgutil: [
              "app.hirzla.desktop.app",
              "app.hirzla.desktop.manifest",
            ],
            delete:  "/Library/Application Support/Hirzla"

  # The vault itself is never removed, even by `brew uninstall --zap`: it lives in
  # ~/Library/Application Support/Hirzla and is deleted by hand only.
  zap trash: [
    "~/Library/Caches/app.hirzla.desktop",
    "~/Library/WebKit/app.hirzla.desktop",
  ]

  caveats <<~EOS
    The installer package is not signed by Apple: the administrator password is asked.
    Your vault (~/Library/Application Support/Hirzla) is kept on uninstall.
  EOS
end
