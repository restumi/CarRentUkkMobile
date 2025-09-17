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

  @override
  Widget build(BuildContext context) {
    final filtered = transactions
        .where((t) => t["status"] == selectedFilter)
        .toList();

    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: AppColors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Transaction",
          style: GoogleFonts.rubik(
            color: AppColors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ===== Filter icons =====
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                _buildFilterIcon(Icons.send, "Requested"),
                _buildFilterIcon(Icons.cancel, "Rejected"),
                _buildFilterIcon(Icons.file_copy, "Accepted"),
                _buildFilterIcon(Icons.event_available, "Completed"),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "All Transaction",
              style: GoogleFonts.rubik(
                color: AppColors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
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
                    color: AppColors.abugelap2,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        trx["image"]!,
                        width: 100,
                      ),
                      const SizedBox(width: 12),
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
      child: Container(
        margin: const EdgeInsets.only(right: 20),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isActive ? AppColors.blue : AppColors.abugelap2,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.white, size: 28),
            const SizedBox(height: 6),
            Text(
              label,
              style: GoogleFonts.rubik(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
