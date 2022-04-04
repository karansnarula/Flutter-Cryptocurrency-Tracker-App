import 'package:cryptocurrency_tracker/Services/coin_gecko_api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DataRepository {
  CoinGeckoApi api;
  DataRepository(this.api);

  Future<List<dynamic>> getCoinList({required int page}) async {
    final response = await http.get(Uri.parse(api.coinListURL(page: page)));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data;
    }
    throw response;
  }

  Future<List<dynamic>> getCoinSearch({required dynamic value}) async {
    final response = await http.get(Uri.parse(api.coinSearchURL(value: value)));
    if (response.statusCode == 200) {
      final Map<dynamic, dynamic> data = json.decode(response.body);
      return data['coins'];
    }
    throw response;
  }
}
