import 'package:cryptocurrency_tracker/Data/data_retriever.dart';
import 'package:intl/intl.dart';

class DataExtractor {
  DataRetriever dataRetriever;
  DataExtractor({required this.dataRetriever});
  Future<List> getCoinChartList(
      {required dynamic coinId, required int days}) async {
    var finalList = <CoinChartData>[];
    var pricesList =
        await dataRetriever.getCoinMarketChart(coinId: coinId, days: days);
    var dateFormat = DateFormat('kk:mm');
    if (days > 1 && days <= 90) {
      dateFormat = DateFormat('dd/MM kk:mm');
    }
    if (days >= 365) {
      dateFormat = DateFormat('dd/MM/yyyy');
    }
    for (var element in pricesList) {
      finalList.add(CoinChartData(
          timeInterval: dateFormat
              .format(DateTime.fromMillisecondsSinceEpoch(element[0])),
          price: element[1]));
    }
    return finalList;
  }
}

class CoinChartData {
  CoinChartData({required this.timeInterval, required this.price});
  final String timeInterval;
  final double price;
  String get getTime => timeInterval;
  double get getPrice => price;
}
