# SmartScan - Intelligent Object Recognition App

[![Flutter](https://img.shields.io/badge/Flutter-3.19-blue)](https://flutter.dev)
[![Firebase](https://img.shields.io/badge/Firebase-11.6.0-orange)](https://firebase.google.com)
[![License](https://img.shields.io/badge/License-MIT-green)](https://opensource.org/licenses/MIT)

A Flutter application that combines Firebase authentication with ML-powered object recognition and Wikipedia integration, built using MVVM architecture.

<img src="screenshots/demo.gif" width="300" alt="App Demo">

## Features

- 🔒 Firebase Authentication (Email/Password)
- 📷 Real-time object detection using Google ML Kit
- 📚 Wikipedia integration for detailed information
- 🏗️ Clean MVVM Architecture with Provider state management
- 📱 Responsive UI with error handling and loading states
- 🔄 Seamless navigation between screens



## Installation

1. **Clone the repository**
```bash
git clone https://github.com/yourusername/smartscan-flutter.git
cd smartscan-flutter
```

2. **Setup Firebase**
- Create a new Firebase project at [Firebase Console](https://console.firebase.google.com)
- Add Android/iOS apps and download configuration files
- Place `google-services.json` (Android) and `GoogleService-Info.plist` (iOS) in respective directories

3. **Install dependencies**
```bash
flutter pub get
```

4. **Run the app**
```bash
flutter run
```

## Configuration

### Firebase Setup
1. Enable Email/Password authentication in Firebase Console
2. For Android:
   - Add SHA-1 fingerprint in Project Settings
3. For iOS:
   - Enable Firebase SDK in Podfile
   - Add camera permissions in `Info.plist`

### Environment Requirements
- Flutter 3.19 or newer
- Dart 3.3 or newer
- Android Studio/Xcode for platform-specific builds

## Dependencies

| Package | Usage |
|---------|-------|
| [firebase_auth](https://pub.dev/packages/firebase_auth) | Firebase authentication |
| [google_ml_kit](https://pub.dev/packages/google_ml_kit) | ML object detection |
| [camera](https://pub.dev/packages/camera) | Camera functionality |
| [provider](https://pub.dev/packages/provider) | State management |
| [http](https://pub.dev/packages/http) | Wikipedia API calls |

## Contributing

Contributions are welcome! Please follow these steps:
1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

Distributed under the MIT License. See `LICENSE` for more information.

## Acknowledgments

- Google ML Kit for object detection capabilities
- Firebase for backend services
- Wikipedia for information API
- Flutter community for awesome packages

## Roadmap

- [ ] Add social login (Google, Apple)
- [ ] Implement scan history
- [ ] Add barcode/QR code scanning
- [ ] Introduce image editing before analysis
- [ ] Implement proper error logging
```

Create a `screenshots` directory in your project root and add actual screenshots named:
- `auth.jpg`
- `home.jpg`
- `scan.jpg`
- `result.jpg`
- `demo.gif` (optional animated demo)

You might also want to add:
1. A `LICENSE` file
2. `.gitignore` for Flutter projects
3. GitHub issue templates
4. GitHub Actions for CI/CD

Would you like me to provide any of these additional files or modify any part of the README?
