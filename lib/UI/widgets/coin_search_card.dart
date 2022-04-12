import 'package:cryptocurrency_tracker/Data/data_types.dart';
import 'package:flutter/material.dart';

class CoinSearchCard extends StatelessWidget {
  final SearchCoin searchCoin;
  const CoinSearchCard({Key? key, required this.searchCoin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {},
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
                    child: Text(searchCoin.getCoinSymbol.toUpperCase()),
                  )
                ],
              ),
            ),
            Text(
              //Coin Name
              searchCoin.getCoinName,
              softWrap: false,
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
