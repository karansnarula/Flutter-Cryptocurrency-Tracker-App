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
          //First element is the Epoc time and the second is the price
          timeInterval: dateFormat
              .format(DateTime.fromMillisecondsSinceEpoch(element[0])),
          price: element[1]));
    }
    return finalList;
  }

  Future<List> getListOfCoins(
      {required int page, required int numberOfCoins}) async {
    var finalList = <ListOfCoins>[];
    var coinList = await dataRetriever.getCoinList(
        page: page, numberOfCoins: numberOfCoins);
    for (var element in coinList) {
      finalList.add(ListOfCoins(
          coinId: element["id"],
          coinName: element["name"],
          coinSymbol: element["symbol"],
          coinPrice: element["current_price"],
          coinImageUrl: element["image"]));
    }
    return finalList;
  }
}

class ListOfCoins {
  final String coinId;
  final String coinName;
  final String coinSymbol;
  final num coinPrice;
  final String coinImageUrl;
  ListOfCoins(
      {required this.coinId,
      required this.coinName,
      required this.coinSymbol,
      required this.coinPrice,
      required this.coinImageUrl});
  String get getCoinId => coinId;
  String get getCoinName => coinName;
  String get getCoinSymbol => coinSymbol;
  num get getCoinPrice => coinPrice;
  String get getCoinImageUrl => coinImageUrl;
}

class CoinChartData {
  CoinChartData({required this.timeInterval, required this.price});
  final String timeInterval;
  final double price;
  String get getTime => timeInterval;
  double get getPrice => price;
}
