import 'package:car_rent_mobile_app/routes/app_route.dart';
import 'package:car_rent_mobile_app/widgets/bottom_navbar.dart';
import 'package:flutter/material.dart';
import '../../styles/app_color.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  void _goToHome(BuildContext context) {
    Navigator.pushNamed(
      context,
      AppRouter.home,
      arguments: SlideDirection.left,
    );
  }

  void _temrs(BuildContext context) {
    Navigator.pushNamed(
        context,
        AppRouter.terms
    );
  }

  void _goTodriver(BuildContext context) {
    Navigator.pushNamed(
      context,
      AppRouter.driver,
      arguments: SlideDirection.left,
    );
  }

  void _infoAccount(BuildContext context) {
    Navigator.pushNamed(context, AppRouter.infoAccount);
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
                  const SizedBox(height: 30),

                  // Avatar
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: AppColors.white,
                    child: Icon(Icons.person, size: 60, color: AppColors.black),
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
                        title: "Info Account",
                        onTap: () => _infoAccount(context),
                      ),
                      _buildMenuItem(
                        icon: Icons.history,
                        title: "History Transaction",
                        onTap: () {},
                      ),
                      _buildMenuItem(
                        icon: Icons.article,
                        title: "Terms App",
                        onTap: () => _temrs(context),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            CustomBottomNavbar(
              currentIndex: 2,
              onTap: (index) {
                if (index == 0) {
                  _goToHome(context);
                } else if (index == 1) {
                  _goTodriver(context);
                }
              },
              icons: [Icons.home, Icons.person_pin, Icons.person],
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
            Icon(icon, color: Colors.white, size: 22),
            const SizedBox(width: 16),
            Text(
              title,
              style: GoogleFonts.rubik(color: Colors.white, fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
