import 'dart:ui';
import 'package:a_one_gt/core/apptheme/apptheme.dart';
import 'package:a_one_gt/core/utils/dimensions.dart';
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
      padding: EdgeInsets.symmetric(horizontal: Dimensions.width20 - 4),
      child: Column(
        children: [
          /// Points Summary Card
          ClipRRect(
            borderRadius: BorderRadius.circular(Dimensions.radius20),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(Dimensions.width20 + 4),
                margin: EdgeInsets.only(bottom: Dimensions.height20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Appcolors.primaryGreen,
                      Appcolors.primaryGreen.withValues(alpha: 0.5),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.2),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Appcolors.primaryGreen.withValues(alpha: 0.3),
                      blurRadius: Dimensions.height15,
                      offset: Offset(0, Dimensions.height10 - 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      "Total Points",
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.9),
                        fontSize: Dimensions.font16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: Dimensions.height10 - 2),
                    Text(
                      userTotalPoints.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: Dimensions.font26 + 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: Dimensions.height20 - 4),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.width20 * 1.5,
                        vertical: Dimensions.height10 - 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.25),
                        borderRadius: BorderRadius.circular(
                          Dimensions.radius20,
                        ),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.3),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        "Redeem for rewards",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: Dimensions.font16 - 2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          /// Points History
          ...dummyPointsHistory.map((pointsHistory) {
            return Container(
              margin: EdgeInsets.only(bottom: Dimensions.height15 - 3),
              padding: EdgeInsets.all(Dimensions.width20 - 4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(Dimensions.radius20 - 4),
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
                  Container(
                    height: Dimensions.height45 + 3,
                    width: Dimensions.height45 + 3,
                    decoration: BoxDecoration(
                      color: pointsHistory.isEarned
                          ? Appcolors.primaryGreen.withValues(alpha: 0.1)
                          : Colors.red.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(
                        Dimensions.radius15 - 3,
                      ),
                    ),
                    child: Icon(
                      pointsHistory.isEarned
                          ? Icons.add_circle_outline
                          : Icons.remove_circle_outline,
                      color: pointsHistory.isEarned
                          ? Appcolors.primaryGreen
                          : Colors.red,
                      size: Dimensions.iconSize24,
                    ),
                  ),
                  SizedBox(width: Dimensions.width20 - 4),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          pointsHistory.title,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: Dimensions.font16,
                          ),
                        ),
                        SizedBox(height: Dimensions.height10 / 2.5),
                        Text(
                          pointsHistory.subtitle,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: Dimensions.font16 - 2,
                          ),
                        ),
                        SizedBox(height: Dimensions.height10 - 2),
                        Text(
                          pointsHistory.time,
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: Dimensions.font16 - 4,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    pointsHistory.isEarned
                        ? "+${pointsHistory.points}"
                        : "${pointsHistory.points}",
                    style: TextStyle(
                      color: pointsHistory.isEarned
                          ? Appcolors.primaryGreen
                          : Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: Dimensions.font20 - 2,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
