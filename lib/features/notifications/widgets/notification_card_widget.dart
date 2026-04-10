import 'package:a_one_gt/core/utils/dimensions.dart';
import 'package:flutter/material.dart';

class NotificationCardWidget extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final String time;
  final bool isOffer;
  final bool isRead;

  const NotificationCardWidget({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.isOffer,
    this.isRead = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: Dimensions.height15 - 3),
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.width20 - 4,
        vertical: Dimensions.height15 - 5,
      ),
      decoration: BoxDecoration(
        color: isRead ? Colors.white : Colors.blue.shade50,
        borderRadius: BorderRadius.circular(Dimensions.radius20 - 4),
        border: isRead
            ? null
            : Border.all(color: Colors.blue.shade200, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: Dimensions.height15 - 3,
            offset: Offset(0, Dimensions.height10 / 2.5),
          ),
        ],
      ),
      child: Row(
        children: [
          Stack(
            children: [
              Container(
                height: Dimensions.height45 + 5,
                width: Dimensions.height45 + 5,
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(Dimensions.radius15 - 3),
                ),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: Dimensions.iconSize24,
                ),
              ),
              if (!isRead)
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    width: Dimensions.height15 - 3,
                    height: Dimensions.height15 - 3,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade600,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(width: Dimensions.width20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: isRead ? FontWeight.w600 : FontWeight.w700,
                    fontSize: Dimensions.font16,
                    color: isRead ? Colors.black : Colors.black87,
                  ),
                ),
                SizedBox(height: Dimensions.height10 / 2.5),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: isRead ? Colors.grey.shade600 : Colors.grey.shade700,
                    fontSize: Dimensions.font16 - 2,
                    fontWeight: isRead ? FontWeight.normal : FontWeight.w500,
                  ),
                ),
                SizedBox(height: Dimensions.height10 - 2),
                Row(
                  children: [
                    Text(
                      time,
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: Dimensions.font16 - 4,
                      ),
                    ),
                    if (!isRead) ...[
                      SizedBox(width: Dimensions.width10 - 2),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.width10 - 4,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade600,
                          borderRadius: BorderRadius.circular(
                            Dimensions.radius15 - 7,
                          ),
                        ),
                        child: Text(
                          "NEW",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: Dimensions.font16 - 6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          if (isOffer)
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.width10 - 2,
                vertical: Dimensions.height10 / 2.5,
              ),
              decoration: BoxDecoration(
                color: Colors.orange.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(Dimensions.radius15 - 7),
              ),
              child: Text(
                "OFFER",
                style: TextStyle(
                  color: Colors.orange,
                  fontSize: Dimensions.font16 - 6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
