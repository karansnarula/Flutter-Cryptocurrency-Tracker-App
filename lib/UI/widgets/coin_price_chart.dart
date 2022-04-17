import 'package:cryptocurrency_tracker/Data/modified_data.dart';
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
  @override
  void initState() {
    super.initState();
    _getPriceData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getPriceData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        } else {
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
                dataSource: snapshot.data,
                xValueMapper: (CoinChartData data, _) => data.getTime,
                yValueMapper: (CoinChartData data, _) => data.getPrice,
                color: snapshot.data[0].getPrice >
                        snapshot.data[snapshot.data.length - 1].getPrice
                    ? Colors.redAccent
                    : Colors.greenAccent,
              )
            ],
          );
        }
      },
    );
  }

  void refreshChart() {
    setState(() {});
  }

  Future<List> _getPriceData() async {
    ModifiedData data = Provider.of<ModifiedData>(context, listen: false);
    List<CoinChartData> _priceChart = await data.getCoinChartList(
        coinId: widget.coinId, days: widget.days) as List<CoinChartData>;
    return _priceChart;
  }
}
