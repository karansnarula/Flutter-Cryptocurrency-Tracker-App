class CoinGeckoApi {
  static String coinList({required int page}) {
    String url =
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=${page.toString()}&sparkline=false';
    return url;
  }

  static String coinSearch({required dynamic value}) {
    String url =
        'https://api.coingecko.com/api/v3/search?query=${value.toString()}';
    return url;
  }

  static String coinMarketChart({required dynamic coinId, required int days}) {
    String url =
        'https://api.coingecko.com/api/v3/coins/${coinId.toString()}/market_chart?vs_currency=usd&days=${days.toString()}';
    return url;
  }
}
