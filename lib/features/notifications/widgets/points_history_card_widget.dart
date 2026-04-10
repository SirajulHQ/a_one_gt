import 'package:a_one_gt/core/apptheme/apptheme.dart';
import 'package:flutter/material.dart';

class PointsHistoryCardWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final String points;
  final String time;
  final bool isEarned;

  const PointsHistoryCardWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.points,
    required this.time,
    required this.isEarned,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              color: isEarned
                  ? Appcolors.primaryGreen.withValues(alpha: 0.1)
                  : Colors.red.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              isEarned ? Icons.add_circle_outline : Icons.remove_circle_outline,
              color: isEarned ? Appcolors.primaryGreen : Colors.red,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  time,
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Text(
            points,
            style: TextStyle(
              color: isEarned ? Appcolors.primaryGreen : Colors.red,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}