import 'package:car_rent_mobile_app/styles/app_color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../services/auth_provider.dart';
import 'auth_wrapper.dart';

// ========== USERNAME DIALOG ===========
class CangeUserName extends StatefulWidget {
  const CangeUserName({super.key});

  @override
  State<CangeUserName> createState() => _CangeUserNameState();
}

class _CangeUserNameState extends State<CangeUserName> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
        decoration: BoxDecoration(
          color: AppColors.abugelap2,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Cange Username",
              style: GoogleFonts.rubik(
                color: AppColors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 24),
            TextField(
              style: GoogleFonts.rubik(color: AppColors.white),
              decoration: InputDecoration(
                hintText: "Enter new username",
                hintStyle: GoogleFonts.rubik(color: Colors.white54),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white30),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.blue),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 32,
                    ),
                    foregroundColor: AppColors.red,
                    side: BorderSide(color: AppColors.red),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    "Cancel",
                    style: GoogleFonts.rubik(color: AppColors.red),
                  ),
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 32,
                    ),
                    foregroundColor: AppColors.blue,
                    side: BorderSide(color: AppColors.blue),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    "Save",
                    style: GoogleFonts.rubik(color: AppColors.blue),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ========== PASSWORD DIALOG ==========
class CangePassword extends StatefulWidget {
  const CangePassword({super.key});

  @override
  State<CangePassword> createState() => _CangePasswordState();
}

class _CangePasswordState extends State<CangePassword> {
  bool _obscureOld = true;
  bool _obscureNew = true;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 32),
        decoration: BoxDecoration(
          color: AppColors.abugelap2,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Cange Password",
              style: GoogleFonts.rubik(
                color: AppColors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 24),

            // old pas
            TextField(
              obscureText: _obscureOld,
              style: GoogleFonts.rubik(color: AppColors.white),
              decoration: InputDecoration(
                hintText: "Old password",
                hintStyle: GoogleFonts.rubik(color: Colors.white54),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white30),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.blue),
                  borderRadius: BorderRadius.circular(8),
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _obscureOld = !_obscureOld;
                    });
                  },
                  icon: Icon(
                    _obscureOld ? Icons.visibility_off : Icons.visibility,
                    color: Colors.white54,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // New Password
            TextField(
              obscureText: _obscureNew,
              style: GoogleFonts.rubik(color: AppColors.white),
              decoration: InputDecoration(
                hintText: "New password",
                hintStyle: GoogleFonts.rubik(color: Colors.white54),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white30),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.blue),
                  borderRadius: BorderRadius.circular(8),
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _obscureNew = !_obscureNew;
                    });
                  },
                  icon: Icon(
                    _obscureNew ? Icons.visibility_off : Icons.visibility,
                    color: Colors.white54,
                  ),
                ),
              ),
            ),
            SizedBox(height: 12,),

            //Confirm Pass
            TextField(
              obscureText: _obscureNew,
              style: GoogleFonts.rubik(color: AppColors.white),
              decoration: InputDecoration(
                hintText: "Confirm password",
                hintStyle: GoogleFonts.rubik(color: Colors.white54),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white30),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.blue),
                  borderRadius: BorderRadius.circular(8),
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _obscureNew = !_obscureNew;
                    });
                  },
                  icon: Icon(
                    _obscureNew ? Icons.visibility_off : Icons.visibility,
                    color: Colors.white54,
                  ),
                ),
              ),
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 32),
                    foregroundColor: AppColors.red,
                    side: BorderSide(color: AppColors.red),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    "Cancel",
                    style: GoogleFonts.rubik(color: AppColors.red),
                  ),
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 32),
                    foregroundColor: AppColors.blue,
                    side: BorderSide(color: AppColors.blue),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    "Save",
                    style: GoogleFonts.rubik(color: AppColors.blue),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ========== LOGOUT DIALOG ==========
class LogoutDialog extends StatefulWidget {
  const LogoutDialog({super.key});

  @override
  State<LogoutDialog> createState() => _LogoutDialogState();
}

class _LogoutDialogState extends State<LogoutDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
        decoration: BoxDecoration(
          color: AppColors.abugelap2,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.warning_amber_rounded, size: 48, color: AppColors.red),
            Text(
              "logout",
              style: GoogleFonts.rubik(
                color: AppColors.red,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 24),
            Text(
              "Yakin nih mau logout? Pastikan anda ingat email dan password untuk logout",
              textAlign: TextAlign.center,
              style: GoogleFonts.rubik(color: AppColors.white),
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 32,
                    ),
                    foregroundColor: AppColors.white,
                    side: BorderSide(color: AppColors.white),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: Text("Cancel"),
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 32,
                    ),
                    foregroundColor: AppColors.red,
                    side: BorderSide(color: AppColors.red),
                  ),
                  onPressed: () async {
                    final authProvider = Provider.of<AuthProvider>(context, listen: false);
                    await authProvider.logout();
                    
                    if (context.mounted) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const AuthWrapper()),
                        (route) => false,
                      );
                    }
                  },
                  child: Text("Logout"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
