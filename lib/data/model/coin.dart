import 'package:currency_exchange_rate_app_flutter/util/get_coin_name_by_symbol.dart';

class Coin {
  String? name;
  String? symbol;
  String? currentPrice;
  String? high;
  String? low;
  String? change;
  String? percent;
  String? time;

  Coin(
    this.name,
    this.symbol,
    this.currentPrice,
    this.high,
    this.low,
    this.change,
    this.percent,
    this.time,
  );

  factory Coin.fromMapJson(Map<String, dynamic> jsonObject) {
    return Coin(
      getCoinFullName(jsonObject["name"].toString().toUpperCase()),
      jsonObject["name"],
      jsonObject["p"],
      jsonObject["h"],
      jsonObject["l"],
      jsonObject["d"],
      jsonObject["dp"].toString(),
      jsonObject["ts"],
    );
  }
}
