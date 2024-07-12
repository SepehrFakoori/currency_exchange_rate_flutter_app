import 'package:auto_size_text/auto_size_text.dart';
import 'package:currency_exchange_rate_app_flutter/bloc/home/home_bloc.dart';
import 'package:currency_exchange_rate_app_flutter/bloc/home/home_event.dart';
import 'package:currency_exchange_rate_app_flutter/bloc/home/home_state.dart';
import 'package:currency_exchange_rate_app_flutter/constants/app_colors.dart';
import 'package:currency_exchange_rate_app_flutter/data/model/coin.dart';
import 'package:currency_exchange_rate_app_flutter/data/model/currency.dart';
import 'package:currency_exchange_rate_app_flutter/data/model/gold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkColor,
      drawer: const _DrawerContainer(),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: ((context, state) {
          if (state is HomeLoadingState) {
            return Center(
              child: LoadingAnimationWidget.halfTriangleDot(
                color: AppColors.highEmphasisColor,
                size: 80,
              ),
            );
          }
          return SafeArea(
            child: RefreshIndicator(
              onRefresh: () async {
                context.read<HomeBloc>().add(HomeInitializeEvent());
              },
              backgroundColor: AppColors.lightDarkColor,
              color: AppColors.highEmphasisColor,
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverPadding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 15),
                    sliver: SliverToBoxAdapter(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Scaffold.of(context).openDrawer();
                            },
                            splashColor: AppColors.lightDarkColor,
                            customBorder: const CircleBorder(),
                            child: Ink(
                              decoration:
                                  const BoxDecoration(shape: BoxShape.circle),
                              width: 30,
                              height: 30,
                              child: SvgPicture.asset(
                                "assets/icons/options.svg",
                                color: AppColors.highEmphasisColor,
                                width: 30,
                                height: 30,
                              ),
                            ),
                          ),
                          Text(
                            "EX Rate",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                  color: AppColors.highEmphasisColor,
                                ),
                          ),
                          const SizedBox(),
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.highEmphasisColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Search",
                          hintStyle:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: AppColors.lowEmphasisColor,
                                  ),
                          border: InputBorder.none,
                          prefixIcon: const Icon(
                            Icons.search,
                            color: AppColors.lowEmphasisColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    sliver: SliverToBoxAdapter(
                      child: Text(
                        "Currencies",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: AppColors.highEmphasisColor,
                            ),
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
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 20),
                    sliver: SliverToBoxAdapter(
                      child: Text(
                        "Gold",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: AppColors.highEmphasisColor,
                            ),
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
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 20),
                    sliver: SliverToBoxAdapter(
                      child: Text(
                        "Coin",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: AppColors.highEmphasisColor,
                            ),
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
            ),
          );
        }),
      ),
    );
  }
}

class _DrawerContainer extends StatefulWidget {
  const _DrawerContainer({
    super.key,
  });

  @override
  State<_DrawerContainer> createState() => _DrawerContainerState();
}

class _DrawerContainerState extends State<_DrawerContainer> {
  bool _isLighmode = true;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.lightDarkColor,
      width: 280,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 100,
          ),
          Container(
            width: 280,
            height: 50,
            padding: const EdgeInsets.only(left: 20.0, top: 10, right: 20.0),
            child: Text(
              "Options",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          const Divider(
            color: AppColors.lowEmphasisColor,
          ),
          Container(
            width: 280,
            height: 50,
            padding: const EdgeInsets.only(left: 20.0, top: 10, right: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Theme Mode",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Switch(
                  value: _isLighmode,
                  onChanged: (value) {
                    setState(() {
                      _isLighmode = !_isLighmode;
                    });
                  },
                  activeColor: AppColors.darkColor,
                  activeTrackColor: AppColors.lowEmphasisColor,
                  inactiveThumbColor: AppColors.lowEmphasisColor,
                  inactiveTrackColor: AppColors.highEmphasisColor,
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "EX Rate",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: AppColors.lowEmphasisColor,
                    ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Version ",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  Text(
                    "1.0.0",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ],
              ),
            ],
          )
        ],
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
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      height: 140,
      decoration: BoxDecoration(
        color: AppColors.lightDarkColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.red,
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 260,
                child: AutoSizeText(
                    widget.currency.name!,
                    style: Theme.of(context).textTheme.titleLarge,
                    maxLines: 1,
                    overflow: TextOverflow.fade,
                  ),
              ),
              Text(
                widget.currency.symbol!.toUpperCase(),
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(fontSize: 16),
              ),
              const Spacer(),
              Row(
                children: [
                  const Icon(Icons.arrow_drop_up, color: Colors.green),
                  Text(
                    widget.currency.high!,
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(color: Colors.green),
                  ),
                  const SizedBox(width: 10),
                  const Icon(Icons.arrow_drop_down, color: Colors.red),
                  Text(
                    widget.currency.low!,
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(color: Colors.red),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    widget.currency.currentPrice!,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    "IRR",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: AppColors.lowEmphasisColor, fontSize: 18),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                    decoration: BoxDecoration(
                        color: AppColors.lowEmphasisColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      "%${widget.currency.percent!}",
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(color: AppColors.highEmphasisColor),
                    ),
                  ),
                ],
              ),
            ],
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
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      height: 140,
      decoration: BoxDecoration(
        color: AppColors.lightDarkColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.red,
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.gold.name!,
                style: Theme.of(context).textTheme.titleLarge,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const Spacer(),
              Row(
                children: [
                  const Icon(Icons.arrow_drop_up, color: Colors.green),
                  Text(
                    widget.gold.high!,
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(color: Colors.green),
                  ),
                  const SizedBox(width: 10),
                  const Icon(Icons.arrow_drop_down, color: Colors.red),
                  Text(
                    widget.gold.low!,
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(color: Colors.red),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    widget.gold.currentPrice!,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    "IRR",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: AppColors.lowEmphasisColor, fontSize: 18),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                    decoration: BoxDecoration(
                        color: AppColors.lowEmphasisColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      "%${widget.gold.percent!}",
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(color: AppColors.highEmphasisColor),
                    ),
                  ),
                ],
              ),
            ],
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
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      height: 140,
      decoration: BoxDecoration(
        color: AppColors.lightDarkColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.red,
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.coin.name!.toUpperCase(),
                style: Theme.of(context).textTheme.titleLarge,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const Spacer(),
              Row(
                children: [
                  const Icon(Icons.arrow_drop_up, color: Colors.green),
                  Text(
                    widget.coin.high!,
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(color: Colors.green),
                  ),
                  const SizedBox(width: 10),
                  const Icon(Icons.arrow_drop_down, color: Colors.red),
                  Text(
                    widget.coin.low!,
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(color: Colors.red),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    widget.coin.currentPrice!,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    "IRR",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: AppColors.lowEmphasisColor, fontSize: 18),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                    decoration: BoxDecoration(
                        color: AppColors.lowEmphasisColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      "%${widget.coin.percent!}",
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(color: AppColors.highEmphasisColor),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
