import 'package:cryptocurrency_tracker/Data/data_extractor.dart';
import 'package:cryptocurrency_tracker/Data/data_types.dart';
import 'package:cryptocurrency_tracker/UI/widgets/coin_list_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CoinList extends StatefulWidget {
  const CoinList({Key? key}) : super(key: key);

  @override
  State<CoinList> createState() => _CoinListState();
}

class _CoinListState extends State<CoinList> {
  final _controller = ScrollController();
  bool _isLoading = true;
  bool _hasMore = true;
  late int _page;
  final int _numberOfCoins = 50;
  List<ListOfCoins> _coinList = [];

  @override
  void initState() {
    super.initState();
    _page = 1;
    _getCoinList(page: _page, numberOfCoins: _numberOfCoins);
    _controller.addListener(() {
      if (_controller.position.maxScrollExtent == _controller.offset) {
        setState(() {
          _getCoinList(page: _page, numberOfCoins: _numberOfCoins);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isLoading && _hasMore) {
      return RefreshIndicator(
        onRefresh: (() {
          _page = 1;
          _coinList.clear();
          return _getCoinList(page: _page, numberOfCoins: _numberOfCoins);
        }),
        child: ListView.builder(
            controller: _controller,
            itemCount: _coinList.length + 1,
            itemBuilder: (context, index) {
              if (index < _coinList.length) {
                return CoinListCard(
                    coinRank: index + 1, coinList: _coinList[index]);
              } else {
                return const Center(
                    child: CircularProgressIndicator.adaptive());
              }
            }),
      );
    } else {
      return Center(
          child: _hasMore
              ? const CircularProgressIndicator.adaptive()
              : const Text("No more coins"));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _getCoinList(
      {required int page, required int numberOfCoins}) async {
    DataExtractor data = Provider.of<DataExtractor>(context, listen: false);
    var newList = await data.getListOfCoins(
        page: page, numberOfCoins: numberOfCoins) as List<ListOfCoins>;
    ++_page;
    _coinList.addAll(newList);
    setState(() {
      if (newList.length < numberOfCoins) {
        _hasMore = false;
      }
      _isLoading = false;
    });
  }
}
