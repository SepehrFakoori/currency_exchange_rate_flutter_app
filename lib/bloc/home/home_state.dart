import 'package:currency_exchange_rate_app_flutter/data/model/crypto_currency.dart';
import 'package:currency_exchange_rate_app_flutter/data/model/currency.dart';
import 'package:dartz/dartz.dart';

abstract class CryptoState {}

class CryptoInitState extends CryptoState {}

class CryptoLoadingState extends CryptoState {}

class CryptoResponseState extends CryptoState {
  // Either<String, List<CryptoCurrency>> cryptoCurrencyResponse;
  Either<String, List<Currency>> currencyResponse;

  CryptoResponseState(this.currencyResponse);
}
