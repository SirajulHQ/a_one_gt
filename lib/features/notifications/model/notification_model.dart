class NotificationModel {
  final String id;
  final String title;
  final String subtitle;
  final String time;
  final NotificationType type;
  final bool isRead;
  final Map<String, dynamic>? data;

  NotificationModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.type,
    this.isRead = false,
    this.data,
  });
}

enum NotificationType { offer, points, general }

class OfferModel {
  final String id;
  final String title;
  final String description;
  final String discount;
  final String validUntil;
  final String color;
  final bool isActive;

  OfferModel({
    required this.id,
    required this.title,
    required this.description,
    required this.discount,
    required this.validUntil,
    required this.color,
    this.isActive = true,
  });
}

class PointsHistoryModel {
  final String id;
  final String title;
  final String subtitle;
  final int points;
  final String time;
  final bool isEarned;
  final String? orderId;

  PointsHistoryModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.points,
    required this.time,
    required this.isEarned,
    this.orderId,
  });
}
