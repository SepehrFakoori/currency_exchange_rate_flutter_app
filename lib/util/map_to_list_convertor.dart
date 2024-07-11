List<Map<String, dynamic>> convertMap(Map<String, dynamic> mapObject, String kind) {
  List<Map<String, dynamic>> result = [];
  Map<String, dynamic> currencies = mapObject['result'][kind];

  currencies.forEach((key, value) {
    Map<String, dynamic> currencyMap = {
      'name': key,
      'p': value['p'],
      'h': value['h'],
      'l': value['l'],
      'd': value['d'],
      'dp': value['dp'],
      'ts': value['ts'],
    };
    result.add(currencyMap);
  });

  return result;
}
