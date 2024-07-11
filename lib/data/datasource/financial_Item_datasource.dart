import 'package:currency_exchange_rate_app_flutter/data/model/financial_Item.dart';

abstract class IFinancialItemDataSource {
  Future<void> addItem(FinancialItem financialItem);
}
