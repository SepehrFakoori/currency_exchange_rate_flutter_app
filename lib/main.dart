import 'package:currency_exchange_rate_app_flutter/bloc/home/home_bloc.dart';
import 'package:currency_exchange_rate_app_flutter/bloc/home/home_event.dart';
import 'package:currency_exchange_rate_app_flutter/constants/app_colors.dart';
import 'package:currency_exchange_rate_app_flutter/data/model/financial_Item.dart';
import 'package:currency_exchange_rate_app_flutter/di/di.dart';
import 'package:currency_exchange_rate_app_flutter/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(FinancialItemAdapter());
  await Hive.openBox<FinancialItem>('FinancialItemBox');
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
          const TextTheme(
            titleLarge: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.highEmphasisColor
            ),
            bodyLarge: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.highEmphasisColor
            ),
            labelLarge: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.lowEmphasisColor,
            ),
          ),
        ),
      ),
      home: BlocProvider(
        create: (context) {
          var bloc = HomeBloc();
          bloc.add(HomeInitializeEvent());
          return bloc;
        },
        child: const HomeScreen(),
      ),
    );
  }
}
