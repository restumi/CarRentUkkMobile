import 'package:car_rent_mobile_app/routes/app_route.dart';

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
    Navigator.pushNamed(context, AppRouter.home, arguments: SlideDirection.left);
  }

  void _goToProfile(BuildContext context) {
    Navigator.pushNamed(context, AppRouter.profile);
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
              icons: [
                Icons.home,
                Icons.person_pin,
                Icons.person
              ],
            ),
          ],
        ),
      ),
    );
  }
}
