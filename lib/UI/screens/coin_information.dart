import 'package:intl/intl.dart';
import 'package:cryptocurrency_tracker/Data/modified_data.dart';
import 'package:cryptocurrency_tracker/UI/widgets/coin_price_chart.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';
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
  late int _days;
  late int _index;
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
            const SizedBox(
              height: 30,
            ),
            FutureBuilder(
                future: _getCoinPrice(coinId: widget.coinId),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child: CircularProgressIndicator.adaptive());
                  }
                  if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  } else {
                    return Center(
                      child: Text(
                        '\$' + snapshot.data,
                        style: const TextStyle(
                            fontSize: 50), //current price of the coin
                      ),
                    );
                  }
                }),
            const SizedBox(
              height: 30,
            ),
            toggleButtons(), //toggle switch
            const SizedBox(
              height: 30,
            ),
            CoinPriceChart(coinId: widget.coinId, days: _days), //price chart
          ],
        ));
  }

  @override
  void initState() {
    super.initState();
    _index = 0;
    _days = 1;
  }

  Widget toggleButtons() {
    return ToggleSwitch(
      initialLabelIndex: _index,
      totalSwitches: 5,
      labels: const ['1D', '7D', '30D', '90D', '1Y'],
      activeBgColor: const [Colors.amber],
      activeFgColor: Colors.black,
      inactiveBgColor: Colors.black,
      inactiveFgColor: Colors.white70,
      onToggle: (index) {
        if (index == 0) {
          _days = 1;
        } else if (index == 1) {
          _days = 7;
        } else if (index == 2) {
          _days = 30;
        } else if (index == 3) {
          _days = 90;
        } else {
          _days = 365;
        }
        setState(() {
          _index = index!;
        });
      },
    );
  }

  Future<String> _getCoinPrice({required String coinId}) async {
    ModifiedData data = Provider.of<ModifiedData>(context, listen: false);
    var price = await data.getCoinPrice(coinId: coinId);
    var formattedPrice = NumberFormat("0.##########");
    return formattedPrice.format(price.getCoinPrice).toString();
  }
}
