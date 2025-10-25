import 'dart:io';
import 'package:car_rent_mobile_app/routes/app_route.dart';
import 'package:car_rent_mobile_app/services/api_service.dart';
import 'package:car_rent_mobile_app/services/micro_services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class VerificationScreen extends StatefulWidget {
  final String name;
  final String email;
  final String password;
  final String passwordConfirmation;

  const VerificationScreen({
    super.key,
    required this.name,
    required this.email,
    required this.password,
    required this.passwordConfirmation,
  });

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;
  final TextEditingController _nikController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  File? _ktpImage;
  File? _faceImage;

  Future<void> _pickImage(bool isKtp) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        if (isKtp) {
          _ktpImage = File(pickedFile.path);
        } else {
          _faceImage = File(pickedFile.path);
        }
      });
    }
  }

  void _submitVerification() async {
    if (_formKey.currentState!.validate() &&
        _ktpImage != null &&
        _faceImage != null) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );

      try {
        final response = await ApiService.regist(
          name: widget.name,
          email: widget.email,
          password: widget.password,
          passwordConfirmation: widget.passwordConfirmation,
          phoneNumber: _phoneController.text.trim(),
          address: _addressController.text.trim(),
          nik: _nikController.text.trim(),
          ktpImage: _ktpImage!,
          faceImage: _faceImage!,
        );

        await AuthService.saveVerifyData(
          email: widget.email,
          status: response['data']['status'],
        );

        if (mounted) Navigator.pop(context);

        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(response['message'])));
          Navigator.pushNamed(context, AppRouter.waiting);
        }
      } catch (e) {
        if (mounted) Navigator.pop(context);

        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Error: $e')));
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Lengkapi semua data & upload gambar!")),
      );
      setState(() {
        _autoValidateMode = AutovalidateMode.always;
      });
    }
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
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 150),

                  Text(
                    "Verification",
                    style: GoogleFonts.rubik(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Mohon masukan data dengan benar",
                    style: GoogleFonts.rubik(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 30),

                  Form(
                    key: _formKey,
                    autovalidateMode: _autoValidateMode,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _nikController,
                          style: GoogleFonts.rubik(color: Colors.white),
                          decoration: _inputDecoration(
                            "NIK",
                            Icons.credit_card,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "NIK tidak boleh kosong";
                            }
                            return null;
                          },
                          onChanged: (_) {
                            if (_autoValidateMode == AutovalidateMode.always) {
                              setState(() {});
                            }
                          },
                        ),
                        const SizedBox(height: 16),

                        TextFormField(
                          controller: _phoneController,
                          style: GoogleFonts.rubik(color: Colors.white),
                          decoration: _inputDecoration(
                            "Phone number",
                            Icons.phone_android,
                          ),
                          validator: (value) => value!.isEmpty
                              ? "Nomor telepon tidak boleh kosong"
                              : null,
                          onChanged: (_) {
                            if (_autoValidateMode == AutovalidateMode.always) {
                              setState(() {});
                            }
                          },
                        ),
                        const SizedBox(height: 16),

                        TextFormField(
                          controller: _addressController,
                          style: GoogleFonts.rubik(color: Colors.white),
                          decoration: _inputDecoration("Address", Icons.home),
                          validator: (value) => value!.isEmpty
                              ? "Alamat tidak boleh kosong"
                              : null,
                          onChanged: (_) {
                            if (_autoValidateMode == AutovalidateMode.always) {
                              setState(() {});
                            }
                          },
                        ),
                        const SizedBox(height: 16),

                        // Upload KTP
                        GestureDetector(
                          onTap: () => _pickImage(true),
                          child: Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.white54),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.image, color: Colors.white70),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    _ktpImage == null
                                        ? "Upload KTP image"
                                        : "KTP image selected",
                                    style: GoogleFonts.rubik(
                                      color: Colors.white70,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Upload Face
                        GestureDetector(
                          onTap: () => _pickImage(false),
                          child: Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.white54),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.face, color: Colors.white70),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    _faceImage == null
                                        ? "Upload face image"
                                        : "Face image selected",
                                    style: GoogleFonts.rubik(
                                      color: Colors.white70,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _submitVerification,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0064F9),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Create Account",
                            style: GoogleFonts.rubik(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Icon(Icons.arrow_forward, color: Colors.white),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          //   ===== header =====
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
