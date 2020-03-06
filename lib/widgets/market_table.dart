import 'package:flutter/material.dart';
import 'package:sk_bloc_issue/constants/color_constants.dart';
import 'package:sk_bloc_issue/enums/markets.dart';
import 'package:sk_bloc_issue/globals/coin_and_pair_provider.dart';
import 'package:sk_bloc_issue/models/pairs.dart';
import 'package:sk_bloc_issue/services/market_service.dart';
import 'package:sk_bloc_issue/utils/sort_coins.dart';
import 'package:sk_bloc_issue/widgets/loading_widget.dart';
import 'package:sk_bloc_issue/widgets/market_row.dart';

class MarketTable extends StatefulWidget {
  final Markets market;
  MarketTable({
    this.market,
    Key key,
  }) : super(key: key);

  @override
  _MarketTableState createState() => _MarketTableState();
}

class _MarketTableState extends State<MarketTable> {
  String market;

  MarketService service = MarketService();
  List<String> miscGroup;

  @override
  void initState() {
    miscGroup = CoinAndPairProvider.coins.values
        .where((coin) => coin.groupID == 1)
        .map((coin) => coin.symbol)
        .toList();

    switch (widget.market) {
      case Markets.TRY:
        market = 'TRY';
        break;
      case Markets.BTC:
        market = 'BTC';
        break;
      case Markets.ETH:
        market = 'ETH';
        break;
      case Markets.USD:
        market = 'USD';
        break;
      case Markets.EUR:
        market = 'EUR';
        break;
      case Markets.USDT:
        market = 'USDT';
        break;
      case Markets.MISC:
        market = 'MISC';
        break;
      default:
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<Map<int, Pair>>(
        stream: service.pairStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return LoadingWidget();
          }

          int _itemCount;
          if (widget.market == Markets.MISC) {
            _itemCount = snapshot.data.values.where(filterMisc).length;
          } else {
            _itemCount = snapshot.data.values.where(filterMarket).length;
          }
          List<Pair> sortedPairs = sortCoins(snapshot.data.values);
          return ListView.builder(
            itemCount: _itemCount,
            itemBuilder: (BuildContext context, int index) {
              Pair currentPair;
              if (market == "MISC") {
                currentPair = sortedPairs.where(filterMisc).elementAt(index);
              } else {
                currentPair = sortedPairs.where(filterMarket).elementAt(index);
              }
              Color changeColor;
              double currentPairChange = double.parse(currentPair.change);
              if (currentPairChange < 0) {
                changeColor = RED_COLOR;
              } else if (currentPairChange > 0) {
                changeColor = GREEN_COLOR;
              } else {
                changeColor = Colors.black;
              }
              return MarketRow(currentPair, changeColor);
            },
          );
        },
      ),
    );
  }

  bool filterMarket(Pair pair) {
    return pair.pairCoinSymbol == market;
  }

  bool filterMisc(Pair pair) {
    return miscGroup.contains(pair.pairCoinSymbol);
  }
}
