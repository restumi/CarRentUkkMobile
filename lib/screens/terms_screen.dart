import 'package:flutter/material.dart';
import 'auth/login_screen.dart';

class TermsScreen extends StatefulWidget {
  const TermsScreen({super.key});

  @override
  State<TermsScreen> createState() => _TermsScreenState();
}

class _TermsScreenState extends State<TermsScreen> {
  bool isChecked = false;
  bool showWarning = false;

  void _handleAccept() {
    if (!isChecked) {
      setState(() {
        showWarning = true;
      });
      return;
    }

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
                child: Image.asset("assets/images/logoBiru.png", width: 250),
              ),

              // ===== Title =====
              const Text(
                "Terms App",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),

              // ===== terms text =====
              const Text(
                "1. Contoh\n"
                "Pastikan pengguna menyadari bahwa mereka menyetujui syarat dan ketentuan saat menggunakan aplikasi Anda. ...",
                style: TextStyle(
                  color: Colors.white,
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
                  const Expanded(
                    child: Text(
                      "Saya telah membaca dan menyetujui peraturan yang tertulis.",
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ],
              ),

              // ===== warning text =====
              if (showWarning)
                const Padding(
                  padding: EdgeInsets.only(left: 8, top: 4),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "⚠️ Anda harus menyetujui syarat & ketentuan terlebih dahulu",
                      style: TextStyle(
                        color: Colors.red,
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
                    backgroundColor: const Color.fromARGB(255, 0, 100, 249),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Accept",
                        style: TextStyle(
                          color: Colors.white,
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
