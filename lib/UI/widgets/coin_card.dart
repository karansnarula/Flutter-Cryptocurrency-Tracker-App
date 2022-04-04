import 'package:cryptocurrency_tracker/Data/data_repository.dart';
import 'package:cryptocurrency_tracker/Services/coin_gecko_api.dart';
import 'package:flutter/material.dart';

class CoinCard extends StatelessWidget {
  const CoinCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Card(
        child: InkWell(
          onTap: () => {printDataSample()},
          splashColor: Colors.blueGrey,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [Text("Test"), Text("Test"), Text("Test")],
          ),
        ),
      ),
    );
  }

  void printDataSample() async {
    CoinGeckoApi api;
    DataRepository data;
    api = CoinGeckoApi();
    data = DataRepository(api);
    var lst = await data.getCoinSearch(value: 'bit');
    print(lst);
  }
}
