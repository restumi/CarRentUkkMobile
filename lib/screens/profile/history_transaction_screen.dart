import 'package:car_rent_mobile_app/routes/app_route.dart';
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

  void _back(BuildContext context) {
    Navigator.pushNamed(context, AppRouter.profile, arguments: SlideDirection.left);
  }

  @override
  Widget build(BuildContext context) {
    final filtered = transactions
        .where((t) => t["status"] == selectedFilter)
        .toList();

    return Scaffold(
      backgroundColor: AppColors.black,
      // appBar: AppBar(
      //   backgroundColor: AppColors.black,
      //   elevation: 0,
      //   leading: IconButton(
      //     icon: const Icon(Icons.arrow_back_ios, color: AppColors.white),
      //     onPressed: () => Navigator.pop(context),
      //   ),
      //   title: Text(
      //     "Transaction",
      //     style: GoogleFonts.rubik(
      //       color: AppColors.white,
      //       fontWeight: FontWeight.bold,
      //     ),
      //   ),
      // ),
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
                        icon: Icon(Icons.arrow_back_ios, color: AppColors.white, size: 20,),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "History Transaction",
                          style: GoogleFonts.rubik(
                            color: AppColors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height:40,),

                  // ===== Filter icons =====
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildFilterIcon(Icons.send, "Requested"),
                      Container(width: 1, height: 60, color: const Color.fromARGB(174, 255, 255, 255)),
                      _buildFilterIcon(Icons.cancel, "Rejected"),
                      Container(width: 1, height: 60, color: const Color.fromARGB(174, 255, 255, 255)),
                      _buildFilterIcon(Icons.file_copy, "Accepted"),
                      Container(width: 1, height: 60, color: const Color.fromARGB(174, 255, 255, 255)),
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
                          SizedBox(width: 20,),
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
                            border: Border.all(color: AppColors.abuGelap)
                          ),
                          child: Row(
                            children: [
                              Image.asset(trx["image"]!, width: 100),
                              const SizedBox(width: 6),
                              Container(width: 1, height: 70, color: AppColors.abuGelap,),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      trx["car"]!,
                                      style: GoogleFonts.rubik(
                                        color: AppColors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      trx["days"]!,
                                      style: GoogleFonts.rubik(
                                        color: AppColors.abuTerang,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      trx["plate"]!,
                                      style: GoogleFonts.rubik(
                                        color: AppColors.abuTerang,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      trx["status"]!,
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
            const SizedBox(height: 4,),
            Text(
              label,
              style: GoogleFonts.rubik(
                color: isActive ? AppColors.blue : AppColors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold
              ),
            )
          ],
        ),
      )
    );
  }
}
