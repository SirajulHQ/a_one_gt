class SettingsModel {
  final bool pushNotifications;
  final String language;
  final String theme;
  final bool locationServices;
  final bool emailNotifications;
  final bool smsNotifications;

  SettingsModel({
    required this.pushNotifications,
    required this.language,
    required this.theme,
    required this.locationServices,
    required this.emailNotifications,
    required this.smsNotifications,
  });

  factory SettingsModel.fromJson(Map<String, dynamic> json) {
    return SettingsModel(
      pushNotifications: json['push_notifications'] ?? true,
      language: json['language'] ?? 'en',
      theme: json['theme'] ?? 'light',
      locationServices: json['location_services'] ?? true,
      emailNotifications: json['email_notifications'] ?? true,
      smsNotifications: json['sms_notifications'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'push_notifications': pushNotifications,
      'language': language,
      'theme': theme,
      'location_services': locationServices,
      'email_notifications': emailNotifications,
      'sms_notifications': smsNotifications,
    };
  }

  SettingsModel copyWith({
    bool? pushNotifications,
    String? language,
    String? theme,
    bool? locationServices,
    bool? emailNotifications,
    bool? smsNotifications,
  }) {
    return SettingsModel(
      pushNotifications: pushNotifications ?? this.pushNotifications,
      language: language ?? this.language,
      theme: theme ?? this.theme,
      locationServices: locationServices ?? this.locationServices,
      emailNotifications: emailNotifications ?? this.emailNotifications,
      smsNotifications: smsNotifications ?? this.smsNotifications,
    );
  }
}

class ChangePasswordModel {
  final String currentPassword;
  final String newPassword;
  final String confirmPassword;

  ChangePasswordModel({
    required this.currentPassword,
    required this.newPassword,
    required this.confirmPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      'current_password': currentPassword,
      'new_password': newPassword,
      'confirm_password': confirmPassword,
    };
  }
}

class AccountActionModel {
  final String reason;
  final String? additionalInfo;

  AccountActionModel({required this.reason, this.additionalInfo});

  Map<String, dynamic> toJson() {
    return {'reason': reason, 'additional_info': additionalInfo};
  }
}
