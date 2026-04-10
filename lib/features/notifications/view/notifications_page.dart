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
                margin: EdgeInsets.only(right: Dimensions.width10 - 2),
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.width20,
                  vertical: Dimensions.height10 / 2.5,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(Dimensions.radius15 - 3),
                ),
                child: Text(
                  "Mark all read",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: Dimensions.font16 - 4,
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
            margin: EdgeInsets.symmetric(
              horizontal: Dimensions.width20 - 4,
              vertical: Dimensions.height10,
            ),
            padding: EdgeInsets.all(
              Dimensions.height10 / 2.5,
            ), // important for inner spacing
            decoration: BoxDecoration(
              color:
                  Colors.grey.shade100, // soft background instead of pure white
              borderRadius: BorderRadius.circular(Dimensions.radius30),
            ),
            child: TabBar(
              controller: _tabController,
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor:
                  Colors.transparent, // removes bottom line (Flutter 3.7+)
              indicator: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Appcolors.gradientColor1, Appcolors.gradientColor2],
                ),
                borderRadius: BorderRadius.circular(Dimensions.radius30),
                border: Border.all(color: Colors.white.withOpacity(0.2)),
              ),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey.shade600,
              labelStyle: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: Dimensions.font16 - 3,
              ),
              unselectedLabelStyle: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: Dimensions.font16 - 3,
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
      padding: EdgeInsets.symmetric(horizontal: Dimensions.width20 - 4),
      itemCount: sortedNotifs.length,
      itemBuilder: (context, index) {
        final notification = sortedNotifs[index];
        return AnimatedContainer(
          duration: Duration(milliseconds: Dimensions.height30.toInt() * 10),
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
      padding: EdgeInsets.symmetric(horizontal: Dimensions.width20 - 4),
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
