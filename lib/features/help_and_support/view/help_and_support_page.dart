import 'package:a_one_gt/core/apptheme/apptheme.dart';
import 'package:a_one_gt/core/utils/dimensions.dart';
import 'package:a_one_gt/features/widgets/custom_app_bar.dart';
import 'package:a_one_gt/features/widgets/section_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpAndSupportPage extends StatelessWidget {
  const HelpAndSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.background,
      appBar: CustomAppBar(title: "Help & support"),
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
        _handleSupportOption(title);
      },
    );
  }

  /// Handle Support Option Navigation
  void _handleSupportOption(String option) async {
    try {
      switch (option) {
        case "Live Chat":
          await _openWhatsApp();
          break;
        case "Call Support":
          await _makePhoneCall();
          break;
        case "Email Support":
          await _openEmailCompose();
          break;
      }
    } catch (e) {
      // Handle error - could show a snackbar or dialog
      debugPrint("Error opening $option: $e");
    }
  }

  /// Open WhatsApp
  Future<void> _openWhatsApp() async {
    const phoneNumber = "919605455758";
    const message = "Hello, I need support with A One GT app.";

    // Try WhatsApp app first with whatsapp:// scheme
    final whatsappAppUrl = Uri.parse(
      "whatsapp://send?phone=$phoneNumber&text=${Uri.encodeComponent(message)}",
    );

    if (await canLaunchUrl(whatsappAppUrl)) {
      await launchUrl(whatsappAppUrl);
    } else {
      // Fallback to web WhatsApp
      final webWhatsappUrl = Uri.parse(
        "https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}",
      );
      if (await canLaunchUrl(webWhatsappUrl)) {
        await launchUrl(webWhatsappUrl, mode: LaunchMode.externalApplication);
      } else {
        // Final fallback
        final fallbackUrl = Uri.parse(
          "https://api.whatsapp.com/send?phone=$phoneNumber&text=${Uri.encodeComponent(message)}",
        );
        await launchUrl(fallbackUrl, mode: LaunchMode.externalApplication);
      }
    }
  }

  /// Make Phone Call
  Future<void> _makePhoneCall() async {
    const phoneNumber = "+919605455758";
    final phoneUrl = Uri.parse("tel:$phoneNumber");

    if (await canLaunchUrl(phoneUrl)) {
      await launchUrl(phoneUrl);
    }
  }

  /// Open Email Compose
  Future<void> _openEmailCompose() async {
    const email = "sirajulhaq3154@gmail.com";
    const subject = "Support Request - A One GT App";
    const body =
        "Hello,\n\nI need assistance with the A One GT app.\n\nPlease describe your issue here.\n\nThank you.";

    // Try Gmail app first
    final gmailUrl = Uri.parse(
      "googlegmail://co?to=$email&subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(body)}",
    );

    if (await canLaunchUrl(gmailUrl)) {
      await launchUrl(gmailUrl);
    } else {
      // Fallback to standard mailto
      final emailUrl = Uri.parse(
        "mailto:$email?subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(body)}",
      );

      if (await canLaunchUrl(emailUrl)) {
        await launchUrl(emailUrl);
      }
    }
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
      // child: GestureDetector(
      //   onTap: () {
      //     HapticFeedback.selectionClick();
      //     _handleContactTap(icon, text);
      //   },
      child: Row(
        children: [
          Icon(icon, color: Appcolors.primaryGreen),
          const SizedBox(width: 10),
          Text(text),
        ],
      ),
      // ),
    );
  }

  /// Handle Contact Tap
  // void _handleContactTap(IconData icon, String text) async {
  //   if (icon == Icons.phone) {
  //     final phoneUrl = Uri.parse("tel:$text");
  //     if (await canLaunchUrl(phoneUrl)) {
  //       await launchUrl(phoneUrl);
  //     }
  //   } else if (icon == Icons.email) {
  //     final emailUrl = Uri.parse("mailto:$text");
  //     if (await canLaunchUrl(emailUrl)) {
  //       await launchUrl(emailUrl);
  //     }
  //   }
  // }
}
