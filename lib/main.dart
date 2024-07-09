import 'package:currency_exchange_rate_app_flutter/constants/app_colors.dart';
import 'package:currency_exchange_rate_app_flutter/di/di.dart';
import 'package:currency_exchange_rate_app_flutter/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  await getItInit();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(
          TextTheme(
            headlineLarge: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
            headlineMedium: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
            headlineSmall: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.mediumEmphasisColor,
            ),
          ),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
