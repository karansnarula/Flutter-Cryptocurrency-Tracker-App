import 'package:cryptocurrency_tracker/UI/widgets/coin_card.dart';
import 'package:flutter/material.dart';

class CoinList extends StatefulWidget {
  const CoinList({Key? key}) : super(key: key);

  @override
  State<CoinList> createState() => _CoinListState();
}

class _CoinListState extends State<CoinList> {
  @override
  Widget build(BuildContext context) {
    return const CoinCard();
  }
}
