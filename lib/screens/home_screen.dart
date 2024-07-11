import 'package:auto_size_text/auto_size_text.dart';
import 'package:currency_exchange_rate_app_flutter/bloc/home/home_bloc.dart';
import 'package:currency_exchange_rate_app_flutter/bloc/home/home_state.dart';
import 'package:currency_exchange_rate_app_flutter/constants/app_colors.dart';
import 'package:currency_exchange_rate_app_flutter/data/model/coin.dart';
import 'package:currency_exchange_rate_app_flutter/data/model/currency.dart';
import 'package:currency_exchange_rate_app_flutter/data/model/gold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: ((context, state) {
          if (state is HomeLoadingState) {
            return Center(
              child: LoadingAnimationWidget.halfTriangleDot(
                color: AppColors.priceColor,
                size: 80,
              ),
            );
          }
          return SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  sliver: SliverToBoxAdapter(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "EX Rate",
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(color: AppColors.priceColor),
                        ),
                        SvgPicture.asset(
                          "assets/icons/settings.svg",
                          color: AppColors.priceColor,
                          width: 40,
                          height: 40,
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  sliver: SliverToBoxAdapter(
                    child: Text(
                      "Currencies",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(fontSize: 18),
                    ),
                  ),
                ),
                if (state is HomeResponseState) ...{
                  state.currencyResponse.fold((exceptionMessage) {
                    return const Center(
                      child: Text("Data Currency Not Found!"),
                    );
                  }, (currencyList) {
                    return SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                              (context, index) {
                            return CurrencyCardContainer(currencyList[index]);
                          },
                          childCount: currencyList.length,
                        ),
                      ),
                    );
                  })
                },
                SliverPadding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  sliver: SliverToBoxAdapter(
                    child: Text(
                      "Gold",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(fontSize: 18),
                    ),
                  ),
                ),
                if (state is HomeResponseState) ...{
                  state.goldResponse.fold((exceptionMessage) {
                    return const Center(
                      child: Text("Data Currency Not Found!"),
                    );
                  }, (goldList) {
                    return SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                              (context, index) {
                            return GoldCardContainer(goldList[index]);
                          },
                          childCount: goldList.length,
                        ),
                      ),
                    );
                  })
                },
                SliverPadding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  sliver: SliverToBoxAdapter(
                    child: Text(
                      "Coin",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(fontSize: 18),
                    ),
                  ),
                ),
                if (state is HomeResponseState) ...{
                  state.coinResponse.fold((exceptionMessage) {
                    return const Center(
                      child: Text("Data Currency Not Found!"),
                    );
                  }, (coinList) {
                    return SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                              (context, index) {
                            return CoinCardContainer(coinList[index]);
                          },
                          childCount: coinList.length,
                        ),
                      ),
                    );
                  })
                },
                const SliverPadding(
                  padding: EdgeInsets.only(bottom: 50.0),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class CurrencyCardContainer extends StatefulWidget {
  Currency currency;

  CurrencyCardContainer(
      this.currency, {
        super.key,
      });

  @override
  State<CurrencyCardContainer> createState() => _CurrencyCardContainerState();
}

class _CurrencyCardContainerState extends State<CurrencyCardContainer> {
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      height: 130,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColors.lowEmphasisColor,
          width: 0.5,
        ),
        boxShadow: const [
          BoxShadow(
            color: AppColors.priceColor,
            blurRadius: 7,
            spreadRadius: -2,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "1",
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.currency.name!,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                          color: AppColors.highEmphasisColor,
                        ),
                      ),
                    ),
                    Text(
                      widget.currency.name!,
                      style:
                      Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: AppColors.lowEmphasisColor,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        AutoSizeText(
                          widget.currency.currentPrice!,
                          maxLines: 1,
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(
                            color: AppColors.priceColor,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          "IRT",
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(
                            color: AppColors.priceColor,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isFavorite = !_isFavorite;
                        });
                      },
                      child: SvgPicture.asset(
                        _isFavorite
                            ? "assets/icons/filled_star.svg"
                            : "assets/icons/unfilled_star.svg",
                        color: AppColors.priceColor,
                        width: 30,
                        height: 30,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class GoldCardContainer extends StatefulWidget {
  Gold gold;

  GoldCardContainer(
      this.gold, {
        super.key,
      });

  @override
  State<GoldCardContainer> createState() => _GoldCardContainerState();
}

class _GoldCardContainerState extends State<GoldCardContainer> {
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      height: 130,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColors.lowEmphasisColor,
          width: 0.5,
        ),
        boxShadow: const [
          BoxShadow(
            color: AppColors.priceColor,
            blurRadius: 7,
            spreadRadius: -2,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "1",
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.gold.name!,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                          color: AppColors.highEmphasisColor,
                        ),
                      ),
                    ),
                    Text(
                      widget.gold.name!,
                      style:
                      Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: AppColors.lowEmphasisColor,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        AutoSizeText(
                          widget.gold.currentPrice!,
                          maxLines: 1,
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(
                            color: AppColors.priceColor,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          "IRT",
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(
                            color: AppColors.priceColor,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isFavorite = !_isFavorite;
                        });
                      },
                      child: SvgPicture.asset(
                        _isFavorite
                            ? "assets/icons/filled_star.svg"
                            : "assets/icons/unfilled_star.svg",
                        color: AppColors.priceColor,
                        width: 30,
                        height: 30,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CoinCardContainer extends StatefulWidget {
  Coin coin;

  CoinCardContainer(
      this.coin, {
        super.key,
      });

  @override
  State<CoinCardContainer> createState() => _CoinCardContainerState();
}

class _CoinCardContainerState extends State<CoinCardContainer> {
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      height: 130,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColors.lowEmphasisColor,
          width: 0.5,
        ),
        boxShadow: const [
          BoxShadow(
            color: AppColors.priceColor,
            blurRadius: 7,
            spreadRadius: -2,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "1",
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.coin.name!,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                          color: AppColors.highEmphasisColor,
                        ),
                      ),
                    ),
                    Text(
                      widget.coin.name!,
                      style:
                      Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: AppColors.lowEmphasisColor,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        AutoSizeText(
                          widget.coin.currentPrice!,
                          maxLines: 1,
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(
                            color: AppColors.priceColor,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          "IRT",
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(
                            color: AppColors.priceColor,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isFavorite = !_isFavorite;
                        });
                      },
                      child: SvgPicture.asset(
                        _isFavorite
                            ? "assets/icons/filled_star.svg"
                            : "assets/icons/unfilled_star.svg",
                        color: AppColors.priceColor,
                        width: 30,
                        height: 30,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
