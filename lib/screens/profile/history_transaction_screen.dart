import 'package:car_rent_mobile_app/config/api_config.dart';
import 'package:car_rent_mobile_app/routes/app_route.dart';
import 'package:car_rent_mobile_app/services/api_service.dart';
import 'package:car_rent_mobile_app/services/micro_services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../styles/app_color.dart';

class HistoryTransactionScreen extends StatefulWidget {
  const HistoryTransactionScreen({super.key});

  @override
  State<HistoryTransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<HistoryTransactionScreen> {
  String selectedFilter = "Requested";
  bool _loading = true;
  List<Map<String, dynamic>> _transaction = [];
  String? _error;

  final List<Map<String, String>> transactions = [
    {
      "car": "Porsche Cammon",
      "days": "3 days",
      "plate": "H 1234 CP",
      "status": "Requested",
      "image": "assets/images/cars/car.png",
    },
    {
      "car": "Porsche Cammon",
      "days": "3 days",
      "plate": "H 1234 CP",
      "status": "Rejected",
      "image": "assets/images/cars/car.png",
    },
    {
      "car": "Porsche Cammon",
      "days": "3 days",
      "plate": "H 1234 CP",
      "status": "Accepted",
      "image": "assets/images/cars/car.png",
    },
    {
      "car": "Porsche Cammon",
      "days": "3 days",
      "plate": "H 1234 CP",
      "status": "Completed",
      "image": "assets/images/cars/car.png",
    },
    {
      "car": "Porsche Cammon",
      "days": "3 days",
      "plate": "H 1234 CP",
      "status": "Completed",
      "image": "assets/images/cars/car.png",
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadTransaction();
  }

  Future<void> _loadTransaction() async {
    final token = await AuthService.getToken();

    if (token == null) {
      if (mounted) {
        Navigator.pushNamed(context, AppRouter.login);
        setState(() {
          _loading = false;
        });
      }
      return;
    }

    try {
      final List<dynamic> transaction = await ApiService.getTransaction(token);

      final List<Map<String, dynamic>> formatted = transaction
          .map((tx) => _formatTransaction(tx as Map<String, dynamic>))
          .toList();

      if (mounted) {
        setState(() {
          _transaction = formatted;
          _loading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _loading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('failed to get transaction data!')),
        );

        print('FAILED TO GET TRANSACTION : $e');
      }
    }
  }

  Map<String, dynamic> _formatTransaction(Map<String, dynamic> tx) {
    final car = tx['car'] as Map<String, dynamic>;
    final driver = tx['driver'] as Map<String, dynamic>?;

    String status = tx['status_transaction'] as String;
    status = status[0].toUpperCase() + status.substring(1);

    return {
      "car": car['name'],
      "days": "${_daysBetween(tx['start_date'], tx['end_date'])} days",
      "plate": "H XXXX XX",
      "status": status,
      "image": "${AppConfig.storageUrl}/${car['image']}",
      "payment_status": tx['payment_status'],
      "total_price": tx['total_price'],
      "driver": driver?['name'] ?? "without driver",
    };
  }

  int _daysBetween(String startStr, String endStr) {
    final start = DateTime.parse(startStr);
    final end = DateTime.parse(endStr);
    return end.difference(start).inDays;
  }

  void _back(BuildContext context) {
    Navigator.pushNamed(
      context,
      AppRouter.profile,
      arguments: SlideDirection.left,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        backgroundColor: AppColors.black,
        body: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.blue),
          ),
        ),
      );
    }

    if (_error != null) {
      return Scaffold(
        backgroundColor: AppColors.black,
        body: Center(child: Text('Error : $_error')),
      );
    }

    final filtered = _transaction
        .where((t) => t['status'] == selectedFilter)
        .toList();

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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => _back(context),
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: AppColors.white,
                          size: 20,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "History Transaction",
                          style: GoogleFonts.rubik(
                            color: AppColors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40),

                  // ===== Filter icons =====
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildFilterIcon(Icons.send, "Requested"),
                      Container(
                        width: 1,
                        height: 60,
                        color: const Color.fromARGB(174, 255, 255, 255),
                      ),
                      _buildFilterIcon(Icons.cancel, "Rejected"),
                      Container(
                        width: 1,
                        height: 60,
                        color: const Color.fromARGB(174, 255, 255, 255),
                      ),
                      _buildFilterIcon(Icons.file_copy, "Accepted"),
                      Container(
                        width: 1,
                        height: 60,
                        color: const Color.fromARGB(174, 255, 255, 255),
                      ),
                      _buildFilterIcon(Icons.event_available, "Completed"),
                    ],
                  ),
                  SizedBox(height: 40),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          SizedBox(width: 20),
                          Text(
                            "$selectedFilter Transaction",
                            style: GoogleFonts.rubik(
                              color: AppColors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // ===== Transaction list =====
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: filtered.length,
                      itemBuilder: (context, index) {
                        final trx = filtered[index];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.abuGelap),
                          ),
                          child: Row(
                            children: [
                              Image.network(trx["image"] as String, width: 100),
                              const SizedBox(width: 6),
                              Container(
                                width: 1,
                                height: 70,
                                color: AppColors.abuGelap,
                              ),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      trx["car"] as String,
                                      style: GoogleFonts.rubik(
                                        color: AppColors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      trx["days"] as String,
                                      style: GoogleFonts.rubik(
                                        color: AppColors.abuTerang,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      trx["driver"] as String,
                                      style: GoogleFonts.rubik(
                                        color: AppColors.abuTerang,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      trx["total_price"] as String,
                                      style: GoogleFonts.rubik(
                                        color: AppColors.white,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
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
          ],
        ),
      ),
    );
  }

  Widget _buildFilterIcon(IconData icon, String label) {
    final isActive = selectedFilter == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedFilter = label;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Icon(
              icon,
              color: isActive ? AppColors.blue : AppColors.white,
              size: 50,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: GoogleFonts.rubik(
                color: isActive ? AppColors.blue : AppColors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
