# Flutter Base Structure

A Flutter project with a modular architecture based on GetX for state management and navigation.

## Getting Started

This project is a starting point for a Flutter application.

### Prerequisites

- Flutter SDK (^3.6.0)
- Dart SDK
- Android Studio / VS Code
- Git

### Installation

1. Clone the repository

```bash
git clone <repository-url>
cd flutterbasestructure
```

2. Install dependencies

```bash
flutter pub get
```

3. Create environment file

```bash
cp .env.example .env
# Edit .env with your API keys and URLs
```

4. Run the application

```bash
flutter run
```

## Project Structure

```
lib/
├── config/                 # Global configuration
├── helper/                 # Utilities and helpers
├── modules/                # Functional modules
│   ├── application/        # Main app module
│   ├── authentification/   # Authentication module
│   └── onbording/         # Onboarding module
├── navigation/             # Navigation management
├── provider/              # API providers
├── services/              # Services (storage, analytics)
├── store/                 # GetX state controllers
└── widget_components/     # Reusable widgets
```

## Features

- ✅ Modular architecture with GetX
- ✅ Authentication system with JWT
- ✅ API integration with automatic token refresh
- ✅ Responsive design
- ✅ Localization (French)
- ✅ Secure storage
- ✅ Analytics integration

## Dependencies

### Core

- `get: ^4.6.6` - State management and navigation
- `http: ^1.2.2` - HTTP requests
- `jwt_decoder: ^2.0.1` - JWT token handling

### UI/UX

- `flutter_spinkit: ^5.2.1` - Loading indicators
- `google_fonts: ^6.2.1` - Custom fonts
- `flutter_screenutil: ^5.9.3` - Responsive design

### Storage & Security

- `flutter_secure_storage: ^9.2.4` - Secure storage
- `get_storage: ^2.1.1` - Local storage

### Analytics & Services

- `firebase_analytics: ^12.0.0` - Analytics
- `country_picker: ^2.0.27` - Country selection

## Environment Variables

Create a `.env` file in the root directory:

```env
# API Configuration
BASE_URL_PROD=https://your-api.com
BASE_URL_DEV=https://dev-api.com

# API Keys
GOOGLE_API_KEY=your_google_api_key
MAPBOX_API_KEY=your_mapbox_api_key
```

## Build & Deploy

### Android

```bash
flutter build apk --release
```

### iOS

```bash
flutter build ios --release
```

### Web

```bash
flutter build web --release
```

## Testing

```bash
flutter test
```

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Documentation

For detailed project documentation, see [PROJECT_DOCUMENTATION.md](PROJECT_DOCUMENTATION.md)

## Support

If you have any questions or need help, please open an issue in the repository.

---

**Version:** 1.0.0  
**Last Updated:** 2024
# flutter-base-project
