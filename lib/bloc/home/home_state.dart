import 'package:currency_exchange_rate_app_flutter/data/model/coin.dart';
import 'package:currency_exchange_rate_app_flutter/data/model/currency.dart';
import 'package:currency_exchange_rate_app_flutter/data/model/gold.dart';
import 'package:dartz/dartz.dart';

abstract class HomeState {}

class HomeInitState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeResponseState extends HomeState {
  Either<String, List<Currency>> currencyResponse;
  Either<String, List<Gold>> goldResponse;
  Either<String, List<Coin>> coinResponse;

  HomeResponseState(
    this.currencyResponse,
    this.goldResponse,
    this.coinResponse,
  );
}
