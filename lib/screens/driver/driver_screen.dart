import 'package:car_rent_mobile_app/screens/home/home_screen.dart';
import 'package:car_rent_mobile_app/screens/profile/profile_screen.dart';
import 'package:car_rent_mobile_app/styles/app_color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../widgets/bottom_navbar.dart';

class DriverScreen extends StatefulWidget {
  const DriverScreen({super.key});

  @override
  State<DriverScreen> createState() => _DriverScreenState();
}

class _DriverScreenState extends State<DriverScreen> {
  void _goToHome(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  void _goToProfile(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const ProfileScreen()),
    );
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
                "Driver Screen",
                style: GoogleFonts.rubik(
                  color: AppColors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            CustomBottomNavbar(
              currentIndex: 1,
              onTap: (index) {
                if (index == 0) {
                  _goToHome(context);
                } else if (index == 2) {
                  _goToProfile(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
