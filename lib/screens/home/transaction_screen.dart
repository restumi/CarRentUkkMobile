import 'package:flutter/material.dart';
import '../../styles/app_color.dart';
import 'package:google_fonts/google_fonts.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: SafeArea(
        child: Stack(
          children: [
            // ===== Header Icon =====
            Positioned(
              top: 0,
              right: 0,
              child: Image.asset(
                "assets/images/headerHome.png",
                width: MediaQuery.of(context).size.width * 0.4,
              ),
            ),

            // ===== Content =====
            SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ===== Back Button =====
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios,
                        color: AppColors.white, size: 20),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(height: 10),

                  // ===== Choose Date =====
                  Text(
                    "Choose Date",
                    style: GoogleFonts.rubik(
                      color: AppColors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 10),

                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 14),
                          decoration: BoxDecoration(
                            color: AppColors.black,
                            border: Border.all(color: AppColors.abuGelap),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "09/12/2007",
                                style: GoogleFonts.rubik(
                                    color: AppColors.white, fontSize: 14),
                              ),
                              const Icon(Icons.calendar_today,
                                  color: AppColors.white, size: 18),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 14),
                          decoration: BoxDecoration(
                            color: AppColors.black,
                            border: Border.all(color: AppColors.abuGelap),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "11/12/2007",
                                style: GoogleFonts.rubik(
                                    color: AppColors.white, fontSize: 14),
                              ),
                              const Icon(Icons.calendar_today,
                                  color: AppColors.white, size: 18),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // ===== Calendar Dummy =====
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.blue,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: Text(
                        "Calendar Widget Placeholder",
                        style: GoogleFonts.rubik(
                          color: AppColors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // ===== Choose Payment =====
                  Text(
                    "Choose Payment",
                    style: GoogleFonts.rubik(
                      color: AppColors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // COD Option
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.abuGelap),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "COD",
                          style: GoogleFonts.rubik(
                            color: AppColors.white,
                            fontSize: 14,
                          ),
                        ),
                        const Icon(Icons.check_box,
                            color: AppColors.blue, size: 20),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Transfer Option
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.abuGelap),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Transfer",
                          style: GoogleFonts.rubik(
                            color: AppColors.white,
                            fontSize: 14,
                          ),
                        ),
                        const Icon(Icons.arrow_forward_ios,
                            color: AppColors.white, size: 18),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),

                  // ===== Rent Now Button =====
                  Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 14),
                      decoration: BoxDecoration(
                        color: AppColors.blue,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Rent Now",
                            style: GoogleFonts.rubik(
                              color: AppColors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Image.asset(
                            "assets/icons/rightArrow.png",
                            width: 22,
                          ),
                        ],
                      ),
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
}