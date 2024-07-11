import 'package:currency_exchange_rate_app_flutter/data/model/coin.dart';
import 'package:currency_exchange_rate_app_flutter/data/model/currency.dart';
import 'package:currency_exchange_rate_app_flutter/data/model/gold.dart';
import 'package:currency_exchange_rate_app_flutter/di/di.dart';
import 'package:currency_exchange_rate_app_flutter/util/api_exception.dart';
import 'package:currency_exchange_rate_app_flutter/util/map_to_list_convertor.dart';
import 'package:dio/dio.dart';

abstract class IPriceDataSource {
  Future<List<Currency>> getCurrencies();

  Future<List<Gold>> getGolds();

  Future<List<Coin>> getCoins();
}

class PriceRemoteDatasource extends IPriceDataSource {
  final Dio _dio = locator.get();

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

  @override
  Future<List<Gold>> getGolds() async {
    try {
      Map<String, dynamic> qParams = {
        "token": "440714:668d2eb4c7b96",
        "action": "tgju",
      };
      var response = await _dio.get("price/", queryParameters: qParams);
      var result = convertMap(response.data, "gold");
      return result
          .map<Gold>((jsonObject) => Gold.fromMapJson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response!.statusCode, ex.response!.statusMessage);
    } catch (ex) {
      throw ApiException(0, "Unknown Error!");
    }
  }

  @override
  Future<List<Coin>> getCoins() async {
    try {
      Map<String, dynamic> qParams = {
        "token": "440714:668d2eb4c7b96",
        "action": "tgju",
      };
      var response = await _dio.get("price/", queryParameters: qParams);
      var result = convertMap(response.data, "coin");
      return result
          .map<Coin>((jsonObject) => Coin.fromMapJson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response!.statusCode, ex.response!.statusMessage);
    } catch (ex) {
      throw ApiException(0, "Unknown Error!");
    }
  }
}
