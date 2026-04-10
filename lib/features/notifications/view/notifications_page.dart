import 'package:a_one_gt/core/apptheme/apptheme.dart';
import 'package:a_one_gt/core/utils/dimensions.dart';
import 'package:a_one_gt/features/notifications/data/notification_dummy_data.dart';
import 'package:a_one_gt/features/notifications/model/notification_model.dart';
import 'package:a_one_gt/features/notifications/services/notification_service.dart';
import 'package:a_one_gt/features/notifications/widgets/notification_card_widget.dart';
import 'package:a_one_gt/features/notifications/widgets/offer_card_widget.dart';
import 'package:a_one_gt/features/notifications/widgets/points_tab_widget.dart';
import 'package:a_one_gt/features/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final NotificationService _notificationService = NotificationService();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    // Listen to notification service changes
    _notificationService.addListener(_onNotificationUpdate);
  }

  @override
  void dispose() {
    _tabController.dispose();
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
    return Scaffold(
      backgroundColor: Appcolors.background,
      appBar: CustomAppBar(
        title: "Notifications",
        actions: [
          if (_notificationService.unreadCount > 0) ...[
            GestureDetector(
              onTap: _markAllAsRead,
              child: Container(
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  "Mark all read",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(width: Dimensions.width10),
          ],
        ],
      ),
      body: Column(
        children: [
          // Tab Bar
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            padding: const EdgeInsets.all(4), // important for inner spacing
            decoration: BoxDecoration(
              color:
                  Colors.grey.shade100, // soft background instead of pure white
              borderRadius: BorderRadius.circular(30),
            ),
            child: TabBar(
              controller: _tabController,
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor:
                  Colors.transparent, // removes bottom line (Flutter 3.7+)
              indicator: BoxDecoration(
                color: Appcolors.primaryGreen,
                borderRadius: BorderRadius.circular(30),
              ),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey.shade600,
              labelStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
              unselectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 13,
              ),
              overlayColor: WidgetStateProperty.all(
                Colors.transparent,
              ), // remove splash
              splashFactory: NoSplash.splashFactory, // extra safety
              tabs: const [
                Tab(text: "All"),
                Tab(text: "Offers"),
                Tab(text: "Points"),
              ],
            ),
          ),

          // Tab Views
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildAllNotifications(),
                _buildOffersTab(),
                PointsTabWidget(
                  userTotalPoints: userTotalPoints,
                  dummyPointsHistory: dummyPointsHistory,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _markAllAsRead() {
    _notificationService.markAllAsRead();
    HapticFeedback.mediumImpact();
  }

  void _markAsRead(String notificationId) {
    _notificationService.markAsRead(notificationId);
    HapticFeedback.selectionClick();
  }

  List<NotificationModel> get sortedNotifications =>
      _notificationService.sortedNotifications;

  Widget _buildAllNotifications() {
    final sortedNotifs = sortedNotifications;
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: sortedNotifs.length,
      itemBuilder: (context, index) {
        final notification = sortedNotifs[index];
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          child: GestureDetector(
            onTap: () => _markAsRead(notification.id),
            child: NotificationCardWidget(
              icon: notification.type == NotificationType.offer
                  ? Icons.local_offer_outlined
                  : notification.type == NotificationType.points
                  ? Icons.stars_outlined
                  : Icons.notifications_outlined,
              iconColor: notification.type == NotificationType.offer
                  ? Colors.orange
                  : notification.type == NotificationType.points
                  ? Appcolors.primaryGreen
                  : Colors.blue,
              title: notification.title,
              subtitle: notification.subtitle,
              time: notification.time,
              isOffer: notification.type == NotificationType.offer,
              isRead: notification.isRead,
            ),
          ),
        );
      },
    );
  }

  Widget _buildOffersTab() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: dummyOffers.length,
      itemBuilder: (context, index) {
        final offer = dummyOffers[index];
        Color color;
        switch (offer.color) {
          case "orange":
            color = Colors.orange;
            break;
          case "red":
            color = Colors.red;
            break;
          case "purple":
            color = Colors.purple;
            break;
          case "green":
            color = Appcolors.primaryGreen;
            break;
          default:
            color = Appcolors.primaryGreen;
        }

        return OfferCardWidget(
          title: offer.title,
          description: offer.description,
          discount: offer.discount,
          validUntil: offer.validUntil,
          color: color,
        );
      },
    );
  }
}
