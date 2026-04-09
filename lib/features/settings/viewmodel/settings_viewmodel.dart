import 'package:a_one_gt/features/settings/model/settings_model.dart';
import 'package:flutter/foundation.dart';

class SettingsViewModel extends ChangeNotifier {
  SettingsModel? _settings;
  bool _isLoading = false;
  String? _error;
  String? _message;

  // Getters
  SettingsModel? get settings => _settings;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String? get message => _message;

  // Setters
  void setSettings(SettingsModel settings) {
    _settings = settings;
    notifyListeners();
  }

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void setError(String? error) {
    _error = error;
    notifyListeners();
  }

  void setMessage(String? message) {
    _message = message;
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }

  void clearMessage() {
    _message = null;
    notifyListeners();
  }

  // Update specific setting
  void updatePushNotifications(bool value) {
    if (_settings != null) {
      _settings = _settings!.copyWith(pushNotifications: value);
      notifyListeners();
    }
  }

  void updateLanguage(String language) {
    if (_settings != null) {
      _settings = _settings!.copyWith(language: language);
      notifyListeners();
    }
  }

  void updateTheme(String theme) {
    if (_settings != null) {
      _settings = _settings!.copyWith(theme: theme);
      notifyListeners();
    }
  }

  void updateLocationServices(bool value) {
    if (_settings != null) {
      _settings = _settings!.copyWith(locationServices: value);
      notifyListeners();
    }
  }

  void updateEmailNotifications(bool value) {
    if (_settings != null) {
      _settings = _settings!.copyWith(emailNotifications: value);
      notifyListeners();
    }
  }

  void updateSmsNotifications(bool value) {
    if (_settings != null) {
      _settings = _settings!.copyWith(smsNotifications: value);
      notifyListeners();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
