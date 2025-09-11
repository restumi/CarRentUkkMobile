import 'package:car_rent_mobile_app/styles/app_color.dart';
import 'package:flutter/material.dart';

class CustomBottomNavbar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavbar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 0,
        left: MediaQuery.of(context).size.width * 0.125,
        child: Container(
            width: MediaQuery.of(context).size.width * 0.75,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            decoration: const BoxDecoration(
                color: AppColors.blue,
                borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                    _buildNavItem(context, 0, "assets/icons/home.png"),
                    _buildNavItem(context, 1, "assets/icons/driver.png"),
                    _buildNavItem(context, 2, "assets/icons/profil.png"),
                ],
            ),
        ),
    );
  }

  Widget _buildNavItem(BuildContext context, int index, String iconPath){
    bool isActive = index == currentIndex;
    return GestureDetector(
        onTap: () => onTap(index),
        child: Image.asset(
            iconPath,
            width: 28,
            color: isActive ? AppColors.abuGelap : AppColors.white,
        ),
    );
  }
}
