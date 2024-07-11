import 'package:currency_exchange_rate_app_flutter/data/datasource/price_datasource.dart';
import 'package:currency_exchange_rate_app_flutter/data/model/coin.dart';
import 'package:currency_exchange_rate_app_flutter/data/model/currency.dart';
import 'package:currency_exchange_rate_app_flutter/data/model/gold.dart';
import 'package:currency_exchange_rate_app_flutter/di/di.dart';
import 'package:currency_exchange_rate_app_flutter/util/api_exception.dart';
import 'package:dartz/dartz.dart';


abstract class IPriceRepository {
  Future<Either<String, List<Currency>>> getCurrencies();

  Future<Either<String, List<Gold>>> getGolds();

  Future<Either<String, List<Coin>>> getCoins();
}

class PriceRepository extends IPriceRepository {
  final IPriceDataSource _dataSource = locator.get();

  @override
  Future<Either<String, List<Currency>>> getCurrencies() async {
    try {
      var response = await _dataSource.getCurrencies();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message ?? "Text Error We Got!");
    }
  }

  @override
  Future<Either<String, List<Gold>>> getGolds() async {
    try {
      var response = await _dataSource.getGolds();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message ?? "Text Error We Got!");
    }
  }

  @override
  Future<Either<String, List<Coin>>> getCoins() async {
    try {
      var response = await _dataSource.getCoins();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message ?? "Text Error We Got!");
    }
  }
}
