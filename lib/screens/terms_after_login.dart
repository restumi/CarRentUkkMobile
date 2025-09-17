import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../styles/app_color.dart';

class TermsAfterLogin extends StatefulWidget {
  const TermsAfterLogin({super.key});

  @override
  State<TermsAfterLogin> createState() => _TermsAfterLoginState();
}

class _TermsAfterLoginState extends State<TermsAfterLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // ===== logo =====
              Center(
                // child: Image.asset("assets/images/logoBiru.png", width: 250),
                child: Column(
                    children: [
                        Image.asset("assets/images/logoBiru.png", width: 180,),
                        Text(
                            "Terms App",
                            style: GoogleFonts.rubik(
                                color: AppColors.abuTerang,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                height: 1,
                            ),
                        )
                    ],
                ),
              ),
              const SizedBox(height: 50),

              // ===== terms text =====
              Text(
                "1. Contoh\n"
                "Pastikan pengguna menyadari bahwa mereka menyetujui syarat dan ketentuan saat menggunakan aplikasi Anda. ...",
                style: GoogleFonts.rubik(
                  color: AppColors.abuTerang,
                  fontSize: 14,
                  height: 1.4,
                ),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
    );
  }
}