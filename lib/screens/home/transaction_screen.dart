import 'package:flutter/material.dart';
import '../../styles/app_color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'detail_car_screen.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  void handleBack() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const DetailCarScreen()),
    );
  }

  bool isChecked = false;
  DateTime? _startDate;
  DateTime? _endDate;
  DateTime today = DateTime.now();

  bool _isDateValid(DateTime date) {
    return date.isAfter(DateTime.now().subtract(const Duration(days: 1)));
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      if (_startDate == null) {
        _startDate = selectedDay;
        _endDate = null;
      } else if (_endDate == null && selectedDay.isAfter(_startDate!)) {
        _endDate = selectedDay;
      } else if (selectedDay.isBefore(_startDate!)) {
        _startDate = selectedDay;
        _endDate = null;
      }
      // Penting: update focusedDay agar kalender tetap di bulan yang relevan
      today = focusedDay;
    });
  }

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
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: AppColors.white,
                      size: 20,
                    ),
                    onPressed: handleBack,
                  ),
                  const SizedBox(height: 10),

                  // ===== Choose Date =====
                  Text(
                    "Choose Date",
                    style: GoogleFonts.rubik(
                      color: AppColors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),

                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 14,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.black,
                            border: Border.all(color: AppColors.abuGelap),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                DateFormat(
                                  'dd/MM/yyyy',
                                ).format(_startDate ?? today),
                                style: GoogleFonts.rubik(
                                  color: AppColors.white,
                                  fontSize: 14,
                                ),
                              ),
                              const Icon(
                                Icons.calendar_today,
                                color: AppColors.white,
                                size: 18,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 14,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.black,
                            border: Border.all(color: AppColors.abuGelap),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                DateFormat(
                                  'dd/MM/yyyy',
                                ).format(_endDate ?? today),
                                style: GoogleFonts.rubik(
                                  color: AppColors.white,
                                  fontSize: 14,
                                ),
                              ),
                              const Icon(
                                Icons.calendar_today,
                                color: AppColors.white,
                                size: 18,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // ===== Calendar widget =====
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.blue,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TableCalendar(
                      focusedDay: today,
                      firstDay: DateTime.utc(2000, 1, 1),
                      lastDay: DateTime.utc(2030, 12, 31),
                      calendarFormat: CalendarFormat.month,
                      startingDayOfWeek: StartingDayOfWeek.monday,
                      daysOfWeekStyle: DaysOfWeekStyle(
                        weekdayStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        weekendStyle: TextStyle(
                          color: AppColors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      headerStyle: HeaderStyle(
                        titleTextStyle: GoogleFonts.rubik(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        formatButtonVisible: false,
                        leftChevronIcon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                        rightChevronIcon: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        ),
                      ),
                      calendarStyle: CalendarStyle(
                        outsideDaysVisible: false,
                        defaultTextStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                        selectedTextStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        todayTextStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                        selectedDecoration: BoxDecoration(
                          color: AppColors.blue,
                          shape: BoxShape.circle,
                        ),
                        todayDecoration: BoxDecoration(
                          color: const Color.fromARGB(100, 255, 255, 255),
                          shape: BoxShape.circle,
                        ),
                        weekendTextStyle: TextStyle(color: Colors.grey[400]),
                      ),
                      onDaySelected: _onDaySelected,
                      enabledDayPredicate: (day) {
                        return _isDateValid(day);
                      },
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
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
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
                        SizedBox(
                          height: 20,
                          width: 20,
                          child: Checkbox(
                            value: isChecked,
                            activeColor: AppColors.blue,
                            onChanged: (value) {
                              setState(() {
                                isChecked = value ?? false;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Transfer Option
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
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
                        SizedBox(
                            height: 20,
                            width: 20,
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: AppColors.white,
                            size: 18,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),

                  // ===== Rent Now Button =====
                  Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 14,
                      ),
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
                          Image.asset("assets/icons/leftArrow.png", width: 22),
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
