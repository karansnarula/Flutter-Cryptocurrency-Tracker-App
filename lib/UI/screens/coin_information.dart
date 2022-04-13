import 'package:cryptocurrency_tracker/UI/widgets/coin_price_chart.dart';
import 'package:flutter/material.dart';

class CoinInformation extends StatefulWidget {
  final String coinId;
  final Image coinImage;
  final String coinName;
  const CoinInformation({
    Key? key,
    required this.coinId,
    required this.coinImage,
    required this.coinName,
  }) : super(key: key);

  @override
  State<CoinInformation> createState() => _CoinInformationState();
}

class _CoinInformationState extends State<CoinInformation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Row(
          children: [
            widget.coinImage,
            const SizedBox(
              width: 20,
            ),
            Text(widget.coinName),
          ],
        )),
        body: Column(
          children: [
            CoinPriceChart(coinId: widget.coinId, days: 1),
          ],
        ));
  }
}
