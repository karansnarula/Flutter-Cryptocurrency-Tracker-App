import 'package:flutter/material.dart';

class CoinCard extends StatelessWidget {
  const CoinCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Card(
        child: InkWell(
          onTap: () => {},
          splashColor: Colors.blueGrey,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [Text("Test"), Text("Test"), Text("Test")],
          ),
        ),
      ),
    );
  }

  // Future<void> printDataSample() async {
  //   DataRetriever data;
  //   data = DataRetriever();
  //   var lst = await data.getCoinMarketChart(coinId: 'bitcoin', days: 2);

  //   DataExtractor data;
  //   data = DataExtractor();
  //   var lst = await data.getCoinChartList(coinId: 'bitcoin', days: 1);
  //   print(lst[0].getTime);
  // }
}
