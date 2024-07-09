import 'package:currency_exchange_rate_app_flutter/bloc/crypto/crypto_bloc.dart';
import 'package:currency_exchange_rate_app_flutter/bloc/crypto/crypto_event.dart';
import 'package:currency_exchange_rate_app_flutter/constants/app_colors.dart';
import 'package:currency_exchange_rate_app_flutter/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 300),
            Text(
              "EX Rate",
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: AppColors.priceColor,
                    fontSize: 50,
                  ),
            ),
            LottieBuilder.asset(
              "assets/lottie/lottie_wave_animation.json",
              frameRate: FrameRate.max,
            ),
            const Spacer(),
            Text(
              "By Sepehr",
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(fontSize: 16, color: AppColors.priceColor),
            ),
          ],
        ),
      ),
    );
  }
}
