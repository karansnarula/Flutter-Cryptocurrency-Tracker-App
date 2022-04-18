import 'package:cryptocurrency_tracker/Data/data_types.dart';
import 'package:intl/intl.dart';
import 'package:cryptocurrency_tracker/Data/modified_data.dart';
import 'package:cryptocurrency_tracker/UI/widgets/coin_price_chart.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

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
                future: _getCoinInformation(coinId: widget.coinId),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child: CircularProgressIndicator.adaptive());
                  }
                  if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  } else {
                    return Column(
                      children: [
                        Center(
                          child: Text(
                            formattedPrice(snapshot
                                .data.getCoinPrice), //current price of the coin
                            style: const TextStyle(fontSize: 45),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 30,
                          width: 300,
                          child: Marquee(
                            text:
                                'Market Cap : ${formattedMarketVolume(snapshot.data.getMarketCap)}   |   24H Volume : ${formattedMarketVolume(snapshot.data.getDailyVolume)}   |   24H Change : ${formattedChangePercent(snapshot.data.getDailyChange)}   |   ',
                            style: const TextStyle(color: Colors.amberAccent),
                            scrollAxis: Axis.horizontal,
                            crossAxisAlignment: CrossAxisAlignment.start,
                          ),
                        ),
                      ],
                    );
                  }
                }),
            const SizedBox(
              height: 20,
            ),
            toggleButtons(), //toggle switch
            const SizedBox(
              height: 20,
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

  Future<InformationOfCoin> _getCoinInformation(
      {required String coinId}) async {
    ModifiedData data = Provider.of<ModifiedData>(context, listen: false);
    var _coinInfo = await data.getCoinInformation(coinId: coinId);
    return _coinInfo;
  }

  String formattedPrice(num price) {
    var formattedPrice = NumberFormat.simpleCurrency(
        locale: 'en_US', name: 'USD', decimalDigits: price < 0.0001 ? 10 : 5);
    return formattedPrice.format(price).toString();
  }

  String formattedMarketVolume(num value) {
    var formattedPrice = NumberFormat.simpleCurrency(
        locale: 'en_US', name: 'USD', decimalDigits: 0);
    return formattedPrice.format(value).toString();
  }

  String formattedChangePercent(num value) {
    var formattedPrice =
        NumberFormat.decimalPercentPattern(locale: 'en_US', decimalDigits: 2);
    return formattedPrice
        .format(value / 100)
        .toString(); // Have to divide by 100 as it looks like decimalPercentPattern multiplies it with 100
  }
}
