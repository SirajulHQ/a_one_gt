import 'package:a_one_gt/core/apptheme/apptheme.dart';
import 'package:a_one_gt/features/notifications/widgets/points_history_card_widget.dart';
import 'package:flutter/material.dart';

class PointsTabWidget extends StatelessWidget {
  final int userTotalPoints;
  final List<dynamic> dummyPointsHistory;

  const PointsTabWidget({
    super.key,
    required this.userTotalPoints,
    required this.dummyPointsHistory,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          /// Points Summary Card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Appcolors.primaryGreen,
                  Appcolors.primaryGreen.withValues(alpha: 0.8),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Appcolors.primaryGreen.withValues(alpha: 0.3),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              children: [
                const Text(
                  "Total Points",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  userTotalPoints.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    "Redeem for rewards",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          /// Points History
          ...dummyPointsHistory.map((pointsHistory) {
            return PointsHistoryCardWidget(
              title: pointsHistory.title,
              subtitle: pointsHistory.subtitle,
              points: pointsHistory.isEarned
                  ? "+${pointsHistory.points}"
                  : "${pointsHistory.points}",
              time: pointsHistory.time,
              isEarned: pointsHistory.isEarned,
            );
          }),
        ],
      ),
    );
  }
}