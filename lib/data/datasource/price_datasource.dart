import 'package:currency_exchange_rate_app_flutter/data/model/crypto_currency.dart';
import 'package:currency_exchange_rate_app_flutter/data/model/currency.dart';
import 'package:currency_exchange_rate_app_flutter/di/di.dart';
import 'package:currency_exchange_rate_app_flutter/util/api_exception.dart';
import 'package:currency_exchange_rate_app_flutter/util/map_to_list_convertor.dart';
import 'package:dio/dio.dart';

abstract class ICryptoCurrencyDataSource {
  Future<List<CryptoCurrency>> getCryptoCurrencies();

  Future<List<Currency>> getCurrencies();
}

class CryptoCurrencyRemoteDatasource extends ICryptoCurrencyDataSource {
  final Dio _dio = locator.get();

  @override
  Future<List<CryptoCurrency>> getCryptoCurrencies() async {
    try {
      Map<String, dynamic> qParams = {
        "token": "440714:668d2eb4c7b96",
      };
      var response =
          await _dio.get("DigitalCurrency/", queryParameters: qParams);
      return response.data["result"]
          .map<CryptoCurrency>(
              (jsonObject) => CryptoCurrency.fromMapJson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response!.statusCode, ex.response!.statusMessage);
    } catch (ex) {
      throw ApiException(0, "Unknown Error!");
    }
  }

  @override
  Future<List<Currency>> getCurrencies() async {
    try {
      Map<String, dynamic> qParams = {
        "token": "440714:668d2eb4c7b96",
        "action": "tgju",
      };
      var response = await _dio.get("price/", queryParameters: qParams);
      var result = convertMap(response.data, "currencies");
      return result
          .map<Currency>((jsonObject) => Currency.fromMapJson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response!.statusCode, ex.response!.statusMessage);
    } catch (ex) {
      throw ApiException(0, "Unknown Error!");
    }
  }
}
