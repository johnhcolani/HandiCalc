# HandiCalc - Professional Fraction Calculator

<div align="center">
  <img src="assets/images/Melody.jpg" alt="HandiCalc Logo" width="200"/>
  
  [![Flutter](https://img.shields.io/badge/Flutter-3.5.4-blue.svg)](https://flutter.dev/)
  [![Dart](https://img.shields.io/badge/Dart-3.0+-blue.svg)](https://dart.dev/)
  [![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
  [![Google AdMob](https://img.shields.io/badge/AdMob-Integrated-orange.svg)](https://admob.google.com/)
</div>

## 📱 About HandiCalc

HandiCalc is a professional-grade fraction calculator designed for construction workers, engineers, students, and anyone who works with precise measurements. Built with Flutter, it offers lightning-fast calculations with a beautiful, intuitive interface.

### ✨ Key Features

- **🔢 Advanced Fraction Mathematics**: Add, subtract, multiply, and divide fractions
- **📐 Mixed Number Support**: Seamless handling of whole numbers and fractions
- **🔄 Decimal Conversion**: Instant conversion between fractions and decimals
- **📱 Professional Design**: Clean, dark-themed interface optimized for productivity
- **📏 Construction Ready**: Perfect for measurements in 1/16", 1/8", 1/4" increments
- **🎓 Educational Tool**: Excellent for students learning fraction mathematics
- **💰 Monetization Ready**: Google AdMob integration with premium upgrade option

## 🚀 Getting Started

### Prerequisites

- Flutter SDK 3.5.4 or higher
- Dart 3.0 or higher
- Android Studio / VS Code
- Git

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/johnhcolani/HandiCalc.git
   cd HandiCalc
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Building for Release

**Android:**
```bash
flutter build apk --release
flutter build appbundle --release
```

**iOS:**
```bash
flutter build ios --release
```

## 🏗️ Project Structure

```
lib/
├── core/
│   └── ads/                    # Google AdMob integration
├── features/
│   ├── calculator/
│   │   ├── domain/            # Business logic and entities
│   │   └── presentation/      # UI components and state management
│   └── splash_feature/        # Splash screen functionality
└── main.dart                  # App entry point
```

## 📊 Monetization Strategy

### Free Version (Ad-Supported)
- Full calculator functionality
- Google AdMob banner ads
- "Remove Ads" purchase option

### Premium Features
- Ad-free experience
- Priority support
- Beta feature access
- One-time purchase: $2.99

## 🛠️ Technologies Used

- **Framework**: Flutter 3.5.4
- **State Management**: Flutter Bloc
- **Ads**: Google Mobile Ads
- **UI**: Flutter ScreenUtil for responsive design
- **Mathematics**: Custom fraction calculation engine
- **Architecture**: Clean Architecture with BLoC pattern

## 📱 Supported Platforms

- ✅ Android 5.0+ (API level 21+)
- ✅ iOS 12.0+
- ✅ Responsive design for tablets and phones

## 🎯 Target Audience

- **Construction Workers**: Precise measurement calculations
- **Students & Educators**: Learning fraction mathematics
- **Engineers & Architects**: Professional calculations
- **Chefs & Bakers**: Recipe conversions
- **DIY Enthusiasts**: Home improvement projects

## 📈 App Store Information

- **Category**: Productivity / Education / Utilities
- **Content Rating**: Everyone
- **Keywords**: fraction calculator, construction calculator, measurement tool, math calculator

## 🔧 Development Setup

### Google AdMob Configuration

1. Replace test Ad Unit IDs in `lib/core/ads/ad_helper.dart`
2. Update App IDs in:
   - `android/app/src/main/AndroidManifest.xml`
   - `ios/Runner/Info.plist`

### App Signing (Android)

1. Generate signing key
2. Configure `android/app/build.gradle`
3. Create `android/key.properties`

## 📋 Pre-Launch Checklist

- [ ] Update app version and build number
- [ ] Configure proper app icons
- [ ] Set up Google Play Console / App Store Connect
- [ ] Create privacy policy
- [ ] Prepare app screenshots
- [ ] Test on multiple devices
- [ ] Configure app signing

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 📞 Contact

**John Colani**
- GitHub: [@johnhcolani](https://github.com/johnhcolani)
- Email: your-email@example.com

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Google AdMob for monetization platform
- The open-source community for inspiration

---

<div align="center">
  <strong>⭐ If you found this project helpful, please give it a star! ⭐</strong>
</div>