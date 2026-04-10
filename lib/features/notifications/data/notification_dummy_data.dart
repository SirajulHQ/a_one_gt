import '../model/notification_model.dart';

// Sample notifications data
final List<NotificationModel> dummyNotifications = [
  NotificationModel(
    id: "1",
    title: "Special Offer!",
    subtitle: "Get 20% off on all grocery items",
    time: "2 hours ago",
    type: NotificationType.offer,
    isRead: false, // Unread
    data: {"discount": "20", "category": "grocery"},
  ),
  NotificationModel(
    id: "2",
    title: "Points Earned!",
    subtitle: "You earned 50 points from your recent purchase",
    time: "5 hours ago",
    type: NotificationType.points,
    isRead: false, // Unread
    data: {"points": 50, "orderId": "12345"},
  ),
  NotificationModel(
    id: "3",
    title: "Order Delivered!",
    subtitle: "Your order #A1B2C3 has been delivered successfully",
    time: "8 hours ago",
    type: NotificationType.general,
    isRead: false, // Unread
    data: {"orderId": "A1B2C3"},
  ),
  NotificationModel(
    id: "4",
    title: "Flash Sale!",
    subtitle: "Limited time offer on electronics - Up to 40% off",
    time: "1 day ago",
    type: NotificationType.offer,
    isRead: true, // Read
    data: {"discount": "40", "category": "electronics"},
  ),
  NotificationModel(
    id: "5",
    title: "Bonus Points!",
    subtitle: "Double points weekend is here! Shop now",
    time: "2 days ago",
    type: NotificationType.points,
    isRead: true, // Read
    data: {"multiplier": 2},
  ),
  NotificationModel(
    id: "6",
    title: "New Member Offer",
    subtitle: "Welcome! Enjoy 15% off on your first order",
    time: "3 days ago",
    type: NotificationType.offer,
    isRead: true, // Read
    data: {"discount": "15", "isWelcome": true},
  ),
];

// Sample offers data
final List<OfferModel> dummyOffers = [
  OfferModel(
    id: "offer_1",
    title: "Weekend Special",
    description: "Get 20% off on all grocery items",
    discount: "20% OFF",
    validUntil: "Valid until Sunday",
    color: "orange",
  ),
  OfferModel(
    id: "offer_2",
    title: "Flash Sale",
    description: "Limited time offer on electronics",
    discount: "40% OFF",
    validUntil: "Valid for 6 hours",
    color: "red",
  ),
  OfferModel(
    id: "offer_3",
    title: "Buy 2 Get 1 Free",
    description: "On selected clothing items",
    discount: "BOGO",
    validUntil: "Valid until Friday",
    color: "purple",
  ),
  OfferModel(
    id: "offer_4",
    title: "Free Delivery",
    description: "On orders above \$50",
    discount: "FREE",
    validUntil: "Valid this week",
    color: "green",
  ),
];

// Sample points history data
final List<PointsHistoryModel> dummyPointsHistory = [
  PointsHistoryModel(
    id: "points_1",
    title: "Purchase Reward",
    subtitle: "Order #12345 - Grocery items",
    points: 50,
    time: "2 hours ago",
    isEarned: true,
    orderId: "12345",
  ),
  PointsHistoryModel(
    id: "points_2",
    title: "Bonus Points",
    subtitle: "Weekend double points promotion",
    points: 100,
    time: "1 day ago",
    isEarned: true,
  ),
  PointsHistoryModel(
    id: "points_3",
    title: "Redeemed",
    subtitle: "Free delivery coupon",
    points: -200,
    time: "3 days ago",
    isEarned: false,
  ),
  PointsHistoryModel(
    id: "points_4",
    title: "Purchase Reward",
    subtitle: "Order #12340 - Electronics",
    points: 75,
    time: "5 days ago",
    isEarned: true,
    orderId: "12340",
  ),
  PointsHistoryModel(
    id: "points_5",
    title: "Welcome Bonus",
    subtitle: "New member bonus points",
    points: 500,
    time: "1 week ago",
    isEarned: true,
  ),
];

// User's total points
int userTotalPoints = 1250;
