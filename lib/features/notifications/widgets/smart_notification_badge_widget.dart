import 'package:a_one_gt/core/utils/dimensions.dart';
import 'package:a_one_gt/features/notifications/services/notification_service.dart';
import 'package:flutter/material.dart';

/// A smart notification badge widget that automatically displays the current
/// unread notification count from the NotificationService.
///
/// This widget listens to the NotificationService and updates the badge count
/// in real-time whenever notifications are marked as read/unread or new
/// notifications are added.
///
class SmartNotificationBadgeWidget extends StatefulWidget {
  final Widget child;
  final bool showBadge;

  const SmartNotificationBadgeWidget({
    super.key,
    required this.child,
    this.showBadge = true,
  });

  @override
  State<SmartNotificationBadgeWidget> createState() =>
      _SmartNotificationBadgeWidgetState();
}

class _SmartNotificationBadgeWidgetState
    extends State<SmartNotificationBadgeWidget> {
  final NotificationService _notificationService = NotificationService();

  @override
  void initState() {
    super.initState();
    _notificationService.addListener(_onNotificationUpdate);
  }

  @override
  void dispose() {
    _notificationService.removeListener(_onNotificationUpdate);
    super.dispose();
  }

  void _onNotificationUpdate() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final unreadCount = _notificationService.unreadCount;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        widget.child,
        if (widget.showBadge && unreadCount > 0)
          Positioned(
            right: Dimensions.width10 - 8,
            top: Dimensions.height10 - 18,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.transparent,
                  width: Dimensions.width10 - 0.5,
                ),
              ),
              child: Center(
                child: Text(
                  unreadCount > 9 ? '9+' : unreadCount.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: Dimensions.font16 - 5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
