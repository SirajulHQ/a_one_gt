import 'package:a_one_gt/core/apptheme/apptheme.dart';
import 'package:a_one_gt/features/settings/view/about_legal_page.dart';
import 'package:a_one_gt/features/settings/widgets/confirmation_dialog_widget.dart';
import 'package:a_one_gt/features/widgets/custom_app_bar.dart';
import 'package:a_one_gt/features/widgets/section_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool notifications = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.background,
      appBar: const CustomAppBar(title: "Settings"),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            _buildSettingsCard(
              title: "General",
              children: [
                _buildSwitchTile(
                  icon: Icons.notifications_outlined,
                  title: "Push Notifications",
                  value: notifications,
                  onChanged: (v) => setState(() => notifications = v),
                ),
              ],
            ),

            _buildSettingsCard(
              title: "Account",
              children: [
                _buildArrowTile(
                  icon: Icons.lock_outline,
                  title: "Change Password",
                  onTap: () {},
                ),
                _buildArrowTile(
                  icon: Icons.dashboard_customize_outlined,
                  title: "About & Legal",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const AboutLegalPage()),
                    );
                  },
                ),
                _buildArrowTile(
                  icon: Icons.stop_circle_outlined,
                  title: "De-activate Account",
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (_) => const ConfirmationDialogWidget(),
                    );
                  },
                ),
                _buildArrowTile(
                  icon: Icons.delete_outline,
                  title: "Delete Account",
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (_) =>
                          const ConfirmationDialogWidget(isDelete: true),
                    );
                  },
                ),
              ],
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsCard({
    required String title,
    required List<Widget> children,
  }) {
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

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required bool value,
    required Function(bool) onChanged,
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
      trailing: Switch(
        value: value,
        activeColor: Appcolors.primaryGreen,
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildArrowTile({
    required IconData icon,
    required String title,
    VoidCallback? onTap,
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
      trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
      onTap: () {
        HapticFeedback.selectionClick();
        onTap?.call();
      },
    );
  }
}
