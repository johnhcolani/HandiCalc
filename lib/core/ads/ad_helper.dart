import 'dart:io';

class AdHelper {
  // Real Ad Unit IDs from your AdMob console
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-7380986533735423/6172038909'; // Your real banner ad unit ID for Android
    } else if (Platform.isIOS) {
      return 'ca-app-pub-7380986533735423/6172038909'; // Your real banner ad unit ID for iOS (use same or create iOS-specific)
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/1033173712'; // Test interstitial ad unit ID for Android
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/4411468910'; // Test interstitial ad unit ID for iOS
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  static String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/5224354917'; // Test rewarded ad unit ID for Android
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/1712485313'; // Test rewarded ad unit ID for iOS
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }
}