import 'package:car_rent_mobile_app/screens/driver/driver_screen.dart';
import 'package:car_rent_mobile_app/screens/home/home_screen.dart';
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
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  void _goTodriver(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const DriverScreen()),
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
