class Coin {
  String? name;
  String? currentPrice;
  String? high;
  String? low;
  String? change;
  String? percent;
  String? time;

  Coin(
      this.name,
      this.currentPrice,
      this.high,
      this.low,
      this.change,
      this.percent,
      this.time,
      );

  factory Coin.fromMapJson(Map<String, dynamic> jsonObject) {
    return Coin(
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
