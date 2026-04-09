class AppConfig {
  // API Configuration
  static const String apiBaseUrl =
      'http://10.0.2.2:8000/api/'; // For Android emulator
  // static const String apiBaseUrl = 'http://127.0.0.1:8000/api/'; // For iOS simulator

  // App Configuration
  static const String appName = 'A One GT';
  static const String appVersion = '1.0.0';

  // Environment
  static const bool isProduction = false;
  static const bool enableLogging = true;

  // API Timeouts
  static const int connectionTimeout = 30000; // 30 seconds
  static const int receiveTimeout = 30000; // 30 seconds

  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;

  // Cache
  static const int cacheExpiryMinutes = 30;

  // File Upload
  static const int maxFileSize = 10 * 1024 * 1024; // 10MB
  static const List<String> allowedImageTypes = ['jpg', 'jpeg', 'png', 'gif'];

  // Map Configuration
  static const double defaultLatitude = 25.2048; // Dubai
  static const double defaultLongitude = 55.2708; // Dubai

  // Contact Information
  static const String supportEmail = 'support@aone.com';
  static const String supportPhone = '+971501234567';
  static const String whatsappNumber = '919605455758';

  // Social Media
  static const String facebookUrl = 'https://facebook.com/aonegt';
  static const String instagramUrl = 'https://instagram.com/aonegt';
  static const String twitterUrl = 'https://twitter.com/aonegt';

  // Terms and Privacy
  static const String termsUrl = 'https://aone.com/terms';
  static const String privacyUrl = 'https://aone.com/privacy';

  // Payment Configuration
  static const List<String> supportedPaymentMethods = [
    'card',
    'cash',
    'wallet',
    'bank_transfer',
  ];

  // Delivery Configuration
  static const double freeDeliveryThreshold = 100.0; // AED
  static const double standardDeliveryFee = 15.0; // AED
  static const int standardDeliveryTime = 30; // minutes

  // Currency
  static const String currency = 'AED';
  static const String currencySymbol = 'د.إ';

  // Language
  static const String defaultLanguage = 'en';
  static const List<String> supportedLanguages = ['en', 'ar'];
}
