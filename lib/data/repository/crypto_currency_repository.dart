import 'package:currency_exchange_rate_app_flutter/data/datasource/crypto_currency_datasource.dart';
import 'package:currency_exchange_rate_app_flutter/data/model/crypto_currency.dart';
import 'package:currency_exchange_rate_app_flutter/di/di.dart';
import 'package:currency_exchange_rate_app_flutter/util/api_exception.dart';
import 'package:dartz/dartz.dart';


abstract class ICryptoCurrencyRepository {
  Future<Either<String, List<CryptoCurrency>>> getCryptoCurrencies();
}

class CryptoCurrencyRepository extends ICryptoCurrencyRepository {
  final ICryptoCurrencyDataSource _dataSource = locator.get();

  @override
  Future<Either<String, List<CryptoCurrency>>> getCryptoCurrencies() async {
    try {
      var response = await _dataSource.getCryptoCurrencies();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message ?? "Text Error We Got!");
    }
  }
}
