import 'package:car_rent_mobile_app/routes/app_route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../styles/app_color.dart';

class DetailCarScreen extends StatelessWidget {
  final dynamic dummyCars;
  const DetailCarScreen({super.key, required this.dummyCars});

  @override
  Widget build(BuildContext context) {
    void handleBackToHome() {
      Navigator.pushNamed(
        context,
        AppRouter.home,
        arguments: SlideDirection.left,
      );
    }

    void handleBookTransaction() {
      Navigator.pushNamed(context, AppRouter.transaction);
    }

    return Scaffold(
      backgroundColor: AppColors.black,
      body: Stack(
        children: [
          // ===== Background abu gelap (hanya sampai bawah mobil) =====
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.5,
              decoration: const BoxDecoration(
                color: AppColors.abugelap2,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Stack(
                children: [
                  // ===== Header Image =====
                  Positioned(
                    top: 30,
                    right: 0,
                    child: Image.asset(
                      "assets/images/headerHome.png",
                      width: MediaQuery.of(context).size.width * 0.4,
                    ),
                  ),

                  // ===== Konten di dalam SafeArea =====
                  SafeArea(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        // ===== Back Button dan Car Details =====
                        Padding(
                          padding: const EdgeInsets.only(left: 25),
                          child: IconButton(
                            icon: const Icon(
                              Icons.arrow_back_ios,
                              color: AppColors.white,
                              size: 20,
                            ),
                            onPressed: handleBackToHome,
                          ),
                        ),
                        const SizedBox(height: 20),

                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 8),
                              Text(
                                "Car Details",
                                style: GoogleFonts.rubik(
                                  color: AppColors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                dummyCars.name,
                                style: GoogleFonts.rubik(
                                  color: AppColors.white,
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 40),

                        Center(
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                                Container(
                                    width: 250,
                                    height: 60,
                                    decoration: BoxDecoration(
                                        color: Color.fromARGB(125, 0, 0, 0),
                                        borderRadius: BorderRadius.circular(100)
                                    ),
                                ),
                                Image.asset(
                                    dummyCars.image,
                                    width: 300,
                                ),
                            ],
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.55),

                // ===== Driver Cards =====
                SizedBox(
                  height: 120,
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    scrollDirection: Axis.horizontal,
                    children: [
                      _driverOption(
                        "Without Driver",
                        "assets/images/driver.png",
                      ),
                      _driverOption("Driver Name", "assets/images/driver.png"),
                      _driverOption("Driver Name", "assets/images/driver.png"),
                      _driverOption("Driver Name", "assets/images/driver.png"),
                      _driverOption("Driver Name", "assets/images/driver.png"),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // ===== Info Mobil =====
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _carInfo("Gear", "Matic", Icons.settings),
                      _carInfo("Seats", "6", Icons.event_seat),
                      _carInfo("Speeds", "120", Icons.speed),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ===== Bottom Bar =====
          Positioned(
            left: 20,
            right: 20,
            bottom: 12,
            child: Container(
              padding: const EdgeInsets.only(
                right: 3,
                top: 3,
                bottom: 3,
                left: 15,
              ),
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: AppColors.abuGelap),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Rp 1.000.000 / day",
                    style: GoogleFonts.rubik(
                      color: AppColors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: handleBookTransaction,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.blue,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Row(
                        children: [
                          Text(
                            "Book now",
                            style: GoogleFonts.rubik(
                              color: AppColors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Image.asset("assets/icons/leftArrow.png", width: 25),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===== Driver Card =====
  Widget _driverOption(String text, String iconPath) {
    return Container(
      width: 115,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: AppColors.abugelap2,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(iconPath, width: 40, height: 40),
          const SizedBox(height: 8),
          Text(
            text,
            textAlign: TextAlign.center,
            style: GoogleFonts.rubik(color: AppColors.white, fontSize: 12),
          ),
        ],
      ),
    );
  }

  // ===== Car Info =====
  Widget _carInfo(String title, String value, IconData icon) {
    return Container(
      width: 120,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.abuGelap),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: GoogleFonts.rubik(
              color: AppColors.white,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Icon(icon, color: AppColors.white, size: 40),
          const SizedBox(height: 5),
          Text(
            value,
            style: GoogleFonts.rubik(
              color: AppColors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
