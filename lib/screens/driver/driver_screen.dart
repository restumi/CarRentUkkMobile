import 'package:car_rent_mobile_app/config/api_config.dart';
import 'package:car_rent_mobile_app/routes/app_route.dart';
import 'package:car_rent_mobile_app/services/api_service.dart';
import 'package:car_rent_mobile_app/services/micro_services/auth_service.dart';
import 'package:car_rent_mobile_app/services/models/driver_model.dart';
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
  String? _username = 'user';
  List<Driver> _drivers = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    // username
    final userData = await AuthService.getUserData();

    if (userData != null && userData.containsKey('name')) {
      if (mounted) {
        setState(() {
          _username = userData['name'];
        });
      }
    }

    // load drivers
    try {
      final token = await AuthService.getToken();
      final driverData = await ApiService.getDriver(token!);
      final drivers = driverData
          .map((e) => Driver.fromJson(e as Map<String, dynamic>))
          .toList();
      if (mounted) {
        setState(() {
          _drivers = drivers;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Failed to load drivers')));
    }
  }

  void _goToHome(BuildContext context) {
    Navigator.pushNamed(
      context,
      AppRouter.home,
      arguments: SlideDirection.left,
    );
  }

  void _goToProfile(BuildContext context) {
    Navigator.pushNamed(context, AppRouter.profile);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.blue),
        )));
    }

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
                    "Hi, $_username",
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
                      itemCount: _drivers.length,
                      itemBuilder: (context, index) {
                        final driver = _drivers[index];
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
                                child: driver.image != '0'
                                    ? Image.network(
                                        "${AppConfig.storageUrl}/${driver.image}",
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                Image.asset(
                                                  "assets/images/driver.png",
                                                  width: 100,
                                                  height: 100,
                                                  fit: BoxFit.cover,
                                                ),
                                      )
                                    : Image.asset(
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
                                    driver.name,
                                    style: GoogleFonts.rubik(
                                      color: AppColors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${driver.age} th',
                                    style: GoogleFonts.rubik(
                                      color: AppColors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    driver.gender,
                                    style: GoogleFonts.rubik(
                                      color: AppColors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    driver.status,
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
              icons: [Icons.home, Icons.person_pin, Icons.person],
              labels: ["Home", "Drivers", "Profile"],
            ),
          ],
        ),
      ),
    );
  }
}
