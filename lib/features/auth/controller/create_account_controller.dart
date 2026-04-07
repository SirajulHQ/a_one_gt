import 'package:a_one_gt/features/auth/model/create_account_model.dart';
import 'package:a_one_gt/features/auth/viewmodel/create_account_viewmodel.dart';
import 'package:flutter/material.dart';
import 'dart:developer';

class CreateAccountController extends ChangeNotifier {
  final CreateAccountViewmodel _viewModel = CreateAccountViewmodel();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  CreateAccountModel? _registerResponse;
  CreateAccountModel? get registerResponse => _registerResponse;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    log('🚀 [Controller] Starting registration process');
    log(
      '📝 [Controller] User data: firstName=$firstName, lastName=$lastName, email=$email',
    );

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    log('⏳ [Controller] Loading state set to true, UI notified');

    try {
      log('📡 [Controller] Calling viewModel.registerUser...');
      _registerResponse = await _viewModel.registerUser(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
      );
      log('✅ [Controller] Registration successful!');
      log('📦 [Controller] Response: ${_registerResponse?.toJson()}');
    } catch (e) {
      log('❌ [Controller] Registration failed with error: $e');
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
      log(
        '🏁 [Controller] Registration process completed, loading state set to false',
      );
    }
  }

  void clearData() {
    log('🧹 [Controller] Clearing registration data');
    _registerResponse = null;
    _errorMessage = null;
    notifyListeners();
    log('✨ [Controller] Data cleared, UI notified');
  }
}
