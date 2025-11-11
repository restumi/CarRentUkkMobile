import 'package:car_rent_mobile_app/routes/app_route.dart';
import 'package:car_rent_mobile_app/services/micro_services/auth_service.dart';
// import 'package:car_rent_mobile_app/services/micro_services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../styles/app_color.dart';
import '../../widgets/bottom_navbar.dart';
import 'package:car_rent_mobile_app/services/data/cars_dummy_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _username = 'user';

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  Future<void> _loadUsername() async {
    final userData = await AuthService.getUserData();

    if (userData != null && userData.containsKey('name')) {
      if (mounted) {
        setState(() {
          _username = userData['name'];
        });
      }
    }
  }

  void _goToDetail(BuildContext context, dynamic car) {
    Navigator.pushNamed(context, AppRouter.detailCar, arguments: car);
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
                    "Hi, ${_username ?? 'User'}",
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
                    itemCount: dummyCars.length,
                    itemBuilder: (context, index) {
                      final car = dummyCars[index];
                      return GestureDetector(
                        onTap: () => _goToDetail(context, car),
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
                                          car.name,
                                          style: GoogleFonts.rubik(
                                            color: Colors.white,
                                            fontSize: 14, // kecilin font
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          car.type,
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
                                          car.price,
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
                                top: -30,
                                left: 20,
                                right: 20,
                                child: SizedBox(
                                  height: 100,
                                  width: 259,
                                  child: Image.asset(
                                    car.image,
                                    fit: BoxFit.scaleDown,
                                  ),
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
              icons: [Icons.home, Icons.person_pin, Icons.person],
              labels: ["Home", "Drivers", "Profile"],
            ),
          ],
        ),
      ),
    );
  }
}
