import 'package:flutter/material.dart';
import 'package:sk_bloc_issue/models/pairs.dart';
import 'package:sk_bloc_issue/utils/format_numbers.dart';

class MarketSelectRow extends StatefulWidget {
  final Pair currentPair;
  final Color changeColor;

  MarketSelectRow(this.currentPair, this.changeColor);
  @override
  MarketSelectRowState createState() => MarketSelectRowState();
}

class MarketSelectRowState extends State<MarketSelectRow> {
  Pair get currentPair => widget.currentPair;
  Color get changeColor => widget.changeColor;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 8, right: 8),
      child: Container(
        child: Row(
          children: <Widget>[
            Container(
              width: (MediaQuery.of(context).size.width / 4) - 28,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FittedBox(
                    child: Text('${currentPair.coinSymbol}',
                        style: Theme.of(context).textTheme.title),
                  ),
                  Text(
                    '${currentPair.pairCoinSymbol}',
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              ),
            ),
            Container(
              width: (MediaQuery.of(context).size.width / 2) - 8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  FittedBox(
                    child: Text(
                        '${formatNumber(currentPair.rate, currentPair.numberOfDigitsPairCoin.toString())}',
                        style: Theme.of(context).textTheme.title),
                  ),
                  Text(
                      '${formatNumber(currentPair.volume, currentPair.numberOfDigitsPairCoin.toString())}',
                      style: Theme.of(context).textTheme.caption),
                ],
              ),
            ),
            Container(
              width: (MediaQuery.of(context).size.width / 4) - 8,
              child: Center(
                child: FittedBox(
                  child: Text(
                    '${formatNumber(currentPair.change, "2")}%',
                    style: Theme.of(context)
                        .textTheme
                        .title
                        .copyWith(color: changeColor),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
