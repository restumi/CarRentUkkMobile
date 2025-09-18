import 'package:car_rent_mobile_app/routes/app_route.dart';
import 'package:car_rent_mobile_app/widgets/build_dialog.dart';
import 'package:flutter/material.dart';
import '../../styles/app_color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  File? _profileImage;

  void _back(BuildContext context) {
    Navigator.pushNamed(
      context,
      AppRouter.profile,
      arguments: SlideDirection.left,
    );
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              child: Image.asset(
                "assets/images/headerHome.png",
                width: MediaQuery.of(context).size.width * 0.4,
              ),
            ),

            // ===== Content =====
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Profile Title
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          size: 20,
                          color: AppColors.white,
                        ),
                        onPressed: () => _back(context),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Profile",
                          style: GoogleFonts.rubik(
                            color: AppColors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),

                  // Avatar
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: AppColors.white,
                        backgroundImage: _profileImage != null
                            ? FileImage(_profileImage!)
                            : null,
                        child: _profileImage == null
                            ? Icon(
                                Icons.person,
                                color: AppColors.black,
                                size: 60,
                              )
                            : null,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 4,
                        child: GestureDetector(
                          onTap: _pickImage,
                          child: const CircleAvatar(
                            radius: 18,
                            backgroundColor: AppColors.blue,
                            child: Icon(
                              Icons.camera_alt,
                              color: AppColors.white,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Username
                  Text(
                    "User",
                    style: GoogleFonts.rubik(
                      color: AppColors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Menu Items
                  Column(
                    children: [
                      _buildMenuItem(
                        icon: Icons.vpn_key,
                        title: "cange username",
                        onTap: () => showDialog(
                          context: context,
                          builder: (context) => const CangeUserName(),
                        ),
                      ),
                      _buildMenuItem(
                        icon: Icons.history,
                        title: "cange password",
                        onTap: () => showDialog(
                          context: context,
                          builder: (context) => const CangePassword(),
                        ),
                      ),
                      _buildMenuItem(
                        icon: Icons.article,
                        title: "logout",
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => const LogoutDialog(),
                          );
                        },
                        color: AppColors.red,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color color = AppColors.white,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.white24, width: 1)),
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(width: 16),
            Text(title, style: GoogleFonts.rubik(color: color, fontSize: 15)),
          ],
        ),
      ),
    );
  }
}
