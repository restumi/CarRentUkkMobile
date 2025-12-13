import 'package:car_rent_mobile_app/config/api_config.dart';
import 'package:car_rent_mobile_app/routes/app_route.dart';
import 'package:car_rent_mobile_app/services/api_service.dart';
import 'package:car_rent_mobile_app/services/micro_services/auth_service.dart';
import 'package:car_rent_mobile_app/services/models/driver_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../styles/app_color.dart';

class DetailCarScreen extends StatefulWidget {
  final Map<String, dynamic> carData;
  const DetailCarScreen({super.key, required this.carData});

  @override
  State<DetailCarScreen> createState() => _DetailCarScreenState();
}

class _DetailCarScreenState extends State<DetailCarScreen> {
  List<Driver> _drivers = [];
  Driver? _selectedDriver;

  @override
  void initState() {
    super.initState();
    _loadDrivers();
  }

  Future<void> _loadDrivers() async {
    try {
      final token = await AuthService.getToken();
      final driverJsonList = await ApiService.getDriver(token!);
      final drivers = driverJsonList
          .where((e) => (e as Map<String, dynamic>)['status'] == 'available')
          .map((e) => Driver.fromJson(e as Map<String, dynamic>))
          .toList();

      if (mounted) {
        setState(() {
          _drivers = drivers;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('failed to get drivers')));
      }

      print('[ERRRORRR DETAIL SCREEN] gagal mengambil data drivers : $e');
    }
  }

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
      Navigator.pushNamed(
        context,
        AppRouter.transaction,
        arguments: {
          'car': widget.carData,
          'driver': _selectedDriver
        }
      );
    }

    return Scaffold(
      backgroundColor: AppColors.black,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: LayoutBuilder(
              builder: (context, constrainets) {
                return IntrinsicHeight(
                  child: Container(
                    constraints: const BoxConstraints(minHeight: 350),
                    width: double.infinity,
                    decoration: BoxDecoration(
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
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                      widget.carData['name'] ?? 'Unknown name',
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
                                  alignment: Alignment.center,
                                  children: [
                                    ClipOval(
                                      child: Container(
                                        width: 250,
                                        height: 180,
                                        color: const Color.fromARGB(
                                          255,
                                          0,
                                          100,
                                          249,
                                        ),
                                      ),
                                    ),
                                    Image.network(
                                      '${AppConfig.storageUrl}/${widget.carData['image']}',
                                      width: 300,
                                      height: 200,
                                      fit: BoxFit.contain,
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
                );
              },
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
                      // without driver
                      _buildDriverCard(
                        name: 'Without Driver',
                        imageUrl: null,
                        isActive: _selectedDriver == null,
                        onTap: () {
                          setState(() {
                            _selectedDriver = null;
                          });
                        },
                      ),

                      if (_drivers.isEmpty)
                        const Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              AppColors.blue,
                            ),
                          ),
                        )
                      else
                        // list drivers
                        for (final driver in _drivers)
                          _buildDriverCard(
                            name: driver.name,
                            imageUrl: driver.image != '0'
                                ? '${AppConfig.storageUrl}/${driver.image}'
                                : null,
                            isActive: _selectedDriver == driver,
                            onTap: () {
                              setState(() {
                                _selectedDriver = driver;
                              });
                            },
                          ),
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
                      _carInfo("Gear", "amfibi", Icons.settings),
                      _carInfo(
                        "Seats",
                        (widget.carData['seat'] ?? 4).toString(),
                        Icons.event_seat,
                      ),
                      _carInfo(
                        "Brand",
                        widget.carData['brand'] ?? 'Unknown brand',
                        Icons.check_circle,
                      ),
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
                    "Rp ${widget.carData['pricePerDay'] ?? 350.000} / day",
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

  Widget _buildDriverCard({
    required String name,
    String? imageUrl,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: isActive ? AppColors.blue : AppColors.abugelap2,
          borderRadius: BorderRadius.circular(12),
          border: isActive ? Border.all(color: Colors.white, width: 2) : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (imageUrl != null)
              ClipOval(
                child: Image.network(
                  imageUrl,
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.person,
                    size: 40,
                    color: AppColors.white,
                  ),
                ),
              )
            else
              const Icon(Icons.person_off, size: 40, color: AppColors.white),
            const SizedBox(height: 8),
            Text(
              name,
              textAlign: TextAlign.center,
              style: GoogleFonts.rubik(
                color: AppColors.white,
                fontSize: 12,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
