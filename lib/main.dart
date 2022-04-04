import 'package:cryptocurrency_tracker/UI/screens/coin_list.dart';
import 'package:cryptocurrency_tracker/UI/screens/coin_search.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Crypto',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.blueGrey[900],
        // cardColor: const Color(0xFF222222)
      ),
      home: const _MainApp(),
    );
  }
}

class _MainApp extends StatefulWidget {
  const _MainApp({Key? key}) : super(key: key);

  @override
  State<_MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<_MainApp> {
  int _screenIndex = 0;
  final _screenPages = const [CoinList(), CoinSearch()];
  final _backgroundBarColor = Colors.black87;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Simple Crypto',
          style: TextStyle(color: Colors.white70),
        ),
        backgroundColor: _backgroundBarColor,
      ),
      body: _screenPages.elementAt(_screenIndex),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemTapped,
        currentIndex: _screenIndex,
        backgroundColor: _backgroundBarColor,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_rounded),
            label: 'Coin List',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Coin Search',
          ),
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _screenIndex = index;
    });
  }
}
