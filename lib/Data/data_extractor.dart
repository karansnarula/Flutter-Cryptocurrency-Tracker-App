import 'package:cryptocurrency_tracker/Data/data_retriever.dart';
import 'package:cryptocurrency_tracker/Data/data_types.dart';
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

  Future<List> getCoinSearch({required dynamic value}) async {
    var finalList = <SearchCoin>[];
    var searchList = await dataRetriever.getCoinSearch(value: value);
    for (var element in searchList) {
      finalList.add(SearchCoin(
          coinId: element['id'],
          coinName: element['name'],
          coinSymbol: element['symbol'],
          coinImageUrl: element['large']));
    }
    return finalList;
  }
}
