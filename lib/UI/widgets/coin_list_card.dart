import 'package:cryptocurrency_tracker/Data/data_types.dart';
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
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: InkWell(
          onTap: () => {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => CoinInformation(
                      coinId: coinList.getCoinId,
                      coinImage: Image.network(
                        // Coin Image
                        coinList.getCoinImageUrl,
                        width: 20.0,
                        height: 20.0,
                      ),
                      coinName: coinList.getCoinName,
                    )))
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
                      padding: const EdgeInsets.all(6.0),
                      child: Text(
                        coinRank.toString(),
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
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
                      child: Text(
                        coinList.getCoinSymbol.toUpperCase(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const Spacer(),
              Text(
                //Coin Name
                coinList.getCoinName.length <= 15
                    ? coinList.getCoinName
                    : coinList.getCoinName.substring(0, 16) + "...",
                softWrap: false,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Padding(
                // Coin Price
                padding: const EdgeInsets.only(right: 8.0),
                child: Text(
                  '\$${coinList.getCoinPrice.toString()}',
                  style: TextStyle(
                    fontSize: coinList.getCoinPrice < 0.000001 ? 12 : 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
