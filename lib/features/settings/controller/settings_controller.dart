import 'package:a_one_gt/core/service/api_service.dart';
import 'package:a_one_gt/features/settings/model/settings_model.dart';
import 'package:a_one_gt/features/settings/viewmodel/settings_viewmodel.dart';
import 'package:flutter/foundation.dart';

class SettingsController {
  final ApiService _apiService = ApiService();
  final SettingsViewModel _viewModel = SettingsViewModel();

  SettingsViewModel get viewModel => _viewModel;

  /// Get user settings
  Future<void> getSettings() async {
    try {
      _viewModel.setLoading(true);

      final response = await _apiService.get('/user/settings');

      if (response['success'] == true) {
        final settingsData = response['data'] ?? {};
        final settings = SettingsModel.fromJson(settingsData);
        _viewModel.setSettings(settings);
      } else {
        _viewModel.setError(response['message'] ?? 'Failed to fetch settings');
      }
    } catch (e) {
      _viewModel.setError('Network error: ${e.toString()}');
      if (kDebugMode) {
        debugPrint('SettingsController.getSettings error: $e');
      }
    } finally {
      _viewModel.setLoading(false);
    }
  }

  /// Update settings
  Future<void> updateSettings(SettingsModel settings) async {
    try {
      _viewModel.setLoading(true);

      final response = await _apiService.put(
        '/user/settings',
        settings.toJson(),
      );

      if (response['success'] == true) {
        _viewModel.setSettings(settings);
        _viewModel.setMessage('Settings updated successfully');
      } else {
        _viewModel.setError(response['message'] ?? 'Failed to update settings');
      }
    } catch (e) {
      _viewModel.setError('Network error: ${e.toString()}');
      if (kDebugMode) {
        debugPrint('SettingsController.updateSettings error: $e');
      }
    } finally {
      _viewModel.setLoading(false);
    }
  }

  /// Update push notifications
  Future<void> updatePushNotifications(bool enabled) async {
    try {
      _viewModel.setLoading(true);

      final response = await _apiService.put('/user/settings/notifications', {
        'push_notifications': enabled,
      });

      if (response['success'] == true) {
        _viewModel.updatePushNotifications(enabled);
        _viewModel.setMessage('Notification settings updated');
      } else {
        _viewModel.setError(
          response['message'] ?? 'Failed to update notifications',
        );
      }
    } catch (e) {
      _viewModel.setError('Network error: ${e.toString()}');
      if (kDebugMode) {
        debugPrint('SettingsController.updatePushNotifications error: $e');
      }
    } finally {
      _viewModel.setLoading(false);
    }
  }

  /// Change password
  Future<void> changePassword(ChangePasswordModel passwordData) async {
    try {
      _viewModel.setLoading(true);

      final response = await _apiService.post(
        '/user/change-password',
        passwordData.toJson(),
      );

      if (response['success'] == true) {
        _viewModel.setMessage('Password changed successfully');
      } else {
        _viewModel.setError(response['message'] ?? 'Failed to change password');
      }
    } catch (e) {
      _viewModel.setError('Network error: ${e.toString()}');
      if (kDebugMode) {
        debugPrint('SettingsController.changePassword error: $e');
      }
    } finally {
      _viewModel.setLoading(false);
    }
  }

  /// Deactivate account
  Future<void> deactivateAccount(AccountActionModel actionData) async {
    try {
      _viewModel.setLoading(true);

      final response = await _apiService.post(
        '/user/deactivate',
        actionData.toJson(),
      );

      if (response['success'] == true) {
        _viewModel.setMessage('Account deactivated successfully');
      } else {
        _viewModel.setError(
          response['message'] ?? 'Failed to deactivate account',
        );
      }
    } catch (e) {
      _viewModel.setError('Network error: ${e.toString()}');
      if (kDebugMode) {
        debugPrint('SettingsController.deactivateAccount error: $e');
      }
    } finally {
      _viewModel.setLoading(false);
    }
  }

  /// Delete account
  Future<void> deleteAccount(AccountActionModel actionData) async {
    try {
      _viewModel.setLoading(true);

      final response = await _apiService.delete(
        '/user/account',
        actionData.toJson(),
      );

      if (response['success'] == true) {
        _viewModel.setMessage('Account deleted successfully');
      } else {
        _viewModel.setError(response['message'] ?? 'Failed to delete account');
      }
    } catch (e) {
      _viewModel.setError('Network error: ${e.toString()}');
      if (kDebugMode) {
        debugPrint('SettingsController.deleteAccount error: $e');
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
