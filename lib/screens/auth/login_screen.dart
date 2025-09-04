import 'package:flutter/material.dart';
import 'register_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscurePassword = true;

  void _submitLogin() {
    if (_formKey.currentState!.validate()) {
      // TODO: login logic
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Login berhasil!")));
    }
  }

  void _handleRegist() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => const RegisterScreen()
        )
    );
  }

  InputDecoration _inputDecoration(
    String label,
    IconData icon, {
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      labelText: label,
      labelStyle: GoogleFonts.rubik(color: Colors.white70),
      prefixIcon: Icon(icon, color: Colors.white70),
      suffixIcon: suffixIcon,
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.white54),
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color.fromARGB(255, 0, 100, 249)),
        borderRadius: BorderRadius.circular(12),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(12),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // ===== Content =====
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 180),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hello",
                        style: GoogleFonts.rubik(
                          color: Colors.white,
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                          height: 1,
                        ),
                      ),
                      Text(
                        "Login to your account",
                        style: GoogleFonts.rubik(
                          color: Colors.white,
                          fontSize: 16,
                          height: 1,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),

                  // ===== FORM =====
                  Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _emailController,
                          style: GoogleFonts.rubik(color: Colors.white),
                          decoration: _inputDecoration("Email", Icons.email),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Email tidak boleh kosong";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: _obscurePassword,
                          style: GoogleFonts.rubik(color: Colors.white),
                          decoration: _inputDecoration(
                            "Password",
                            Icons.lock,
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.white70,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Password tidak boleh kosong";
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 50),

                  //   ===== text "dont have an account" =====
                  Row(
                    children: [
                      const Spacer(flex: 1,),
                      Text(
                        "Don't have an account?",
                        style: GoogleFonts.rubik(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // ===== BUTTONS =====
                  Row(
                    children: [
                      // ===== Login button =====
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _submitLogin,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(
                              255,
                              0,
                              100,
                              249,
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Text(
                            "Log In",
                            style: GoogleFonts.rubik(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),

                      // ===== Register button =====
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _handleRegist,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(
                              255,
                              0,
                              100,
                              249,
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Register",
                                style: GoogleFonts.rubik(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Image.asset(
                                "assets/icons/leftArrow.png",
                                width: 27,
                                height: 27,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // ===== HEADER =====
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
