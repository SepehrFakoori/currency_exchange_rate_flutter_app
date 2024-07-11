import 'package:hive/hive.dart';

part 'financial_Item.g.dart';

@HiveType(typeId: 0)
class FinancialItem {
  @HiveField(0)
  String? name;
  @HiveField(1)
  String? currentPrice;
  @HiveField(2)
  String? high;
  @HiveField(3)
  String? low;
  @HiveField(4)
  String? change;
  @HiveField(5)
  String? percent;
  @HiveField(6)
  String? time;

  FinancialItem(
    this.name,
    this.currentPrice,
    this.high,
    this.low,
    this.change,
    this.percent,
    this.time,
  );
}
