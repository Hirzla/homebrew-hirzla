cask "hirzla" do
  version "1.1.1"
  sha256 "f1b4a2a1c39afb40a0d818404d9ce46e156ce172d2fb3655e83c1fec6551dfeb"

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
