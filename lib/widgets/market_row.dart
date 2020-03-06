import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sk_bloc_issue/blocs/pairswitch_bloc/pairswitch_bloc.dart';
import 'package:sk_bloc_issue/blocs/pairswitch_bloc/pairswitch_event.dart';
import 'package:sk_bloc_issue/constants/color_constants.dart';
import 'package:sk_bloc_issue/models/pairs.dart';
import 'package:sk_bloc_issue/repository/repository.dart';
import 'package:sk_bloc_issue/utils/format_numbers.dart';

class MarketRow extends StatefulWidget {
  final Pair currentPair;
  final Color changeColor;
  final bool isFavorite;

  MarketRow(this.currentPair, this.changeColor, {this.isFavorite = false});
  @override
  MarketRowState createState() => MarketRowState();
}

class MarketRowState extends State<MarketRow> {
  Pair get currentPair => widget.currentPair;
  Color get changeColor => widget.changeColor;
  Repository _repository;
  PairSwitchBloc _pairSwitchBloc;
  @override
  void initState() {
    _repository = Repository();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _pairSwitchBloc = BlocProvider.of<PairSwitchBloc>(context);
    return InkWell(
      splashColor: SKYellow,
      highlightColor: SKYellow,
      onTap: () {
        _pairSwitchBloc.add(
          SelectPair(pair: currentPair),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0, left: 8, right: 8),
        child: Container(
          child: Row(
            children: <Widget>[
              Container(
                width: (MediaQuery.of(context).size.width / 4) - 8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('${currentPair.coinSymbol}',
                        style: Theme.of(context).textTheme.title),
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
                    Text(
                        formatNumber(currentPair.rate,
                            currentPair.numberOfDigitsPairCoin.toString()),
                        style: Theme.of(context).textTheme.title),
                    Text(
                        formatNumber(currentPair.volume,
                            currentPair.numberOfDigitsPairCoin.toString()),
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
      ),
    );
  }
}
