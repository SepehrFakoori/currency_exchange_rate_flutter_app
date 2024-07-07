import 'package:currency_exchange_rate_app_flutter/constants/app_colors.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return const CardContainer();
                },
                childCount: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardContainer extends StatelessWidget {
  const CardContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      height: 130,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColors.lowEmphasisColor,
          width: 0.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 10,
            spreadRadius: -5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    const Icon(Icons.money),
                    const SizedBox(width: 4),
                    Text(
                      "United State Dollar",
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                color: AppColors.highEmphasisColor,
                              ),
                    ),
                  ],
                ),
              ),
              Text(
                "USD",
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: AppColors.lowEmphasisColor,
                    ),
              ),
            ],
          ),
          const Spacer(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "59,000",
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Colors.black.withOpacity(0.38),
                    ),
              ),
              const SizedBox(width: 5),
              Text(
                "IRT",
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: AppColors.lowEmphasisColor,
                    ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "59,000",
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      color: AppColors.priceColor,
                    ),
              ),
              const SizedBox(width: 5),
              Text(
                "IRT",
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: AppColors.priceColor,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
