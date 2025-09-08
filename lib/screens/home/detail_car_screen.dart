import 'package:flutter/material.dart';
import '../../styles/app_color.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailCarScreen extends StatefulWidget {
  const DetailCarScreen({super.key});

  @override
  State<DetailCarScreen> createState() => _DetailCarScreen();
}

class _DetailCarScreen extends State<DetailCarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.black,
        body: Positioned(
            top: 1,
            left: 1,
            child: Text(
                "detail car screen",
                style: GoogleFonts.rubik(
                    color: AppColors.abuTerang,
                    fontSize: 90,
                    fontWeight: FontWeight.bold
                ),
            ),
        ),
    );
  }
}
