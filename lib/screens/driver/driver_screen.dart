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
    final List<Map<String, String>> drivers = [
      {"name": "Mr. Aldrick", "age": "25 th", "gender": "Male", "job": "Student"},
      {"name": "Mr. John", "age": "25 th", "gender": "Male", "job": "Student"},
      {"name": "Mr. David", "age": "25 th", "gender": "Male", "job": "Student"},
      {"name": "Mr. Kevin", "age": "25 th", "gender": "Male", "job": "Student"},
    ];

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

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Text(
                    "Hi, User",
                    style: GoogleFonts.rubik(
                      color: AppColors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Text(
                    "Our drivers",
                    style: GoogleFonts.rubik(
                      color: AppColors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // List Drivers
                  Expanded(
                    child: ListView.builder(
                      itemCount: drivers.length,
                      itemBuilder: (context, index) {
                        final driver = drivers[index];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.abugelap2,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Foto Driver
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  "assets/images/driver.png",
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 16),

                              // Info Driver
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    driver["name"]!,
                                    style: GoogleFonts.rubik(
                                      color: AppColors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    driver["age"]!,
                                    style: GoogleFonts.rubik(
                                      color: AppColors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    driver["gender"]!,
                                    style: GoogleFonts.rubik(
                                      color: AppColors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    driver["job"]!,
                                    style: GoogleFonts.rubik(
                                      color: AppColors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
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
              labels: [
                "Home",
                "Drivers",
                "Profile"
              ],
            ),
          ],
        ),
      ),
    );
  }
}
