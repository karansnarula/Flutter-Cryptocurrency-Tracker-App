import 'package:cryptocurrency_tracker/Data/data_extractor.dart';
import 'package:cryptocurrency_tracker/Data/data_types.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CoinPriceChart extends StatefulWidget {
  final String coinId;
  final int days;
  const CoinPriceChart({Key? key, required this.coinId, required this.days})
      : super(key: key);

  @override
  State<CoinPriceChart> createState() => _CoinPriceChartState();
}

class _CoinPriceChartState extends State<CoinPriceChart> {
  bool _isloading = true;
  late List<CoinChartData> _priceChart;

  @override
  void initState() {
    super.initState();
    _getPriceData();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isloading) {
      return SfCartesianChart(
        primaryXAxis: CategoryAxis(
          majorGridLines: const MajorGridLines(width: 0),
          labelStyle: const TextStyle(fontSize: 7),
        ),
        primaryYAxis: NumericAxis(
            rangePadding: ChartRangePadding.round,
            numberFormat: NumberFormat.compactCurrency(symbol: '\$'),
            labelStyle: const TextStyle(fontSize: 10)),
        series: <ChartSeries>[
          LineSeries<CoinChartData, String>(
            dataSource: _priceChart,
            xValueMapper: (CoinChartData data, _) => data.getTime,
            yValueMapper: (CoinChartData data, _) => data.getPrice,
            color: _priceChart[0].getPrice >
                    _priceChart[_priceChart.length - 1].getPrice
                ? Colors.redAccent
                : Colors.greenAccent,
          )
        ],
      );
    } else {
      return const Center(
        child: CircularProgressIndicator.adaptive(),
      );
    }
  }

  Future<void> _getPriceData() async {
    DataExtractor data = Provider.of<DataExtractor>(context, listen: false);
    _priceChart = await data.getCoinChartList(
        coinId: widget.coinId, days: widget.days) as List<CoinChartData>;
    setState(() {
      _isloading = false;
    });
  }
}
