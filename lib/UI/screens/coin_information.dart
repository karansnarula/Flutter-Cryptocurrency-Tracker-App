import 'package:cryptocurrency_tracker/UI/widgets/coin_price_chart.dart';
import 'package:flutter/material.dart';

class CoinInformation extends StatefulWidget {
  final String coinId;
  const CoinInformation({Key? key, required this.coinId}) : super(key: key);

  @override
  State<CoinInformation> createState() => _CoinInformationState();
}

class _CoinInformationState extends State<CoinInformation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Info")),
        body: CoinPriceChart(coinId: widget.coinId, days: 1));
  }
}
