import 'package:cryptocurrency_tracker/Data/raw_data.dart';
import 'package:cryptocurrency_tracker/Data/data_types.dart';
import 'package:intl/intl.dart';

class ModifiedData {
  RawData rawData;
  ModifiedData({required this.rawData});

  Future<List> getCoinChartList(
      {required dynamic coinId, required int days}) async {
    var finalList = <CoinChartData>[];
    var pricesList =
        await rawData.getCoinMarketChart(coinId: coinId, days: days);
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
    var coinList =
        await rawData.getCoinList(page: page, numberOfCoins: numberOfCoins);
    for (var element in coinList) {
      var sparklineList = element["sparkline_in_7d"] as Map;
      finalList.add(ListOfCoins(
          coinId: element["id"],
          coinName: element["name"],
          coinSymbol: element["symbol"],
          coinPrice: element["current_price"],
          coinImageUrl: element["image"],
          coinSparkline: sparklineList.values.first
              .sublist(sparklineList.values.first.length - 24)
              .cast<
                  double>())); //"sparkline_in_7d": { "price": [ 42304.11322779421, 42242.45036782667, ....] |  Get only the latest 24 hours
    }
    return finalList;
  }

  Future<List> getCoinSearch({required dynamic value}) async {
    var finalList = <SearchCoin>[];
    var searchList = await rawData.getCoinSearch(value: value);
    for (var element in searchList) {
      finalList.add(SearchCoin(
          coinId: element['id'],
          coinName: element['name'],
          coinSymbol: element['symbol'],
          coinImageUrl: element['large']));
    }
    return finalList;
  }

  Future<InformationOfCoin> getCoinInformation(
      {required dynamic coinId}) async {
    var coinInformation = await rawData.getCoinInformation(coinId: coinId);
    return InformationOfCoin(
        marketCap: coinInformation["usd_market_cap"],
        dailyVolume: coinInformation["usd_24h_vol"],
        dailyChange: coinInformation["usd_24h_change"],
        coinPrice: coinInformation["usd"]);
  }
}
