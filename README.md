# Tap Homebrew de Hirzla

Coffre-fort de mots de passe post-quantique : <https://github.com/Phdhebde/Hirzla>.

```sh
brew tap hirzla/hirzla
brew trust hirzla/hirzla
brew install --cask hirzla
```

Mises à jour : `brew upgrade hirzla`.

Le cask installe le paquet macOS `.pkg` publié avec chaque version (Mac Apple silicon). Le mot de passe d'administrateur est demandé. `brew uninstall hirzla` retire l'application et le manifeste, mais ne supprime jamais le coffre (`~/Library/Application Support/Hirzla`).

`Casks/hirzla.rb` est mis à jour automatiquement à chaque version publiée, par le workflow `homebrew.yml` du dépôt Hirzla. Ne modifiez pas à la main les lignes `version` et `sha256`.
