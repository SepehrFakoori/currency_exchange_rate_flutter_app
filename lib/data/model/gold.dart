class Gold {
  String? name;
  String? currentPrice;
  String? high;
  String? low;
  String? change;
  String? percent;
  String? time;

  Gold(
    this.name,
    this.currentPrice,
    this.high,
    this.low,
    this.change,
    this.percent,
    this.time,
  );

  factory Gold.fromMapJson(Map<String, dynamic> jsonObject) {
    return Gold(
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
