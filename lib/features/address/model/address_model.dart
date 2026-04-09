class AddressModel {
  final String id;
  final String userId;
  final String name;
  final String phone;
  final String street;
  final String city;
  final String state;
  final String pincode;
  final String country;
  final String type; // 'home', 'work', 'other'
  final bool isDefault;
  final double? latitude;
  final double? longitude;
  final DateTime createdAt;
  final DateTime updatedAt;

  AddressModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.phone,
    required this.street,
    required this.city,
    required this.state,
    required this.pincode,
    required this.country,
    required this.type,
    required this.isDefault,
    this.latitude,
    this.longitude,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id'] ?? '',
      userId: json['user_id'] ?? '',
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      street: json['street'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      pincode: json['pincode'] ?? '',
      country: json['country'] ?? 'UAE',
      type: json['type'] ?? 'home',
      isDefault: json['is_default'] ?? false,
      latitude: json['latitude']?.toDouble(),
      longitude: json['longitude']?.toDouble(),
      createdAt: DateTime.parse(
        json['created_at'] ?? DateTime.now().toIso8601String(),
      ),
      updatedAt: DateTime.parse(
        json['updated_at'] ?? DateTime.now().toIso8601String(),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'name': name,
      'phone': phone,
      'street': street,
      'city': city,
      'state': state,
      'pincode': pincode,
      'country': country,
      'type': type,
      'is_default': isDefault,
      'latitude': latitude,
      'longitude': longitude,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  String get fullAddress => '$street, $city, $state $pincode, $country';

  AddressModel copyWith({
    String? id,
    String? userId,
    String? name,
    String? phone,
    String? street,
    String? city,
    String? state,
    String? pincode,
    String? country,
    String? type,
    bool? isDefault,
    double? latitude,
    double? longitude,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AddressModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      street: street ?? this.street,
      city: city ?? this.city,
      state: state ?? this.state,
      pincode: pincode ?? this.pincode,
      country: country ?? this.country,
      type: type ?? this.type,
      isDefault: isDefault ?? this.isDefault,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class CreateAddressModel {
  final String name;
  final String phone;
  final String street;
  final String city;
  final String state;
  final String pincode;
  final String country;
  final String type;
  final bool isDefault;
  final double? latitude;
  final double? longitude;

  CreateAddressModel({
    required this.name,
    required this.phone,
    required this.street,
    required this.city,
    required this.state,
    required this.pincode,
    required this.country,
    required this.type,
    required this.isDefault,
    this.latitude,
    this.longitude,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'street': street,
      'city': city,
      'state': state,
      'pincode': pincode,
      'country': country,
      'type': type,
      'is_default': isDefault,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}

class UpdateAddressModel {
  final String name;
  final String phone;
  final String street;
  final String city;
  final String state;
  final String pincode;
  final String country;
  final String type;
  final bool isDefault;
  final double? latitude;
  final double? longitude;

  UpdateAddressModel({
    required this.name,
    required this.phone,
    required this.street,
    required this.city,
    required this.state,
    required this.pincode,
    required this.country,
    required this.type,
    required this.isDefault,
    this.latitude,
    this.longitude,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'street': street,
      'city': city,
      'state': state,
      'pincode': pincode,
      'country': country,
      'type': type,
      'is_default': isDefault,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}

class LocationModel {
  final double latitude;
  final double longitude;
  final String? street;
  final String? city;
  final String? state;
  final String? pincode;
  final String? country;

  LocationModel({
    required this.latitude,
    required this.longitude,
    this.street,
    this.city,
    this.state,
    this.pincode,
    this.country,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      latitude: (json['latitude'] ?? 0).toDouble(),
      longitude: (json['longitude'] ?? 0).toDouble(),
      street: json['street'],
      city: json['city'],
      state: json['state'],
      pincode: json['pincode'],
      country: json['country'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'street': street,
      'city': city,
      'state': state,
      'pincode': pincode,
      'country': country,
    };
  }
}
