# IdleGame (SwiftUI, iOS 17+)

Projet SwiftUI pour un jeu Idle basé sur une architecture MVVM.

## Structure

- `IdleGame/Models` : modèles `Codable` (état du jeu, upgrades).
- `IdleGame/ViewModels` : logique métier (production, upgrades, prestige, offline earnings).
- `IdleGame/Views` : interface SwiftUI (Game, Stats, Prestige).
- `IdleGame/Services` : persistance `UserDefaults`.

## Fonctionnalités clés

- Ressource principale : Coins.
- Production automatique `coinsPerSecond`.
- Upgrades : +1 cps, coût avec multiplicateur 1.15.
- Offline earnings : gain entre `lastActiveDate` et maintenant (cap 8h).
- Prestige : reset coins + upgrades, octroi de Gems qui boostent la production.

## Utilisation dans Xcode

1. Créez un nouveau projet iOS SwiftUI (iOS 17+).
2. Copiez le dossier `IdleGame` dans votre projet Xcode.
3. Assurez-vous que tous les fichiers Swift sont inclus dans la target.
4. Lancez le projet : `IdleGameApp` est le point d'entrée.

## Notes

- La sauvegarde utilise `Codable` + `UserDefaults` via `PersistenceService`.
- Le cycle de vie est géré via `ScenePhase` dans `ContentView`.
