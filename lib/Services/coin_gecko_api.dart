class CoinGeckoApi {
  String coinListURL({required int page}) {
    String url =
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=${page.toString()}&sparkline=false';
    return url;
  }

  String coinSearchURL({required dynamic value}) {
    String url =
        'https://api.coingecko.com/api/v3/search?query=${value.toString()}';
    return url;
  }
}
