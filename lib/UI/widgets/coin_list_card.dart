import 'package:cryptocurrency_tracker/Data/data_extractor.dart';
import 'package:cryptocurrency_tracker/UI/screens/coin_information.dart';
import 'package:flutter/material.dart';

class CoinListCard extends StatelessWidget {
  final ListOfCoins coinList;
  final int coinRank;
  const CoinListCard({Key? key, required this.coinRank, required this.coinList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Card(
        child: InkWell(
          onTap: () => {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    CoinInformation(coinId: coinList.getCoinId)))
          },
          splashColor: Colors.blueGrey,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  child: DecoratedBox(
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text(coinRank.toString()),
                    ),
                    decoration: const BoxDecoration(color: Color(0xFF455A64)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.network(
                      // Coin Image
                      coinList.getCoinImageUrl,
                      width: 30.0,
                      height: 30.0,
                    ),
                    Padding(
                      // Coin Symbol
                      padding: const EdgeInsets.only(top: 3.0),
                      child: Text(coinList.getCoinSymbol.toUpperCase()),
                    )
                  ],
                ),
              ),
              const Spacer(),
              Text(
                //Coin Name
                coinList.getCoinName,
                softWrap: false,
              ),
              const Spacer(),
              Padding(
                // Coin Price
                padding: const EdgeInsets.only(right: 8.0),
                child: Text('\$${coinList.getCoinPrice.toString()}'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
