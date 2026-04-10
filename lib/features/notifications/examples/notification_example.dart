import 'package:flutter/material.dart';
import '../services/notification_service.dart';
import '../model/notification_model.dart';

/// Example of how to use the NotificationService from anywhere in the app
class NotificationExample {
  static final NotificationService _notificationService = NotificationService();

  /// Example: Add a notification when an order is delivered
  static void notifyOrderDelivered(String orderId) {
    _notificationService.addSimpleNotification(
      title: "Order Delivered!",
      subtitle: "Your order $orderId has been delivered successfully",
      type: NotificationType.general,
      data: {"orderId": orderId},
    );
  }

  /// Example: Add a notification when points are earned
  static void notifyPointsEarned(int points, String orderId) {
    _notificationService.addSimpleNotification(
      title: "Points Earned!",
      subtitle: "You earned $points points from order $orderId",
      type: NotificationType.points,
      data: {"points": points, "orderId": orderId},
    );
  }

  /// Example: Add a notification for a new offer
  static void notifyNewOffer(String offerTitle, String discount) {
    _notificationService.addSimpleNotification(
      title: "New Offer Available!",
      subtitle: "$offerTitle - $discount",
      type: NotificationType.offer,
      data: {"discount": discount},
    );
  }

  /// Example: Add a notification when an order is returned
  static void notifyOrderReturned(String orderId, List<String> itemNames) {
    final itemsText = itemNames.length == 1
        ? itemNames.first
        : "${itemNames.length} items";

    _notificationService.addSimpleNotification(
      title: "Return Processed",
      subtitle:
          "Your return for $itemsText from order $orderId has been processed",
      type: NotificationType.general,
      data: {"orderId": orderId, "returnedItems": itemNames},
    );
  }
}

/// Example widget showing how to use the notification service
class NotificationTestWidget extends StatelessWidget {
  const NotificationTestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Notification Test")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () =>
                  NotificationExample.notifyOrderDelivered("#A1B2C3"),
              child: const Text("Test Order Delivered"),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () =>
                  NotificationExample.notifyPointsEarned(50, "#A1B2C3"),
              child: const Text("Test Points Earned"),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => NotificationExample.notifyNewOffer(
                "Weekend Special",
                "20% OFF",
              ),
              child: const Text("Test New Offer"),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => NotificationExample.notifyOrderReturned(
                "#A1B2C3",
                ["Burger", "Fries"],
              ),
              child: const Text("Test Order Returned"),
            ),
          ],
        ),
      ),
    );
  }
}
