import 'package:currency_exchange_rate_app_flutter/bloc/crypto/crypto_event.dart';
import 'package:currency_exchange_rate_app_flutter/bloc/crypto/crypto_state.dart';
import 'package:currency_exchange_rate_app_flutter/data/repository/crypto_currency_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CryptoBloc extends Bloc<CryptoEvent, CryptoState> {
  final ICryptoCurrencyRepository _repository;
  CryptoBloc(this._repository) : super(CryptoInitState()) {
    on<CryptoInitializeEvent>((event, state) async {
      emit(CryptoLoadingState());
      final response = await _repository.getCryptoCurrencies();
      emit(CryptoResponseState(response));
    });
  }
}
