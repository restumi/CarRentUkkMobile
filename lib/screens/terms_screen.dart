import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'auth/login_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import '../styles/app_color.dart';
import '../services/auth_provider.dart';

class TermsScreen extends StatefulWidget {
  const TermsScreen({super.key});

  @override
  State<TermsScreen> createState() => _TermsScreenState();
}

class _TermsScreenState extends State<TermsScreen> {
  bool isChecked = false;
  bool showWarning = false;

  void _handleAccept() async {
    if (!isChecked) {
      setState(() {
        showWarning = true;
      });
      return;
    }

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await authProvider.setTermsAccepted(true);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

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
              const SizedBox(height: 10),

              // ===== checkbox =====
              Row(
                children: [
                  Checkbox(
                    value: isChecked,
                    activeColor: const Color.fromARGB(255, 0, 100, 249),
                    onChanged: (val) {
                      setState(() {
                        isChecked = val ?? false;
                        if (isChecked) showWarning = false;
                      });
                    },
                  ),
                  Expanded(
                    child: Text(
                      "Saya telah membaca dan menyetujui peraturan yang tertulis.",
                      style: GoogleFonts.rubik(color: AppColors.abuTerang, fontSize: 12),
                    ),
                  ),
                ],
              ),

              // ===== warning text =====
              if (showWarning)
                Padding(
                  padding: EdgeInsets.only(left: 8, top: 4),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "⚠️ Anda harus menyetujui syarat & ketentuan terlebih dahulu",
                      style: GoogleFonts.rubik(
                        color: AppColors.red,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 20),

              // ===== accept button =====
              SizedBox(
                width: 150,
                child: ElevatedButton(
                  onPressed: _handleAccept, // selalu aktif
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
                        "Accept",
                        style: GoogleFonts.rubik(
                          color: AppColors.abuTerang,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Image.asset(
                        "assets/icons/leftArrow.png",
                        width: 30,
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
