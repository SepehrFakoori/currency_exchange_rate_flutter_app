import 'package:currency_exchange_rate_app_flutter/data/datasource/crypto_currency_datasource.dart';
import 'package:currency_exchange_rate_app_flutter/data/repository/crypto_currency_repository.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

var locator = GetIt.instance;

Future<void> getItInit() async {
  locator.registerSingleton<Dio>(Dio(BaseOptions(baseUrl: "https://one-api.ir/")));
  locator.registerSingleton<ICryptoCurrencyDataSource>(CryptoCurrencyRemoteDatasource());
  locator.registerSingleton<ICryptoCurrencyRepository>(CryptoCurrencyRepository());
}
