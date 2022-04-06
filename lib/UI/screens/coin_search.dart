import 'package:flutter/material.dart';

class CoinSearch extends StatefulWidget {
  const CoinSearch({Key? key}) : super(key: key);

  @override
  State<CoinSearch> createState() => _CoinSearchState();
}

class _CoinSearchState extends State<CoinSearch> {
  final _myController = TextEditingController();
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
              // setState(() => );
            },
          ),
        ),
        const SizedBox(height: 20.0),
      ],
    );
  }

  @override
  void dispose() {
    _myController.dispose();
    super.dispose();
  }
}
