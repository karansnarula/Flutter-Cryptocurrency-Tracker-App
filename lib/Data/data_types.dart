class CoinChartData {
  final String timeInterval;
  final double price;
  CoinChartData({required this.timeInterval, required this.price});
  String get getTime => timeInterval;
  double get getPrice => price;
}

class ListOfCoins {
  final String coinId;
  final String coinName;
  final String coinSymbol;
  final num coinPrice;
  final String coinImageUrl;
  final List<double> coinSparkline;
  ListOfCoins(
      {required this.coinId,
      required this.coinName,
      required this.coinSymbol,
      required this.coinPrice,
      required this.coinImageUrl,
      required this.coinSparkline});
  String get getCoinId => coinId;
  String get getCoinName => coinName;
  String get getCoinSymbol => coinSymbol;
  num get getCoinPrice => coinPrice;
  String get getCoinImageUrl => coinImageUrl;
  List<double> get getCoinSparkline => coinSparkline;
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

class InformationOfCoin {
  final num coinPrice;
  final num marketCap;
  final num dailyVolume;
  final num dailyChange;
  InformationOfCoin(
      {required this.marketCap,
      required this.dailyVolume,
      required this.dailyChange,
      required this.coinPrice});
  num get getCoinPrice => coinPrice;
  num get getMarketCap => marketCap;
  num get getDailyVolume => dailyVolume;
  num get getDailyChange => dailyChange;
}
