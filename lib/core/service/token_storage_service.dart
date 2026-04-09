// Simple token storage service using in-memory storage for now
// In production, this should use flutter_secure_storage or shared_preferences

class TokenStorageService {
  static String? _accessToken;
  static String? _refreshToken;

  static Future<void> saveTokens(
    String accessToken,
    String refreshToken,
  ) async {
    _accessToken = accessToken;
    _refreshToken = refreshToken;
  }

  static Future<String?> getAccessToken() async {
    return _accessToken;
  }

  static Future<String?> getRefreshToken() async {
    return _refreshToken;
  }

  static Future<void> clearTokens() async {
    _accessToken = null;
    _refreshToken = null;
  }

  // Check if user is logged in
  static bool get isLoggedIn => _accessToken != null;

  // Get token for API headers
  static String? get authHeader =>
      _accessToken != null ? 'Bearer $_accessToken' : null;
}
