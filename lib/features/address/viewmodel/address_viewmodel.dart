import 'package:a_one_gt/features/address/model/address_model.dart';
import 'package:flutter/foundation.dart';

class AddressViewModel extends ChangeNotifier {
  List<AddressModel> _addresses = [];
  AddressModel? _selectedAddress;
  AddressModel? _defaultAddress;
  LocationModel? _currentLocation;
  bool _isLoading = false;
  String? _error;
  String? _message;

  // Getters
  List<AddressModel> get addresses => _addresses;
  AddressModel? get selectedAddress => _selectedAddress;
  AddressModel? get defaultAddress => _defaultAddress;
  LocationModel? get currentLocation => _currentLocation;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String? get message => _message;

  // Setters
  void setAddresses(List<AddressModel> addresses) {
    _addresses = addresses;
    _updateDefaultAddress();
    notifyListeners();
  }

  void setSelectedAddress(AddressModel? address) {
    _selectedAddress = address;
    notifyListeners();
  }

  void setCurrentLocation(LocationModel? location) {
    _currentLocation = location;
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

  // Add new address
  void addAddress(AddressModel address) {
    _addresses.add(address);
    _updateDefaultAddress();
    notifyListeners();
  }

  // Update existing address
  void updateAddress(AddressModel updatedAddress) {
    final index = _addresses.indexWhere((addr) => addr.id == updatedAddress.id);
    if (index != -1) {
      _addresses[index] = updatedAddress;
      _updateDefaultAddress();
      notifyListeners();
    }
  }

  // Remove address
  void removeAddress(String addressId) {
    _addresses.removeWhere((addr) => addr.id == addressId);
    _updateDefaultAddress();

    // If selected address was removed, clear selection
    if (_selectedAddress?.id == addressId) {
      _selectedAddress = null;
    }

    notifyListeners();
  }

  // Set address as default
  void setAsDefault(String addressId) {
    // First, set all addresses as non-default
    _addresses = _addresses
        .map((addr) => addr.copyWith(isDefault: addr.id == addressId))
        .toList();

    _updateDefaultAddress();
    notifyListeners();
  }

  // Update default address reference
  void _updateDefaultAddress() {
    try {
      _defaultAddress = _addresses.firstWhere((addr) => addr.isDefault);
    } catch (e) {
      _defaultAddress = null;
    }
  }

  // Get addresses by type
  List<AddressModel> getAddressesByType(String type) {
    return _addresses.where((addr) => addr.type == type).toList();
  }

  // Get address by ID
  AddressModel? getAddressById(String id) {
    try {
      return _addresses.firstWhere((addr) => addr.id == id);
    } catch (e) {
      return null;
    }
  }

  // Check if address exists
  bool hasAddress(String id) {
    return _addresses.any((addr) => addr.id == id);
  }

  // Get address count
  int get addressCount => _addresses.length;

  @override
  void dispose() {
    super.dispose();
  }
}
