import 'package:a_one_gt/core/apptheme/apptheme.dart';
import 'package:a_one_gt/core/utils/dimensions.dart';
import 'package:a_one_gt/features/address/view/saved_address_page.dart';
import 'package:a_one_gt/features/my_orders/view/my_orders_page.dart';
import 'package:a_one_gt/features/profile/view/edit_profile_page.dart';
import 'package:a_one_gt/features/help_and_support/view/help_and_support_page.dart';
import 'package:a_one_gt/features/settings/view/settings_page.dart';
import 'package:a_one_gt/features/profile/widget/logout_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.background,
      body: CustomScrollView(
        slivers: [
          /// ───────────────── Header ─────────────────
          SliverAppBar(
            expandedHeight: Dimensions.height45 * 5,
            backgroundColor: Appcolors.darkGreen,
            iconTheme: const IconThemeData(color: Colors.white),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(Dimensions.radius30),
              ),
            ),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(Dimensions.radius30),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Appcolors.gradientColor1, Appcolors.gradientColor2],
                ),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    top: -20,
                    right: -20,
                    child: Container(
                      width: Dimensions.height45 * 3,
                      height: Dimensions.height45 * 3,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha: 0.08),
                      ),
                    ),
                  ),

                  Positioned(
                    bottom: Dimensions.height30,
                    left: Dimensions.width20,
                    child: Container(
                      width: Dimensions.height45,
                      height: Dimensions.height45,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha: 0.06),
                      ),
                    ),
                  ),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: Dimensions.height30),

                      /// Avatar
                      Container(
                        height: Dimensions.height45 * 2,
                        width: Dimensions.height45 * 2,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 3),
                          color: Colors.white.withValues(alpha: 0.2),
                        ),
                        child: ClipOval(
                          child: Icon(
                            Icons.person_outline_outlined,
                            size: Dimensions.iconSize24 * 2.5,
                            color: Appcolors.darkGreen,
                          ),
                          // child: Image.network(
                          //   "https://i.pravatar.cc/150?img=68",
                          //   fit: BoxFit.cover,
                          //   errorBuilder: (context, error, stackTrace) {
                          //     return Icon(
                          //       Icons.person,
                          //       size: Dimensions.height45,
                          //       color: Colors.white,
                          //     );
                          //   },
                          //   loadingBuilder: (context, child, loadingProgress) {
                          //     if (loadingProgress == null) return child;
                          //     return Center(
                          //       child: CircularProgressIndicator(
                          //         color: Colors.white,
                          //         value:
                          //             loadingProgress.expectedTotalBytes != null
                          //             ? loadingProgress.cumulativeBytesLoaded /
                          //                   loadingProgress.expectedTotalBytes!
                          //             : null,
                          //       ),
                          //     );
                          //   },
                          // ),
                        ),
                      ),

                      SizedBox(height: Dimensions.height10),
                      Text(
                        "Sirajul Haque",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: Dimensions.font20,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(height: Dimensions.height10 / 2),
                      Text(
                        "sirajul@gmail.com",
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.75),
                          fontSize: Dimensions.font16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          /// ───────────── Profile Options ─────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                Dimensions.width20,
                Dimensions.height20,
                Dimensions.width20,
                0,
              ),
              child: Column(
                children: [
                  buildOptionTile(
                    icon: Icons.person_outline,
                    title: "Edit Profile",
                    onTap: () {
                      HapticFeedback.mediumImpact();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const EditProfilePage(),
                        ),
                      );
                    },
                  ),

                  buildOptionTile(
                    icon: Icons.location_on_outlined,
                    title: "Saved Addresses",
                    onTap: () {
                      HapticFeedback.mediumImpact();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const SavedAddressesPage(),
                        ),
                      );
                    },
                  ),

                  buildOptionTile(
                    icon: Icons.shopping_bag_outlined,
                    title: "My Orders",
                    onTap: () {
                      HapticFeedback.mediumImpact();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const MyOrdersPage()),
                      );
                    },
                  ),

                  buildOptionTile(
                    icon: Icons.settings_outlined,
                    title: "Settings",
                    onTap: () {
                      HapticFeedback.mediumImpact();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const SettingsPage()),
                      );
                    },
                  ),

                  buildOptionTile(
                    icon: Icons.help_outline,
                    title: "Help & Support",
                    onTap: () {
                      HapticFeedback.mediumImpact();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const HelpAndSupportPage(),
                        ),
                      );
                    },
                  ),

                  SizedBox(height: Dimensions.height20),

                  /// ───────────────── Logout Button ─────────────────
                  Container(
                    width: double.infinity,
                    height: Dimensions.height45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius15),
                      color: Colors.red.shade50,
                    ),
                    child: TextButton.icon(
                      onPressed: () {
                        HapticFeedback.mediumImpact();

                        /// ───────────────── Logout Dialog ─────────────────
                        showDialog(
                          context: context,
                          barrierColor: Colors.black.withValues(alpha: 0.5),
                          builder: (context) {
                            return const LogoutDialogWidget();
                          },
                        );
                      },
                      icon: const Icon(Icons.logout, color: Colors.red),
                      label: const Text(
                        "Logout",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: Dimensions.height30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildOptionTile({
    required IconData icon,
    required String title,
    VoidCallback? onTap,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: Dimensions.height10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Dimensions.radius15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: Dimensions.radius15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        leading: Container(
          height: Dimensions.height30,
          width: Dimensions.height30,
          decoration: BoxDecoration(
            color: Appcolors.primaryGreen.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(Dimensions.radius15),
          ),
          child: Icon(
            icon,
            color: Appcolors.primaryGreen,
            size: Dimensions.iconSize24,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: Dimensions.font16,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios_rounded,
          size: Dimensions.iconSize16,
        ),
        onTap: () {
          HapticFeedback.selectionClick();
          onTap?.call();
        },
      ),
    );
  }
}
