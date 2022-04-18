class CoinGeckoApi {
  static String coinList({required int page, required int numberOfCoins}) {
    String url =
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=${numberOfCoins.toString()}&page=${page.toString()}&sparkline=true';
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

  static String coinInformation({required dynamic coinId}) {
    String url =
        'https://api.coingecko.com/api/v3/simple/price?ids=${coinId.toString()}&vs_currencies=usd&include_market_cap=true&include_24hr_vol=true&include_24hr_change=true&include_last_updated_at=false';
    return url;
  }
}
