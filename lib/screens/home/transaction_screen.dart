import 'package:car_rent_mobile_app/routes/app_route.dart';
import 'package:flutter/material.dart';
import '../../styles/app_color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusDay;
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusDay = focusDay;
      });
    }
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusDay) {
    setState(() {
      _selectedDay = null;
      _focusDay = focusDay;
      _rangeStart = start;
      _rangeEnd = end;
    });
  }

  void handleBack() {
    Navigator.pushNamed(context, AppRouter.detailCar, arguments: SlideDirection.left);
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Start date",
                              style: GoogleFonts.rubik(
                                color: AppColors.white,
                                fontSize: 16,
                              ),
                            ),
                            Container(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    DateFormat(
                                      'dd/MM/yyyy',
                                    ).format(_rangeStart ?? _focusDay),
                                    style: GoogleFonts.rubik(
                                      color: AppColors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const Icon(
                                    Icons.calendar_month_outlined,
                                    color: AppColors.white,
                                    size: 18,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "End date",
                              style: GoogleFonts.rubik(
                                color: AppColors.white,
                                fontSize: 16,
                              ),
                            ),
                            Container(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    DateFormat(
                                      'dd/MM/yyyy',
                                    ).format(_rangeEnd ?? _focusDay),
                                    style: GoogleFonts.rubik(
                                      color: AppColors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const Icon(
                                    Icons.calendar_month_outlined,
                                    color: AppColors.white,
                                    size: 18,
                                  ),
                                ],
                              ),
                            ),
                          ],
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
                      // ===== tanggal =====
                      firstDay: DateTime.utc(2000, 1, 1),
                      lastDay: DateTime.utc(2030, 12, 31),
                      focusedDay: _focusDay,
                      selectedDayPredicate: (day) =>
                          isSameDay(_selectedDay, day),
                      // ===== format =====
                      calendarFormat: _calendarFormat,
                      startingDayOfWeek: StartingDayOfWeek.monday,

                      // ===== range =====
                      onDaySelected: _onDaySelected,
                      rangeStartDay: _rangeStart,
                      rangeEndDay: _rangeEnd,
                      onRangeSelected: _onRangeSelected,
                      rangeSelectionMode: RangeSelectionMode.toggledOn,

                      // ===== header style =====
                      headerStyle: HeaderStyle(
                        formatButtonVisible: false,
                        titleCentered: true,
                        titleTextStyle: GoogleFonts.rubik(
                          color: AppColors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        leftChevronIcon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          size: 18,
                        ),
                        rightChevronIcon: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),

                      // ====== calendar style ======
                      calendarStyle: CalendarStyle(
                        outsideDaysVisible: false,
                        defaultTextStyle: GoogleFonts.rubik(
                          color: AppColors.white,
                        ),
                        weekendTextStyle: GoogleFonts.rubik(
                          color: AppColors.white,
                        ),
                        rangeStartDecoration: BoxDecoration(
                          color: AppColors.white,
                          shape: BoxShape.circle,
                        ),
                        rangeStartTextStyle: GoogleFonts.rubik(
                          color: AppColors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                        rangeEndDecoration: BoxDecoration(
                          color: AppColors.white,
                          shape: BoxShape.circle,
                        ),
                        rangeEndTextStyle: GoogleFonts.rubik(
                          color: AppColors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                        rangeHighlightColor: Color.fromARGB(123, 255, 255, 255),
                        withinRangeTextStyle: GoogleFonts.rubik(
                          color: AppColors.white,
                        ),
                        disabledTextStyle: GoogleFonts.rubik(
                          color: AppColors.abuGelap,
                        ),
                      ),

                      // ===== week style =====
                      daysOfWeekStyle: DaysOfWeekStyle(
                        weekdayStyle: GoogleFonts.rubik(
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        weekendStyle: GoogleFonts.rubik(
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      locale: 'id-ID',
                      onFormatChanged: (format) {
                        if (_calendarFormat != format) {
                          setState(() {
                            _calendarFormat = format;
                          });
                        }
                      },
                      onPageChanged: (focusedDay) {
                        _focusDay = focusedDay;
                      },
                      enabledDayPredicate: (day) {
                        return day.isAfter(
                          DateTime.now().subtract(const Duration(days: 1)),
                        );
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
