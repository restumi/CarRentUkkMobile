// lib/routes/app_router.dart
import 'package:car_rent_mobile_app/screens/auth/login_screen.dart';
import 'package:car_rent_mobile_app/screens/auth/register_screen.dart';
import 'package:car_rent_mobile_app/screens/auth/verify_screen.dart';
import 'package:car_rent_mobile_app/screens/auth/waiting_page_screen.dart';
import 'package:car_rent_mobile_app/screens/driver/driver_screen.dart';
import 'package:car_rent_mobile_app/screens/payment/midtrans_screen.dart';
import 'package:car_rent_mobile_app/screens/profile/history_transaction_screen.dart';
import 'package:car_rent_mobile_app/screens/terms_after_login.dart';
import 'package:car_rent_mobile_app/screens/terms_screen.dart';
import 'package:flutter/material.dart';
import '../screens/home/home_screen.dart';
import '../screens/home/transaction_screen.dart';
import '../screens/profile/profile_screen.dart';
import '../screens/home/detail_car_screen.dart';
import 'package:car_rent_mobile_app/services/models/driver_model.dart';
import '../screens/profile/chat_screen.dart';

enum SlideDirection { left, right }

extension SlideDirectionOffset on SlideDirection {
  Offset get offset {
    switch (this) {
      case SlideDirection.left:
        return const Offset(-1.0, 0.0);
      case SlideDirection.right:
        return const Offset(1.0, 0.0);
    }
  }
}

class AppRouter {
  // === Route Names ===
  static const String home = '/home';
  static const String profile = '/profile';
  static const String detailCar = '/detail-car';
  static const String transaction = '/transaction';
  static const String driver = '/driver';
  static const String infoAccount = '/info-account';
  static const String login = '/login';
  static const String regist = '/regist';
  static const String verify = '/verify';
  static const String waiting = '/waiting';
  static const String terms = '/terms';
  static const String termsAfterLogin = '/terms-after-login';
  static const String historyTransaction = '/history-transaction';
  static const String midtransPayment = '/midtrans-payment';
  static const String chat = '/chat';

  // === Generate Route ===
  static Route<dynamic> generateRoute(RouteSettings settings) {
    SlideDirection direction = SlideDirection.right;

    if (settings.arguments is SlideDirection) {
      direction = settings.arguments as SlideDirection;
    }

    switch (settings.name) {
      case historyTransaction:
        return _buildRoute(
          const HistoryTransactionScreen(),
          direction: direction,
        );

      case terms:
        return _buildRoute(const TermsScreen(), direction: direction);

      case midtransPayment:
        final String snapToken = settings.arguments as String;
        return _buildRoute(MidtransScreen(snapToken: snapToken), direction: direction);

      case termsAfterLogin:
        return _buildRoute(const TermsAfterLogin(), direction: direction);

      case chat:
        return _buildRoute(const ChatScreen(), direction: direction);

      case home:
        return _buildRoute(const HomeScreen(), direction: direction);

      case profile:
        return _buildRoute(const ProfileScreen(), direction: direction);

      case detailCar:
        final Map<String, dynamic> carData =
            settings.arguments as Map<String, dynamic>;
        return _buildRoute(
          DetailCarScreen(carData: carData),
          direction: direction,
        );

      // case transaction:
      //   return _buildRoute(TransactionScreen(), direction: direction);
      case transaction:
        Map<String, dynamic>? carData;
        Driver? driver;
        SlideDirection directionToUse = SlideDirection.right;

        if (settings.arguments is Map<String, dynamic>) {
          final argsMap = settings.arguments as Map<String, dynamic>;
          carData = argsMap['car'] as Map<String, dynamic>?;
          driver = argsMap['driver'] as Driver?;
          if (argsMap['direction'] is SlideDirection) {
            directionToUse = argsMap['direction'] as SlideDirection;
          }
        }

        return _buildRoute(
          TransactionScreen(
            carData: carData,
            selectedDriver: driver,
          ),
          direction: directionToUse,
        );

      case driver:
        return _buildRoute(const DriverScreen(), direction: direction);

      case login:
        return _buildRoute(const LoginScreen(), direction: direction);

      case regist:
        return _buildRoute(const RegisterScreen(), direction: direction);

      case verify:
        final args = settings.arguments as Map<String, dynamic>;
        return _buildRoute(
          VerificationScreen(
            name: args["name"],
            email: args["email"],
            password: args["password"],
            passwordConfirmation: args["passwordConfirmation"],
          ),
          direction: direction,
        );

      case waiting:
        return _buildRoute(const WaitingScreen(), direction: direction);

      default:
        return _buildRoute(_UnknownRoutePage(), direction: direction);
    }
  }

  // === Slide Animation ===
  static Route<dynamic> _buildRoute(
    Widget page, {
    SlideDirection direction = SlideDirection.right,
  }) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final begin = direction.offset;
        const end = Offset.zero;
        const curve = Curves.easeInOut;
        var tween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: curve));
        return SlideTransition(position: animation.drive(tween), child: child);
      },
    );
  }
}

class _UnknownRoutePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
