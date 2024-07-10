import 'package:currency_exchange_rate_app_flutter/bloc/crypto/crypto_bloc.dart';
import 'package:currency_exchange_rate_app_flutter/bloc/crypto/crypto_state.dart';
import 'package:currency_exchange_rate_app_flutter/constants/app_colors.dart';
import 'package:currency_exchange_rate_app_flutter/data/model/crypto_currency.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "Exchange Rate",
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: AppColors.priceColor,
                    ),
              ),
            ),
            const SizedBox(height: 20),
            TabBarContainer(tabController: tabController),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 5),
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      Text(
                        "23:54",
                        style:
                            Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  fontSize: 14,
                                ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        ", 2022.10.30",
                        style:
                            Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  fontSize: 14,
                                ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<CryptoBloc, CryptoState>(
                builder: (context, state) {
                  if (state is CryptoLoadingState) {
                    return Center(
                      child: LoadingAnimationWidget.halfTriangleDot(
                        color: AppColors.priceColor,
                        size: 80,
                      ),
                    );
                  } else if (state is CryptoResponseState) {
                    return state.response.fold((exceptionMessage) {
                      return const Center(
                        child: Text("Fuck it!"),
                      );
                    }, (cryptoCurrencyList) {
                      return TabBarView(
                        controller: tabController,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: CustomScrollView(
                              slivers: [
                                SliverList(
                                  delegate: SliverChildBuilderDelegate(
                                    (context, index) {
                                      return CardContainer(
                                          index, cryptoCurrencyList[index]);
                                    },
                                    childCount: cryptoCurrencyList.length,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: CustomScrollView(
                              slivers: [
                                SliverList(
                                  delegate: SliverChildBuilderDelegate(
                                    (context, index) {
                                      return CardContainer(
                                          index, cryptoCurrencyList[index]);
                                    },
                                    childCount: cryptoCurrencyList.length,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    });
                  } else {
                    return const Center(
                      child: Text("Fuck it!"),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TabBarContainer extends StatelessWidget {
  const TabBarContainer({
    super.key,
    required TabController? tabController,
  }) : _tabController = tabController;

  final TabController? _tabController;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: TabBar(
        controller: _tabController,
        labelColor: Colors.white,
        labelStyle:
            Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 16),
        unselectedLabelColor: AppColors.lowEmphasisColor,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: AppColors.priceColor,
        ),
        indicatorPadding: const EdgeInsets.all(3),
        dividerColor: Colors.transparent,
        indicatorSize: TabBarIndicatorSize.tab,
        tabs: const [
          Tab(
            text: "All",
          ),
          Tab(
            text: "Favorites",
          ),
        ],
      ),
    );
  }
}

class CardContainer extends StatefulWidget {
  final int index;
  CryptoCurrency cryptoCurrency;

  CardContainer(
    this.index,
    this.cryptoCurrency, {
    super.key,
  });

  @override
  State<CardContainer> createState() => _CardContainerState();
}

class _CardContainerState extends State<CardContainer> {
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
            "${widget.index + 1}",
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
                        widget.cryptoCurrency.englishName.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                              color: AppColors.highEmphasisColor,
                            ),
                      ),
                    ),
                    Text(
                      widget.cryptoCurrency.keyName.toString(),
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
                          widget.cryptoCurrency.price.toString(),
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
