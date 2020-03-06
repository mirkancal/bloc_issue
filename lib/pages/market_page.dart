import 'package:flutter/material.dart';
import 'package:sk_bloc_issue/enums/markets.dart';
import 'package:sk_bloc_issue/widgets/market_table.dart';

class MarketPage extends StatefulWidget {
  @override
  _MarketPageState createState() => _MarketPageState();
}

class _MarketPageState extends State<MarketPage> {
  @override
  Widget build(BuildContext context) {
    return MarketCard();
  }
}

class MarketCard extends StatefulWidget {
  const MarketCard({
    Key key,
  }) : super(key: key);

  @override
  _MarketCardState createState() => _MarketCardState();
}

class _MarketCardState extends State<MarketCard>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  // PusherService pusherService;
  @override
  void initState() {
    _controller = TabController(length: 7, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Container(
            height: 25.0,
            child: TabBar(
              labelColor: Colors.black,
              isScrollable: true,
              controller: _controller,
              tabs: <Widget>[
                Tab(
                  text: 'TRY',
                ),
                Tab(
                  text: 'BTC',
                ),
                Tab(
                  text: 'ETH',
                ),
                Tab(
                  text: 'USD',
                ),
                Tab(
                  text: 'EUR',
                ),
                Tab(
                  text: 'USDT',
                ),
                Tab(
                  text: 'MISC',
                ),
              ],
            ),
          ),
          Flexible(
            child: TabBarView(
              controller: _controller,
              children: <Widget>[
                MarketTable(
                  market: Markets.TRY,
                ),
                MarketTable(
                  market: Markets.BTC,
                ),
                MarketTable(
                  market: Markets.ETH,
                ),
                MarketTable(
                  market: Markets.USD,
                ),
                MarketTable(
                  market: Markets.EUR,
                ),
                MarketTable(
                  market: Markets.USDT,
                ),
                MarketTable(
                  market: Markets.MISC,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
