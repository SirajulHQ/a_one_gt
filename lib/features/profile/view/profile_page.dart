import 'package:a_one_gt/core/apptheme/apptheme.dart';
import 'package:a_one_gt/core/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

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
            color: Colors.black.withOpacity(0.05),
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
            color: Appcolors.primaryGreen.withOpacity(.1),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      body: CustomScrollView(
        slivers: [
          /// ───────────────── Header ─────────────────
          SliverAppBar(
            expandedHeight: Dimensions.height45 * 5,
            pinned: true,
            elevation: 0,
            backgroundColor: const Color.fromARGB(
              255,
              10,
              72,
              36,
            ).withOpacity(0.78),
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
                  colors: [
                    const Color.fromARGB(255, 103, 203, 147),
                    const Color.fromARGB(255, 10, 72, 36).withOpacity(0.78),
                  ],
                ),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  /// background circles
                  Positioned(
                    top: -20,
                    right: -20,
                    child: Container(
                      width: Dimensions.height45 * 3,
                      height: Dimensions.height45 * 3,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(.08),
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
                        color: Colors.white.withOpacity(.06),
                      ),
                    ),
                  ),

                  /// Profile Content
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
                          color: Colors.white.withOpacity(0.2),
                        ),
                        child: ClipOval(
                          child: Image.network(
                            "https://i.pravatar.cc/150?img=68",
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(
                                Icons.person,
                                size: Dimensions.height45,
                                color: Colors.white,
                              );
                            },
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  value:
                                      loadingProgress.expectedTotalBytes != null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              );
                            },
                          ),
                        ),
                      ),

                      SizedBox(height: Dimensions.height10),

                      /// Name
                      Text(
                        "Sirajul Haque",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: Dimensions.font20,
                          fontWeight: FontWeight.w800,
                        ),
                      ),

                      SizedBox(height: Dimensions.height10 / 2),

                      /// Email
                      Text(
                        "sirajul@gmail.com",
                        style: TextStyle(
                          color: Colors.white.withOpacity(.75),
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
                    onTap: () {},
                  ),

                  buildOptionTile(
                    icon: Icons.location_on_outlined,
                    title: "Delivery Address",
                    onTap: () {},
                  ),

                  buildOptionTile(
                    icon: Icons.shopping_bag_outlined,
                    title: "My Orders",
                    onTap: () {},
                  ),

                  buildOptionTile(
                    icon: Icons.favorite_border,
                    title: "Wishlist",
                    onTap: () {},
                  ),

                  buildOptionTile(
                    icon: Icons.settings_outlined,
                    title: "Settings",
                    onTap: () {},
                  ),

                  buildOptionTile(
                    icon: Icons.help_outline,
                    title: "Help & Support",
                    onTap: () {},
                  ),

                  SizedBox(height: Dimensions.height20),

                  /// Logout Button
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
}
