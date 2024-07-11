import 'package:currency_exchange_rate_app_flutter/bloc/crypto/crypto_event.dart';
import 'package:currency_exchange_rate_app_flutter/bloc/crypto/crypto_state.dart';
import 'package:currency_exchange_rate_app_flutter/data/repository/crypto_currency_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:currency_exchange_rate_app_flutter/di/di.dart';

class CryptoBloc extends Bloc<CryptoEvent, CryptoState> {
  final ICryptoCurrencyRepository _repository = locator.get();

  CryptoBloc() : super(CryptoInitState()) {
    on<CryptoInitializeEvent>((event, emit) async {
      emit(CryptoLoadingState());
      // var response = await _repository.getCryptoCurrencies();
      var response = await _repository.getCurrencies();
      emit(CryptoResponseState(response));
    });
  }
}
