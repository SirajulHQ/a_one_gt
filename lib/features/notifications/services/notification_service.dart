import 'package:flutter/foundation.dart';
import '../model/notification_model.dart';
import '../data/notification_dummy_data.dart';

class NotificationService extends ChangeNotifier {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal() {
    _initializeNotifications();
  }

  List<NotificationModel> _notifications = [];

  List<NotificationModel> get notifications =>
      List.unmodifiable(_notifications);

  List<NotificationModel> get sortedNotifications {
    final sorted = List<NotificationModel>.from(_notifications);
    sorted.sort((a, b) {
      if (a.isRead != b.isRead) {
        return a.isRead ? 1 : -1; // Unread first
      }
      // If both have same read status, maintain original order (newest first)
      return _notifications.indexOf(a).compareTo(_notifications.indexOf(b));
    });
    return sorted;
  }

  int get unreadCount => _notifications.where((n) => !n.isRead).length;

  void _initializeNotifications() {
    _notifications = List.from(dummyNotifications);
  }

  void markAsRead(String notificationId) {
    final index = _notifications.indexWhere((n) => n.id == notificationId);
    if (index != -1 && !_notifications[index].isRead) {
      _notifications[index] = NotificationModel(
        id: _notifications[index].id,
        title: _notifications[index].title,
        subtitle: _notifications[index].subtitle,
        time: _notifications[index].time,
        type: _notifications[index].type,
        isRead: true,
        data: _notifications[index].data,
      );
      notifyListeners();
    }
  }

  void markAllAsRead() {
    bool hasUnread = _notifications.any((n) => !n.isRead);
    if (hasUnread) {
      _notifications = _notifications
          .map(
            (notification) => NotificationModel(
              id: notification.id,
              title: notification.title,
              subtitle: notification.subtitle,
              time: notification.time,
              type: notification.type,
              isRead: true,
              data: notification.data,
            ),
          )
          .toList();
      notifyListeners();
    }
  }

  void addNotification(NotificationModel notification) {
    _notifications.insert(0, notification); // Add to beginning (newest first)
    notifyListeners();
  }

  // Helper method to create and add a notification easily
  void addSimpleNotification({
    required String title,
    required String subtitle,
    NotificationType type = NotificationType.general,
    Map<String, dynamic>? data,
  }) {
    final notification = NotificationModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      subtitle: subtitle,
      time: "Just now",
      type: type,
      isRead: false,
      data: data,
    );
    addNotification(notification);
  }

  void removeNotification(String notificationId) {
    _notifications.removeWhere((n) => n.id == notificationId);
    notifyListeners();
  }
}
