import 'package:currency_exchange_rate_app_flutter/bloc/home/home_event.dart';
import 'package:currency_exchange_rate_app_flutter/bloc/home/home_state.dart';
import 'package:currency_exchange_rate_app_flutter/data/repository/price_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:currency_exchange_rate_app_flutter/di/di.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IPriceRepository _repository = locator.get();

  HomeBloc() : super(HomeInitState()) {
    on<HomeInitializeEvent>((event, emit) async {
      emit(HomeLoadingState());
      var currencyResponse = await _repository.getCurrencies();
      var goldResponse = await _repository.getGolds();
      var coinResponse = await _repository.getCoins();

      emit(HomeResponseState(currencyResponse, goldResponse, coinResponse));
    });
  }
}
