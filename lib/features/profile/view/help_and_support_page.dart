import 'package:a_one_gt/core/apptheme/apptheme.dart';
import 'package:a_one_gt/core/utils/dimensions.dart';
import 'package:a_one_gt/features/widgets/custom_appbar.dart';
import 'package:a_one_gt/features/widgets/section_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HelpAndSupportPage extends StatelessWidget {
  const HelpAndSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.background,
      appBar: CustomAppbar(title: "Help & support"),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            /// Support Options Card
            Container(
              margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const SectionTitle(title: "Support Options"),
                  const SizedBox(height: 20),
                  _buildTile(Icons.chat_bubble_outline, "Live Chat"),
                  _buildTile(Icons.local_phone_outlined, "Call Support"),
                  _buildTile(Icons.email_outlined, "Email Support"),
                  _buildTile(Icons.report_problem_outlined, "Report a Problem"),
                ],
              ),
            ),

            /// FAQ Card
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const SectionTitle(title: "Frequently Asked Questions"),
                  const SizedBox(height: 20),
                  _buildFaqTile(
                    "How do I track my order?",
                    "You can track your order from My Orders section.",
                  ),
                  _buildFaqTile(
                    "How do I cancel an order?",
                    "Orders can be cancelled before they are shipped.",
                  ),
                  _buildFaqTile(
                    "How do I change delivery address?",
                    "You can change address from Saved Addresses.",
                  ),
                ],
              ),
            ),

            /// Contact Card
            Container(
              margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const SectionTitle(title: "Contact Us"),
                  const SizedBox(height: 20),
                  _buildContactRow(Icons.phone, "+971 50 123 4567"),
                  _buildContactRow(Icons.email, "support@aone.com"),
                  _buildContactRow(Icons.location_on, "Dubai, UAE"),
                ],
              ),
            ),
            SizedBox(height: Dimensions.height30),
          ],
        ),
      ),
    );
  }

  /// Support Tile
  Widget _buildTile(IconData icon, String title) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        height: Dimensions.height30,
        width: Dimensions.height30,
        decoration: BoxDecoration(
          color: Appcolors.primaryGreen.withOpacity(.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: Appcolors.primaryGreen),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
      onTap: () {
        HapticFeedback.selectionClick();
      },
    );
  }

  /// FAQ Tile
  Widget _buildFaqTile(String question, String answer) {
    return ExpansionTile(
      tilePadding: EdgeInsets.zero,
      childrenPadding: const EdgeInsets.only(bottom: 10),
      title: Text(
        question,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      children: [Text(answer, style: TextStyle(color: Colors.grey.shade600))],
    );
  }

  /// Contact Row
  Widget _buildContactRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, color: Appcolors.primaryGreen),
          const SizedBox(width: 10),
          Text(text),
        ],
      ),
    );
  }
}
