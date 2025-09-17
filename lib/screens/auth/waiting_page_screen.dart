import 'package:car_rent_mobile_app/routes/app_route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../styles/app_color.dart';

class WaitingScreen extends StatelessWidget {
  const WaitingScreen({super.key});

  void _goToLogin(BuildContext context) {
    Navigator.pushNamed(
      context,
      AppRouter.login
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Stack(
        children: [
          // ===== CONTENT =====
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                    SizedBox(height: 60,),
                  // ===== CARD CONTAINER =====
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.blue[100],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        // Gambar jam + awan
                        Image.asset(
                          "assets/images/waitingPage.png",
                          width: 200,
                        ),
                        const SizedBox(height: 20),

                        // Text WAITING
                        Text(
                          "WAITING",
                          style: GoogleFonts.rubik(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: AppColors.abuGelap,
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Text status
                        Text(
                          "status registrasi : pending",
                          style: GoogleFonts.rubik(
                            fontSize: 16,
                            color: AppColors.abuGelap,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Note kecil
                  Text(
                    "note : mohon tunggu, admin akan memverifikasi data anda. "
                    "Jika status berubah menjadi “approve” silahkan login. "
                    "Jika “rejected” lakukan registrasi ulang.",
                    style: GoogleFonts.rubik(
                      fontSize: 12,
                      color: Colors.white70,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 30),

                  // Tombol Log In
                  Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: ElevatedButton(
                        onPressed: () => _goToLogin(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.blue,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Log In",
                              style: GoogleFonts.rubik(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Image.asset(
                              "assets/icons/leftArrow.png",
                              width: 24,
                              height: 24,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ===== HEADER BACKGROUND =====
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              "assets/images/headerAuth.png",
              width: MediaQuery.of(context).size.width * 0.8,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
