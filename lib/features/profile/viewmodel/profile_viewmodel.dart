import 'package:a_one_gt/features/profile/model/profile_model.dart';
import 'package:flutter/foundation.dart';

class ProfileViewModel extends ChangeNotifier {
  UserProfileModel? _userProfile;
  bool _isLoading = false;
  String? _error;
  String? _message;

  // Getters
  UserProfileModel? get userProfile => _userProfile;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String? get message => _message;

  // Setters
  void setUserProfile(UserProfileModel profile) {
    _userProfile = profile;
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

  // Update profile fields
  void updateProfile(UserProfileModel updatedProfile) {
    _userProfile = updatedProfile;
    notifyListeners();
  }

  void updateAvatar(String avatarUrl) {
    if (_userProfile != null) {
      _userProfile = _userProfile!.copyWith(avatar: avatarUrl);
      notifyListeners();
    }
  }

  void updateDefaultAddress(AddressModel address) {
    if (_userProfile != null) {
      _userProfile = _userProfile!.copyWith(defaultAddress: address);
      notifyListeners();
    }
  }

  void updateEmailVerification(bool isVerified) {
    if (_userProfile != null) {
      _userProfile = _userProfile!.copyWith(isEmailVerified: isVerified);
      notifyListeners();
    }
  }

  void updatePhoneVerification(bool isVerified) {
    if (_userProfile != null) {
      _userProfile = _userProfile!.copyWith(isPhoneVerified: isVerified);
      notifyListeners();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
