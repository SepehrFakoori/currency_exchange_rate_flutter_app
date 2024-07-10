class CryptoCurrency {
  String? keyName;
  String? persianName;
  String? englishName;
  String? rank;
  String? price;

  CryptoCurrency(
    this.keyName,
    this.persianName,
    this.englishName,
    this.rank,
    this.price,
  );

  factory CryptoCurrency.fromMapJson(Map<String, dynamic> jsonObject) {
    return CryptoCurrency(
      jsonObject["key"],
      jsonObject["name"],
      jsonObject["name_en"],
      jsonObject["rank"].toString(),
      jsonObject["price"].toString(),
    );
  }
}
