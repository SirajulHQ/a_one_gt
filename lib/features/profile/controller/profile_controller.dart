import 'package:a_one_gt/core/service/api_service.dart';
import 'package:a_one_gt/features/profile/model/profile_model.dart';
import 'package:a_one_gt/features/profile/viewmodel/profile_viewmodel.dart';
import 'package:flutter/foundation.dart';

class ProfileController {
  final ApiService _apiService = ApiService();
  final ProfileViewModel _viewModel = ProfileViewModel();

  ProfileViewModel get viewModel => _viewModel;

  /// Get user profile
  Future<void> getUserProfile() async {
    try {
      _viewModel.setLoading(true);

      final response = await _apiService.get('/user/profile');

      if (response['success'] == true) {
        final profileData = response['data'] ?? {};
        final profile = UserProfileModel.fromJson(profileData);
        _viewModel.setUserProfile(profile);
      } else {
        _viewModel.setError(response['message'] ?? 'Failed to fetch profile');
      }
    } catch (e) {
      _viewModel.setError('Network error: ${e.toString()}');
      if (kDebugMode) {
        debugPrint('ProfileController.getUserProfile error: $e');
      }
    } finally {
      _viewModel.setLoading(false);
    }
  }

  /// Update user profile
  Future<void> updateUserProfile(UpdateProfileModel profileData) async {
    try {
      _viewModel.setLoading(true);

      final response = await _apiService.put(
        '/user/profile',
        profileData.toJson(),
      );

      if (response['success'] == true) {
        final updatedProfileData = response['data'] ?? {};
        final updatedProfile = UserProfileModel.fromJson(updatedProfileData);
        _viewModel.setUserProfile(updatedProfile);
        _viewModel.setMessage('Profile updated successfully');
      } else {
        _viewModel.setError(response['message'] ?? 'Failed to update profile');
      }
    } catch (e) {
      _viewModel.setError('Network error: ${e.toString()}');
      if (kDebugMode) {
        debugPrint('ProfileController.updateUserProfile error: $e');
      }
    } finally {
      _viewModel.setLoading(false);
    }
  }

  /// Upload profile avatar
  Future<void> uploadAvatar(String imagePath) async {
    try {
      _viewModel.setLoading(true);

      final response = await _apiService.uploadFile('/user/avatar', imagePath);

      if (response['success'] == true) {
        final avatarUrl = response['data']['avatar_url'] ?? '';
        _viewModel.updateAvatar(avatarUrl);
        _viewModel.setMessage('Avatar updated successfully');
      } else {
        _viewModel.setError(response['message'] ?? 'Failed to upload avatar');
      }
    } catch (e) {
      _viewModel.setError('Network error: ${e.toString()}');
      if (kDebugMode) {
        debugPrint('ProfileController.uploadAvatar error: $e');
      }
    } finally {
      _viewModel.setLoading(false);
    }
  }

  /// Verify email
  Future<void> verifyEmail(String verificationCode) async {
    try {
      _viewModel.setLoading(true);

      final response = await _apiService.post('/user/verify-email', {
        'verification_code': verificationCode,
      });

      if (response['success'] == true) {
        _viewModel.updateEmailVerification(true);
        _viewModel.setMessage('Email verified successfully');
      } else {
        _viewModel.setError(response['message'] ?? 'Failed to verify email');
      }
    } catch (e) {
      _viewModel.setError('Network error: ${e.toString()}');
      if (kDebugMode) {
        debugPrint('ProfileController.verifyEmail error: $e');
      }
    } finally {
      _viewModel.setLoading(false);
    }
  }

  /// Send email verification
  Future<void> sendEmailVerification() async {
    try {
      _viewModel.setLoading(true);

      final response = await _apiService.post(
        '/user/send-email-verification',
        {},
      );

      if (response['success'] == true) {
        _viewModel.setMessage('Verification email sent successfully');
      } else {
        _viewModel.setError(
          response['message'] ?? 'Failed to send verification email',
        );
      }
    } catch (e) {
      _viewModel.setError('Network error: ${e.toString()}');
      if (kDebugMode) {
        debugPrint('ProfileController.sendEmailVerification error: $e');
      }
    } finally {
      _viewModel.setLoading(false);
    }
  }

  /// Verify phone
  Future<void> verifyPhone(String verificationCode) async {
    try {
      _viewModel.setLoading(true);

      final response = await _apiService.post('/user/verify-phone', {
        'verification_code': verificationCode,
      });

      if (response['success'] == true) {
        _viewModel.updatePhoneVerification(true);
        _viewModel.setMessage('Phone verified successfully');
      } else {
        _viewModel.setError(response['message'] ?? 'Failed to verify phone');
      }
    } catch (e) {
      _viewModel.setError('Network error: ${e.toString()}');
      if (kDebugMode) {
        debugPrint('ProfileController.verifyPhone error: $e');
      }
    } finally {
      _viewModel.setLoading(false);
    }
  }

  /// Send phone verification
  Future<void> sendPhoneVerification(String phoneNumber) async {
    try {
      _viewModel.setLoading(true);

      final response = await _apiService.post('/user/send-phone-verification', {
        'phone': phoneNumber,
      });

      if (response['success'] == true) {
        _viewModel.setMessage('Verification SMS sent successfully');
      } else {
        _viewModel.setError(
          response['message'] ?? 'Failed to send verification SMS',
        );
      }
    } catch (e) {
      _viewModel.setError('Network error: ${e.toString()}');
      if (kDebugMode) {
        debugPrint('ProfileController.sendPhoneVerification error: $e');
      }
    } finally {
      _viewModel.setLoading(false);
    }
  }

  /// Logout user
  Future<void> logout() async {
    try {
      _viewModel.setLoading(true);

      final response = await _apiService.post('/auth/logout', {});

      if (response['success'] == true) {
        // Clear local data
        _viewModel.setUserProfile(
          UserProfileModel(
            id: '',
            name: '',
            email: '',
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
            isEmailVerified: false,
            isPhoneVerified: false,
          ),
        );
        _viewModel.setMessage('Logged out successfully');
      } else {
        _viewModel.setError(response['message'] ?? 'Failed to logout');
      }
    } catch (e) {
      _viewModel.setError('Network error: ${e.toString()}');
      if (kDebugMode) {
        debugPrint('ProfileController.logout error: $e');
      }
    } finally {
      _viewModel.setLoading(false);
    }
  }

  /// Clear error
  void clearError() {
    _viewModel.clearError();
  }

  /// Clear message
  void clearMessage() {
    _viewModel.clearMessage();
  }

  /// Dispose resources
  void dispose() {
    _viewModel.dispose();
  }
}
