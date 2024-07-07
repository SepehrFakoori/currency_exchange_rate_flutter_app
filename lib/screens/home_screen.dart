import 'package:currency_exchange_rate_app_flutter/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Row(
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
              const SizedBox(height: 20),
              Text(
                "Exchange Rate",
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: AppColors.priceColor,
                    ),
              ),
              const SizedBox(height: 20),
              TabBarContainer(tabController: _tabController),
              Directionality(
                textDirection: TextDirection.rtl,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  width: double.infinity,
                  child: Row(
                    children: [
                      Text(
                        "2022.10.30",
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
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    CustomScrollView(
                      slivers: [
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              return CardContainer(index);
                            },
                            childCount: 10,
                          ),
                        ),
                      ],
                    ),
                    CustomScrollView(
                      slivers: [
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              return CardContainer(index);
                            },
                            childCount: 10,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
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

  const CardContainer(
    this.index, {
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
                      child: Row(
                        children: [
                          const Icon(Icons.money),
                          const SizedBox(width: 4),
                          Text(
                            "United State Dollar",
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                                  color: AppColors.highEmphasisColor,
                                ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "USD",
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
                  children: [
                    Text(
                      "59,000",
                      style:
                          Theme.of(context).textTheme.headlineSmall!.copyWith(
                                color: Colors.black.withOpacity(0.38),
                              ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      "IRT",
                      style:
                          Theme.of(context).textTheme.headlineSmall!.copyWith(
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
                      style:
                          Theme.of(context).textTheme.headlineLarge!.copyWith(
                                color: AppColors.priceColor,
                              ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      "IRT",
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                color: AppColors.priceColor,
                              ),
                    ),
                    const Spacer(),
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
