import 'package:car_rent_mobile_app/routes/app_route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../styles/app_color.dart';
import '../../widgets/bottom_navbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _goToDetail(BuildContext context) {
    Navigator.pushNamed(context, AppRouter.detailCar);
  }

  void _goToDriver(BuildContext context) {
    Navigator.pushNamed(context, AppRouter.driver);
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ===== Header =====
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 40),
                  child: Text(
                    "Hi, User",
                    style: GoogleFonts.rubik(
                      color: AppColors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                // ===== Title =====
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 12,
                  ),
                  child: Text(
                    "Rent a car",
                    style: GoogleFonts.rubik(
                      color: AppColors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                // ===== Search Bar =====
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.abugelap2,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.search, color: AppColors.abuTerang),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: "Search Car . . .",
                              hintStyle: GoogleFonts.rubik(
                                color: Colors.white54,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // ===== List Mobil (scrollable) =====
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.only(
                      left: 24,
                      right: 24,
                      top: 30,
                    ),
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => _goToDetail(context),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 40),
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(top: 20),
                                height: 100,
                                padding: const EdgeInsets.only(
                                  bottom: 10,
                                  left: 10,
                                  right: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.abugelap2,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          "Porsche Cammon",
                                          style: GoogleFonts.rubik(
                                            color: Colors.white,
                                            fontSize: 14, // kecilin font
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          "Manual",
                                          style: GoogleFonts.rubik(
                                            color: Colors.white70,
                                            fontSize: 12, // kecilin font
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          "Rp 1.000.000",
                                          style: GoogleFonts.rubik(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          "Per Day",
                                          style: GoogleFonts.rubik(
                                            color: Colors.white70,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              // Mobil nongol di atas container
                              Positioned(
                                top: -95,
                                left: 20,
                                right: 20,
                                child: Image.asset(
                                  "assets/images/car.png",
                                  height: 220,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 50),
              ],
            ),

            // ===== Header Image di kanan =====
            Positioned(
              top: 0,
              right: 0,
              child: Image.asset(
                "assets/images/headerHome.png",
                width: MediaQuery.of(context).size.width * 0.4,
              ),
            ),

            CustomBottomNavbar(
              currentIndex: 0,
              onTap: (index) {
                if (index == 1) {
                  _goToDriver(context);
                } else if (index == 2) {
                  _goToProfile(context);
                }
              },
            ),

            // ===== Bottom Navbar =====
            // Positioned(
            //   bottom: 0,
            //   left: MediaQuery.of(context).size.width * 0.125,
            //   child: Container(
            //     width: MediaQuery.of(context).size.width * 0.75,
            //     padding: const EdgeInsets.symmetric(
            //       vertical: 20,
            //       horizontal: 30,
            //     ),
            //     decoration: const BoxDecoration(
            //       color: Color(0xFF0064F9),
            //       borderRadius: BorderRadius.all(Radius.circular(30)),
            //     ),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         Image.asset("assets/icons/home.png", width: 28),
            //         Image.asset("assets/icons/driver.png", width: 28),
            //         Image.asset("assets/icons/profil.png", width: 28),
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
