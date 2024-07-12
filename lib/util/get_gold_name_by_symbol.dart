String getGoldFullName(String code) {
  Map<String, String> goldMap = {
    'GERAM24': '24K GOLD',
    'GERAM18': '18K GOLD',
    'DASTE_DOOM': '2ND CLASS GOLD',
    'MESGHAL': 'GOLD BULLION',
    'AB_SHODE': 'MELTED GOLD',
    'ONS': 'GOLD PRICE PER OUNCE',
    'SILVER': 'SILVER',
    'PLATINUM': 'PLATINUM',
    'PALLADIUM': 'PALLADIUM',
  };

  return goldMap[code.toUpperCase()] ?? 'Unknown Gold Code';
}