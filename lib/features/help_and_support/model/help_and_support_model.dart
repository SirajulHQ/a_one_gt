class SupportOptionModel {
  final String id;
  final String title;
  final String description;
  final String icon;
  final String type; // 'chat', 'call', 'email'
  final String? contactInfo;
  final bool isAvailable;

  SupportOptionModel({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.type,
    this.contactInfo,
    required this.isAvailable,
  });

  factory SupportOptionModel.fromJson(Map<String, dynamic> json) {
    return SupportOptionModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      icon: json['icon'] ?? '',
      type: json['type'] ?? '',
      contactInfo: json['contact_info'],
      isAvailable: json['is_available'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'icon': icon,
      'type': type,
      'contact_info': contactInfo,
      'is_available': isAvailable,
    };
  }
}

class FaqModel {
  final String id;
  final String question;
  final String answer;
  final String category;
  final int order;
  final bool isExpanded;

  FaqModel({
    required this.id,
    required this.question,
    required this.answer,
    required this.category,
    required this.order,
    this.isExpanded = false,
  });

  factory FaqModel.fromJson(Map<String, dynamic> json) {
    return FaqModel(
      id: json['id'] ?? '',
      question: json['question'] ?? '',
      answer: json['answer'] ?? '',
      category: json['category'] ?? 'general',
      order: json['order'] ?? 0,
      isExpanded: json['is_expanded'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'answer': answer,
      'category': category,
      'order': order,
      'is_expanded': isExpanded,
    };
  }

  FaqModel copyWith({
    String? id,
    String? question,
    String? answer,
    String? category,
    int? order,
    bool? isExpanded,
  }) {
    return FaqModel(
      id: id ?? this.id,
      question: question ?? this.question,
      answer: answer ?? this.answer,
      category: category ?? this.category,
      order: order ?? this.order,
      isExpanded: isExpanded ?? this.isExpanded,
    );
  }
}

class ContactInfoModel {
  final String phone;
  final String email;
  final String whatsapp;
  final String address;
  final Map<String, String> socialMedia;
  final Map<String, String> workingHours;

  ContactInfoModel({
    required this.phone,
    required this.email,
    required this.whatsapp,
    required this.address,
    required this.socialMedia,
    required this.workingHours,
  });

  factory ContactInfoModel.fromJson(Map<String, dynamic> json) {
    return ContactInfoModel(
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
      whatsapp: json['whatsapp'] ?? '',
      address: json['address'] ?? '',
      socialMedia: Map<String, String>.from(json['social_media'] ?? {}),
      workingHours: Map<String, String>.from(json['working_hours'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
      'email': email,
      'whatsapp': whatsapp,
      'address': address,
      'social_media': socialMedia,
      'working_hours': workingHours,
    };
  }
}

class SupportTicketModel {
  final String subject;
  final String description;
  final String category;
  final String priority; // 'low', 'medium', 'high'
  final List<String>? attachments;

  SupportTicketModel({
    required this.subject,
    required this.description,
    required this.category,
    required this.priority,
    this.attachments,
  });

  Map<String, dynamic> toJson() {
    return {
      'subject': subject,
      'description': description,
      'category': category,
      'priority': priority,
      'attachments': attachments,
    };
  }
}
