# Flutter Base Structure

## 📋 Vue d'ensemble

Ce projet Flutter utilise une architecture modulaire basée sur **GetX** pour la gestion d'état et la navigation. L'application est structurée pour supporter l'authentification, la gestion des utilisateurs, et une interface vitrine.

## 🏗️ Architecture du projet

### Structure des dossiers

```
lib/
├── config/                 # Configuration globale
├── helper/                 # Utilitaires et helpers
├── modules/                # Modules fonctionnels
│   ├── application/        # Module principal de l'app
│   ├── authentification/   # Module d'authentification
│   └── onbording/         # Module d'onboarding
├── navigation/             # Gestion de la navigation
├── provider/              # Providers pour les API
├── services/              # Services (stockage, analytics)
├── store/                 # Contrôleurs d'état GetX
└── widget_components/     # Widgets réutilisables
```

## 🔧 Technologies utilisées

### Dépendances principales

- **GetX** (^4.6.6) : Gestion d'état et navigation
- **HTTP** (^1.2.2) : Requêtes API
- **JWT Decoder** (^2.0.1) : Gestion des tokens JWT
- **Flutter Secure Storage** (^9.2.4) : Stockage sécurisé
- **Firebase Analytics** (^12.0.0) : Analytics
- **Country Picker** (^2.0.27) : Sélection de pays
- **Flutter Dotenv** (^5.2.1) : Variables d'environnement

## 🚀 Point d'entrée

### `lib/main.dart`

- Initialisation des services avec `AppService.initServices()`
- Configuration de GetMaterialApp avec localisation française
- Gestion du redémarrage de l'application
- Route initiale : `/home` (vitrine)

## 📱 Navigation

### Structure de navigation

- **Routes vitrine** : Pages publiques (`/home`)
- **Routes started** : Pages d'authentification (`/splash`, `/login`)

### Middleware

- `AuthMiddleware` : Vérification de l'authentification
- `FirstInitRouteMiddleware` : Gestion de la première initialisation

## 🔐 Authentification

### Gestion des tokens

- **Token JWT** : Stocké dans `UserController`
- **Refresh Token** : Renouvellement automatique
- **Expiration** : Vérification automatique avec délai de 10 secondes

### Logout

- Nettoyage des tokens
- Redirection vers la page de login

## 🌐 API et Providers

### CoreProvider (`lib/provider/_config/core_provider.dart`)

- **Gestion automatique des headers** : Content-Type, Authorization
- **Refresh token automatique** : Renouvellement avant expiration
- **Gestion des erreurs** : Parsing des messages d'erreur en français
- **Timeout** : 120 secondes par défaut

### UserProvider (`lib/provider/user_provider.dart`)

- **Logout** : Déconnexion avec refresh token
- **Cache** : Support du cache pour les requêtes GET

### Configuration API (`lib/config/api_key.dart`)

- **Variables d'environnement** : BASE_URL_PROD, BASE_URL_DEV
- **Clés API** : Google API, Mapbox API
- **Endpoints** : Auth, logout, refresh token

## 💾 Gestion d'état

### StateController (`lib/store/state_controller.dart`)

- **Singleton** : Instance unique avec GetX
- **AppStore** : Mixin pour les propriétés globales
- **Redémarrage** : Fonction de redémarrage de l'app

### UserController (`lib/store/user_controller.dart`)

- **Tokens** : Gestion des tokens d'authentification
- **Localisation** : Modèle de localisation actuelle
- **État d'authentification** : Propriété `isAuth`

## 🎨 Thème et UI

### Configuration du thème (`lib/config/theme.dart`)

- **Thème clair/sombre** : Support des deux modes
- **Couleurs** : Palette définie dans `constant_colors.dart`
- **Styles** : Typographie dans `style.dart`

### Widgets réutilisables

- **Forms** : Inputs, boutons, options
- **Snackbars** : Notifications utilisateur
- **Bottom sheets** : Modales personnalisées

## 🔧 Services

### AppService (`lib/services/app_service.dart`)

- **Initialisation** : Services au démarrage
- **HTTP Overrides** : Gestion des certificats SSL
- **Contrôleurs** : Initialisation des contrôleurs GetX

### StorageService (`lib/services/storage_services.dart`)

- **Stockage sécurisé** : Données sensibles
- **Stockage local** : Données non sensibles

### AnalyticsService (`lib/services/analitics/analytics_service.dart`)

- **Firebase Analytics** : Suivi des événements
- **Erreurs serveur** : Logging automatique

## 📁 Modules

### Module Application

- **HomePage** : Page principale (actuellement vide)
- **LocationModel** : Modèle de localisation

### Module Authentification

- **LoginView** : Interface de connexion (basique)
- **AuthController** : Contrôleur d'authentification

### Module Onboarding

- Structure prête pour l'onboarding

## 🛠️ Helpers et Utilitaires

### Helpers (`lib/helper/`)

- **DateParser** : Parsing des dates
- **MediaQuery** : Utilitaires responsive
- **Regex** : Expressions régulières
- **Outputs** : Logging et debug

### Input Formatters

- **NumberInputFormatter** : Formatage des nombres
- **TwoDigitInputFormatter** : Formatage à deux chiffres

## 🔄 Fonctionnalités en cours

### Pages à implémenter

- [ ] Page de splash
- [ ] Interface de login complète
- [ ] Page d'accueil avec contenu
- [ ] Navigation bottom bar

### Fonctionnalités à développer

- [ ] Onboarding complet
- [ ] Gestion des profils utilisateur
- [ ] Intégration des cartes (Mapbox)
- [ ] Analytics avancés

## 📝 Notes de développement

### Conventions de code

- **GetX** : Utilisation systématique pour l'état et la navigation
- **Nommage** : PascalCase pour les classes, camelCase pour les variables
- **Structure** : Séparation claire entre vues, contrôleurs et modèles

### Gestion des erreurs

- **Messages en français** : Parsing automatique des erreurs
- **Snackbars** : Affichage des erreurs utilisateur
- **Logging** : Debug en mode développement

### Performance

- **Cache** : Support du cache pour les requêtes GET
- **Lazy loading** : Chargement à la demande
- **Optimisation** : Gestion des timeouts et retry

## 🚀 Démarrage rapide

1. **Installation** : `flutter pub get`
2. **Variables d'environnement** : Créer un fichier `.env`
3. **Lancement** : `flutter run`

## 📊 État actuel

- ✅ Structure de base complète
- ✅ Navigation configurée
- ✅ Authentification préparée
- ✅ API providers fonctionnels
- ✅ Gestion d'état avec GetX
- ⏳ Interfaces utilisateur à développer
- ⏳ Contenu des pages à implémenter

---

_Dernière mise à jour : [Date actuelle]_
_Version : 1.0.0_
