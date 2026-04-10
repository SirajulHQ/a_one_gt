import 'package:a_one_gt/core/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OfferCardWidget extends StatelessWidget {
  final String title;
  final String description;
  final String discount;
  final String validUntil;
  final Color color;

  const OfferCardWidget({
    super.key,
    required this.title,
    required this.description,
    required this.discount,
    required this.validUntil,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: Dimensions.height20 - 4),
      padding: EdgeInsets.all(Dimensions.width20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Dimensions.radius20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: Dimensions.height15,
            offset: Offset(0, Dimensions.height10 - 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: Dimensions.font20 - 2,
                  ),
                ),
                SizedBox(height: Dimensions.height10 - 2),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: Dimensions.font16 - 2,
                  ),
                ),
                SizedBox(height: Dimensions.height15 - 3),
                Text(
                  validUntil,
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: Dimensions.font16 - 4,
                  ),
                ),
                SizedBox(height: Dimensions.height20 - 4),
                GestureDetector(
                  onTap: () {
                    HapticFeedback.selectionClick();
                    // Handle claim offer
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.width20,
                      vertical: Dimensions.height10,
                    ),
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(
                        Dimensions.radius30 - 5,
                      ),
                    ),
                    child: Text(
                      "Claim Offer",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: Dimensions.font16 - 4,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: Dimensions.width20 - 4),
          Container(
            padding: EdgeInsets.all(Dimensions.width20 - 4),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(Dimensions.radius20 - 4),
            ),
            child: Text(
              discount,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: Dimensions.font16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
