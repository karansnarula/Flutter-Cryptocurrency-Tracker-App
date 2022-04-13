import 'package:cryptocurrency_tracker/Data/data_types.dart';
import 'package:cryptocurrency_tracker/UI/screens/coin_information.dart';
import 'package:flutter/material.dart';

class CoinSearchCard extends StatelessWidget {
  final SearchCoin searchCoin;
  const CoinSearchCard({Key? key, required this.searchCoin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => CoinInformation(
                    coinId: searchCoin.getCoinId,
                    coinImage: Image.network(
                      // Coin Image
                      searchCoin.getCoinImageUrl,
                      width: 20.0,
                      height: 20.0,
                    ),
                    coinName: searchCoin.getCoinName,
                  )));
        },
        splashColor: Colors.blueGrey,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Image.network(
                    // Coin Image
                    searchCoin.getCoinImageUrl,
                    width: 30.0,
                    height: 30.0,
                  ),
                  Padding(
                    // Coin Symbol
                    padding: const EdgeInsets.only(top: 3.0),
                    child: Text(
                      searchCoin.getCoinSymbol.toUpperCase(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Text(
              //Coin Name
              searchCoin.getCoinName,
              style: TextStyle(
                fontSize: searchCoin.getCoinName.length < 32 ? 15 : 10,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              width: 20,
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
