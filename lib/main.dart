import 'package:cryptocurrency_tracker/Data/modified_data.dart';
import 'package:cryptocurrency_tracker/Data/raw_data.dart';
import 'package:cryptocurrency_tracker/UI/screens/coin_list.dart';
import 'package:cryptocurrency_tracker/UI/screens/coin_search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<ModifiedData>(
      create: (context) => ModifiedData(rawData: RawData()),
      child: MaterialApp(
        title: 'Simple Crypto',
        theme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: Colors.blueGrey[900],
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.black87,
            ),
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                backgroundColor: Colors.black87)),
        debugShowCheckedModeBanner: false,
        home: const _MainApp(),
      ),
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
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Simple Crypto',
            style: TextStyle(color: Colors.white70),
          ),
        ),
        //body: _screenPages.elementAt(_screenIndex),
        body: IndexedStack(
          index: _screenIndex,
          children: _screenPages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: _onItemTapped,
          currentIndex: _screenIndex,
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
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _screenIndex = index;
    });
  }
}
