import 'package:cryptocurrency_tracker/Services/coin_gecko_api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DataRetriever {
  Future<List> getCoinList(
      {required int page, required int numberOfCoins}) async {
    final response = await http.get(Uri.parse(
        CoinGeckoApi.coinList(page: page, numberOfCoins: numberOfCoins)));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data;
    }
    throw response;
  }

  Future<List> getCoinSearch({required dynamic value}) async {
    final response =
        await http.get(Uri.parse(CoinGeckoApi.coinSearch(value: value)));
    if (response.statusCode == 200) {
      final Map<dynamic, dynamic> data = json.decode(response.body);
      return data['coins'];
    }
    throw response;
  }

  Future<List> getCoinMarketChart(
      {required dynamic coinId, required int days}) async {
    final response = await http.get(
        Uri.parse(CoinGeckoApi.coinMarketChart(coinId: coinId, days: days)));
    if (response.statusCode == 200) {
      final Map<dynamic, dynamic> data = json.decode(response.body);
      return data['prices'];
    }
    throw response;
  }
}
