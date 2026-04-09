import 'package:a_one_gt/core/service/api_service.dart';
import 'package:a_one_gt/features/address/model/address_model.dart';
import 'package:a_one_gt/features/address/viewmodel/address_viewmodel.dart';
import 'package:flutter/foundation.dart';

class AddressController {
  final ApiService _apiService = ApiService();
  final AddressViewModel _viewModel = AddressViewModel();

  AddressViewModel get viewModel => _viewModel;

  /// Get all user addresses
  Future<void> getAddresses() async {
    try {
      _viewModel.setLoading(true);

      final response = await _apiService.get('/addresses');

      if (response['success'] == true) {
        final List<dynamic> addressesData = response['data'] ?? [];
        final addresses = addressesData
            .map((json) => AddressModel.fromJson(json))
            .toList();
        _viewModel.setAddresses(addresses);
      } else {
        _viewModel.setError(response['message'] ?? 'Failed to fetch addresses');
      }
    } catch (e) {
      _viewModel.setError('Network error: ${e.toString()}');
      if (kDebugMode) {
        print('AddressController.getAddresses error: $e');
      }
    } finally {
      _viewModel.setLoading(false);
    }
  }

  /// Create new address
  Future<void> createAddress(CreateAddressModel addressData) async {
    try {
      _viewModel.setLoading(true);

      final response = await _apiService.post(
        '/addresses',
        addressData.toJson(),
      );

      if (response['success'] == true) {
        final addressJson = response['data'] ?? {};
        final address = AddressModel.fromJson(addressJson);
        _viewModel.addAddress(address);
        _viewModel.setMessage('Address added successfully');
      } else {
        _viewModel.setError(response['message'] ?? 'Failed to create address');
      }
    } catch (e) {
      _viewModel.setError('Network error: ${e.toString()}');
      if (kDebugMode) {
        print('AddressController.createAddress error: $e');
      }
    } finally {
      _viewModel.setLoading(false);
    }
  }

  /// Update existing address
  Future<void> updateAddress(
    String addressId,
    UpdateAddressModel addressData,
  ) async {
    try {
      _viewModel.setLoading(true);

      final response = await _apiService.put(
        '/addresses/$addressId',
        addressData.toJson(),
      );

      if (response['success'] == true) {
        final addressJson = response['data'] ?? {};
        final address = AddressModel.fromJson(addressJson);
        _viewModel.updateAddress(address);
        _viewModel.setMessage('Address updated successfully');
      } else {
        _viewModel.setError(response['message'] ?? 'Failed to update address');
      }
    } catch (e) {
      _viewModel.setError('Network error: ${e.toString()}');
      if (kDebugMode) {
        print('AddressController.updateAddress error: $e');
      }
    } finally {
      _viewModel.setLoading(false);
    }
  }

  /// Delete address
  Future<void> deleteAddress(String addressId) async {
    try {
      _viewModel.setLoading(true);

      final response = await _apiService.delete('/addresses/$addressId');

      if (response['success'] == true) {
        _viewModel.removeAddress(addressId);
        _viewModel.setMessage('Address deleted successfully');
      } else {
        _viewModel.setError(response['message'] ?? 'Failed to delete address');
      }
    } catch (e) {
      _viewModel.setError('Network error: ${e.toString()}');
      if (kDebugMode) {
        print('AddressController.deleteAddress error: $e');
      }
    } finally {
      _viewModel.setLoading(false);
    }
  }

  /// Set address as default
  Future<void> setDefaultAddress(String addressId) async {
    try {
      _viewModel.setLoading(true);

      final response = await _apiService.put(
        '/addresses/$addressId/default',
        {},
      );

      if (response['success'] == true) {
        _viewModel.setAsDefault(addressId);
        _viewModel.setMessage('Default address updated');
      } else {
        _viewModel.setError(
          response['message'] ?? 'Failed to set default address',
        );
      }
    } catch (e) {
      _viewModel.setError('Network error: ${e.toString()}');
      if (kDebugMode) {
        print('AddressController.setDefaultAddress error: $e');
      }
    } finally {
      _viewModel.setLoading(false);
    }
  }

  /// Get current location
  Future<void> getCurrentLocation() async {
    try {
      _viewModel.setLoading(true);

      final response = await _apiService.get('/location/current');

      if (response['success'] == true) {
        final locationData = response['data'] ?? {};
        final location = LocationModel.fromJson(locationData);
        _viewModel.setCurrentLocation(location);
      } else {
        _viewModel.setError(
          response['message'] ?? 'Failed to get current location',
        );
      }
    } catch (e) {
      _viewModel.setError('Network error: ${e.toString()}');
      if (kDebugMode) {
        print('AddressController.getCurrentLocation error: $e');
      }
    } finally {
      _viewModel.setLoading(false);
    }
  }

  /// Reverse geocode coordinates to address
  Future<void> reverseGeocode(double latitude, double longitude) async {
    try {
      _viewModel.setLoading(true);

      final response = await _apiService.get(
        '/location/reverse?lat=$latitude&lng=$longitude',
      );

      if (response['success'] == true) {
        final locationData = response['data'] ?? {};
        final location = LocationModel.fromJson(locationData);
        _viewModel.setCurrentLocation(location);
      } else {
        _viewModel.setError(
          response['message'] ?? 'Failed to get address from location',
        );
      }
    } catch (e) {
      _viewModel.setError('Network error: ${e.toString()}');
      if (kDebugMode) {
        print('AddressController.reverseGeocode error: $e');
      }
    } finally {
      _viewModel.setLoading(false);
    }
  }

  /// Search addresses
  Future<void> searchAddresses(String query) async {
    try {
      _viewModel.setLoading(true);

      final response = await _apiService.get('/addresses/search?q=$query');

      if (response['success'] == true) {
        final List<dynamic> addressesData = response['data'] ?? [];
        final addresses = addressesData
            .map((json) => AddressModel.fromJson(json))
            .toList();
        _viewModel.setAddresses(addresses);
      } else {
        _viewModel.setError(
          response['message'] ?? 'Failed to search addresses',
        );
      }
    } catch (e) {
      _viewModel.setError('Network error: ${e.toString()}');
      if (kDebugMode) {
        print('AddressController.searchAddresses error: $e');
      }
    } finally {
      _viewModel.setLoading(false);
    }
  }

  /// Select address
  void selectAddress(AddressModel address) {
    _viewModel.setSelectedAddress(address);
  }

  /// Clear selected address
  void clearSelectedAddress() {
    _viewModel.setSelectedAddress(null);
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
