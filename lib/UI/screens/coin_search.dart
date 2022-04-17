import 'package:cryptocurrency_tracker/Data/modified_data.dart';
import 'package:cryptocurrency_tracker/Data/data_types.dart';
import 'package:cryptocurrency_tracker/UI/widgets/coin_search_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CoinSearch extends StatefulWidget {
  const CoinSearch({Key? key}) : super(key: key);

  @override
  State<CoinSearch> createState() => _CoinSearchState();
}

class _CoinSearchState extends State<CoinSearch> {
  final _controller = ScrollController();
  final _myController = TextEditingController();
  String _value = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: TextField(
            controller: _myController,
            decoration: const InputDecoration(
                hintText: 'Search for a coin...',
                suffixIcon: Icon(Icons.search)),
            onChanged: (value) {
              _value = value.toString();
              setState(() {});
            },
          ),
        ),
        const SizedBox(height: 20.0),
        Expanded(
          child: _value != ''
              ? _showSearchResult(value: _value)
              : Center(
                  child: Column(
                    children: [
                      Icon(
                        Icons.search_rounded,
                        color: Colors.grey[400],
                        size: 100,
                      ),
                      Text(
                        'Search coin...',
                        style: TextStyle(color: Colors.grey[400]),
                      )
                    ],
                  ),
                ),
        ),
      ],
    );
  }

  Widget _showSearchResult({required dynamic value}) {
    return FutureBuilder(
        future: _getSearchResult(value: value),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Column(
              children: const [
                Center(child: CircularProgressIndicator.adaptive()),
              ],
            );
          }
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else {
            return ListView.builder(
              controller: _controller,
              itemCount: snapshot.data!.length,
              itemBuilder: ((context, index) {
                return CoinSearchCard(
                  searchCoin: snapshot.data[index],
                );
              }),
              scrollDirection: Axis.vertical,
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              shrinkWrap: true,
            );
          }
        });
  }

  Future<List> _getSearchResult({required dynamic value}) async {
    ModifiedData data = Provider.of<ModifiedData>(context, listen: false);
    List<SearchCoin> resultList =
        await data.getCoinSearch(value: value) as List<SearchCoin>;
    return resultList;
  }

  @override
  void dispose() {
    _myController.dispose();
    super.dispose();
  }
}
