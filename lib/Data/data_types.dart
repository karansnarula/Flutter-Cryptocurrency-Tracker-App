class CoinChartData {
  CoinChartData({required this.timeInterval, required this.price});
  final String timeInterval;
  final double price;
  String get getTime => timeInterval;
  double get getPrice => price;
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

class SearchCoin {
  final String coinId;
  final String coinName;
  final String coinSymbol;
  final String coinImageUrl;
  SearchCoin(
      {required this.coinId,
      required this.coinName,
      required this.coinSymbol,
      required this.coinImageUrl});
  String get getCoinId => coinId;
  String get getCoinName => coinName;
  String get getCoinSymbol => coinSymbol;
  String get getCoinImageUrl => coinImageUrl;
}
