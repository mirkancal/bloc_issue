import 'package:flutter/material.dart';
import 'package:sk_bloc_issue/pages/home_page.dart';
import 'package:sk_bloc_issue/pages/market_page.dart';
import 'package:sk_bloc_issue/pages/transaction_page.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  List<Widget> _pages;
  @override
  void initState() {
    _pages = [
      HomePage(),
      MarketPage(),
      TransactionsPage(),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      left: false,
      right: false,
      child: Scaffold(
        backgroundColor: Colors.blue,
        body: _pages[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: onTabTapped,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text(
                "Home",
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.store),
              title: Text("Market"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.multiline_chart),
              title: Text("Transactions"),
            ),
          ],
        ),
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
