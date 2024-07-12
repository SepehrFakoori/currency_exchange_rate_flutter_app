String getCoinFullName(String code) {
  Map<String, String> coinMap = {
    'GERAMI': 'GRAM COIN',
    'ROB': 'QUARTER COIN',
    'NIM': 'HALF COIN',
    'SEKEB': 'BAHAR COIN',
    'SEKEE': 'IMAMI COIN',
  };

  return coinMap[code.toUpperCase()] ?? 'Unknown Coin Code';
}
