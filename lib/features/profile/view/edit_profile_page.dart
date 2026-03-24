import 'package:a_one_gt/core/apptheme/apptheme.dart';
import 'package:a_one_gt/core/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final nameController = TextEditingController(text: "Sirajul Haque");
  final emailController = TextEditingController(text: "sirajul@gmail.com");
  final phoneController = TextEditingController();
  final addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.background,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Edit Profile",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Appcolors.gradientColor1, Appcolors.gradientColor2],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            // _buildProfileImage(),
            Icon(
              Icons.person_outline_outlined,
              size: Dimensions.iconSize24 * 5,
              color: Appcolors.darkGreen,
            ),
            const SizedBox(height: 20),
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
                  _buildTextField(
                    title: "Full Name",
                    controller: nameController,
                    icon: Icons.person_outline,
                  ),
                  _buildTextField(
                    title: "Email",
                    controller: emailController,
                    icon: Icons.email_outlined,
                  ),
                  _buildTextField(
                    title: "Phone",
                    controller: phoneController,
                    icon: Icons.phone_outlined,
                  ),
                  // _buildTextField(
                  //   title: "Address",
                  //   controller: addressController,
                  //   icon: Icons.location_on_outlined,
                  // ),
                  const SizedBox(height: 10),

                  // Save Button
                  Container(
                    width: double.infinity,
                    height: 55,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Appcolors.gradientColor1,
                          Appcolors.gradientColor2,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: TextButton(
                      onPressed: () {
                        HapticFeedback.mediumImpact();
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Save Changes",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String title,
    required TextEditingController controller,
    IconData? icon,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Appcolors.primaryGreen),
          labelText: title,
          floatingLabelStyle: TextStyle(
            color: Appcolors.primaryGreen,
            fontWeight: FontWeight.w600,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 18),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(22),
            borderSide: BorderSide(color: Colors.grey.shade300, width: 1.2),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(22),
            borderSide: BorderSide(color: Appcolors.primaryGreen, width: 2),
          ),

          border: OutlineInputBorder(borderRadius: BorderRadius.circular(22)),
        ),
      ),
    );
  }

  // Widget _buildProfileImage() {
  //   return Stack(
  //     alignment: Alignment.bottomRight,
  //     children: [
  //       Container(
  //         padding: const EdgeInsets.all(4),
  //         decoration: BoxDecoration(
  //           shape: BoxShape.circle,
  //           border: Border.all(color: Colors.white, width: 3),
  //         ),
  //         child: const CircleAvatar(
  //           radius: 55,
  //           backgroundImage: NetworkImage("https://i.pravatar.cc/150?img=68"),
  //         ),
  //       ),
  //       Container(
  //         padding: const EdgeInsets.all(8),
  //         decoration: BoxDecoration(
  //           gradient: LinearGradient(
  //             colors: [Appcolors.gradientColor1, Appcolors.gradientColor2],
  //           ),
  //           shape: BoxShape.circle,
  //         ),
  //         child: Icon(
  //           Icons.camera_alt_outlined,
  //           color: Colors.white,
  //           size: Dimensions.iconSize24 - 3,
  //         ),
  //       ),
  //     ],
  //   );
  // }
}
