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
    Navigator.pushNamed(context, AppRouter.home, arguments: SlideDirection.left);
  }

  void _goTodriver(BuildContext context) {
    Navigator.pushNamed(context, AppRouter.driver, arguments: SlideDirection.left);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Text(
                "Profile Screen",
                style: GoogleFonts.rubik(
                  color: AppColors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
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
            ),
          ],
        ),
      ),
    );
  }
}
