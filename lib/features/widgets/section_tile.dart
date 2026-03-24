import 'package:a_one_gt/core/apptheme/apptheme.dart';
import 'package:a_one_gt/core/utils/dimensions.dart';
import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: Dimensions.width10,
          height: Dimensions.height20 - 2,
          decoration: BoxDecoration(
            color: Appcolors.primaryGreen,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        SizedBox(width: Dimensions.width20),
        Text(
          title,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
        ),
      ],
    );
  }
}
