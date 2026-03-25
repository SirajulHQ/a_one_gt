import 'package:flutter/material.dart';
import 'package:a_one_gt/core/apptheme/apptheme.dart';
import 'package:a_one_gt/features/widgets/custom_app_bar.dart';
import 'package:a_one_gt/features/widgets/section_tile.dart';

class AboutLegalPage extends StatelessWidget {
  const AboutLegalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.background,
      appBar: const CustomAppBar(title: "About & Legal"),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 30),
        child: Column(
          children: [
            /// ABOUT APP
            _buildCard(
              title: "About App",
              children: [
                _buildInfoTile(
                  icon: Icons.info_outline,
                  title: "App Name",
                  subtitle: "A One GT",
                ),
                _buildInfoTile(
                  icon: Icons.verified_outlined,
                  title: "Version",
                  subtitle: "1.0.0",
                ),
                _buildInfoTile(
                  icon: Icons.business_outlined,
                  title: "Company",
                  subtitle: "A One GT Pvt Ltd",
                ),
              ],
            ),

            /// TERMS
            _buildCard(
              title: "Terms & Conditions",
              children: const [
                Text(
                  "By using this application, you agree to comply with and "
                  "be bound by the following terms and conditions. The app "
                  "is provided for personal and commercial use related to "
                  "our services. Unauthorized use of this app may give rise "
                  "to a claim for damages and/or be a criminal offense.\n\n"
                  "We reserve the right to update or change these terms at "
                  "any time without prior notice. Continued use of the app "
                  "after changes means you accept the new terms.",
                  style: TextStyle(height: 1.5),
                ),
              ],
            ),

            /// PRIVACY POLICY
            _buildCard(
              title: "Privacy Policy",
              children: const [
                Text(
                  "We value your privacy and are committed to protecting "
                  "your personal information. We may collect basic user "
                  "information such as name, phone number, email address, "
                  "and usage data to improve our services.\n\n"
                  "We do not sell or share your personal information with "
                  "third parties except when required by law or to provide "
                  "our services. Your data is securely stored and protected.",
                  style: TextStyle(height: 1.5),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard({required String title, required List<Widget> children}) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      padding: const EdgeInsets.all(18),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle(title: title),
          const SizedBox(height: 10),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoTile({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: Appcolors.primaryGreen.withOpacity(.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: Appcolors.primaryGreen),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(subtitle),
    );
  }
}
