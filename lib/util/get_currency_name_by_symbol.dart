String getCurrencyFullName(String code) {
  Map<String, String> currencyMap = {
    'DOLLAR': 'United States Dollar',
    'EUR': 'Euro',
    'AED': 'United Arab Emirates Dirham',
    'GBP': 'Pound sterling',
    'TRY': 'Turkish lira',
    'CAD': 'Canadian Dollar',
    'AUD': 'Australian Dollar'
  };

  return currencyMap[code.toUpperCase()] ?? 'Unknown Currency Code';
}