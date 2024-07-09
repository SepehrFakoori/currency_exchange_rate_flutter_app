import 'package:currency_exchange_rate_app_flutter/data/model/crypto_currency.dart';
import 'package:currency_exchange_rate_app_flutter/di/di.dart';
import 'package:dio/dio.dart';

abstract class ICryptoCurrencyDataSource {
  Future<List<CryptoCurrency>> getCryptoCurrencies();
}

class CryptoCurrencyRemoteDatasource extends ICryptoCurrencyDataSource {
  final Dio _dio = locator.get();

  @override
  Future<List<CryptoCurrency>> getCryptoCurrencies() async {
    try {
      Map<String, dynamic> qParams = {
        "token": "440714:668d2eb4c7b96",
      };
      var response = await _dio.get(
          "DigitalCurrency/", queryParameters: qParams);
      return response.data["result"].map<CryptoCurrency>((jsonObject) =>
          CryptoCurrency.fromMapJson(jsonObject)).toList();
    } catch (ex) {
      throw Exception();
    }
  }
}