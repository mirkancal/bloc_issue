import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sk_bloc_issue/blocs/pairswitch_bloc/pairswitch_bloc.dart';
import 'package:sk_bloc_issue/blocs/pairswitch_bloc/pairswitch_event.dart';
import 'package:sk_bloc_issue/blocs/pairswitch_bloc/pairswitch_state.dart';
import 'package:sk_bloc_issue/constants/color_constants.dart';
import 'package:sk_bloc_issue/enums/markets.dart';
import 'package:sk_bloc_issue/globals/coin_and_pair_provider.dart';
import 'package:sk_bloc_issue/models/pairs.dart';
import 'package:sk_bloc_issue/services/market_service.dart';
import 'package:sk_bloc_issue/utils/format_numbers.dart';
import 'package:sk_bloc_issue/utils/sort_coins.dart';
import 'package:sk_bloc_issue/widgets/buy_sell.dart';
import 'package:sk_bloc_issue/widgets/loading_widget.dart';
import 'package:sk_bloc_issue/widgets/market_row.dart';
import 'package:sk_bloc_issue/widgets/market_select_row.dart';

class TransactionsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  PairSwitchBloc _pairSwitchBloc;
  // TransferTextBloc _transferTextBloc;
  Pair currentPair;
  MediaQueryData mediaData;

  @override
  void initState() {
    _pairSwitchBloc = BlocProvider.of<PairSwitchBloc>(context);
    // _transferTextBloc = TransferTextBloc()
    //   ..add(
    //     TapRowEvent(
    //       textValue: TextValue(price: "", amount: ""),
    //     ),
    //   );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    mediaData = MediaQuery.of(context);
    return BlocBuilder<PairSwitchBloc, PairSwitchState>(
      bloc: _pairSwitchBloc,
      builder: (BuildContext context, PairSwitchState state) {
        currentPair = _pairSwitchBloc.currentPair;
        if (state is NewPairSelected) {
          return Column(
            children: <Widget>[
              Material(
                child: InkWell(
                  highlightColor: SKYellow,
                  splashColor: SKYellow,
                  onTap: () {
                    _pairSwitchDialog(context);
                  },
                  child: PairName(currentPair: _pairSwitchBloc.currentPair),
                ),
              ),
              Container(
                height: 250,
                child: BuySellPart(),
              ),
              Container(
                height: 50,
                child: StreamBuilder<Map<int, Pair>>(
                  stream: MarketService().pairStream,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Container();
                    }
                    var currentPair =
                        snapshot.data[_pairSwitchBloc.currentPair.id];
                    String rateData = formatNumber(currentPair.rate,
                        currentPair.numberOfDigitsPairCoin.toString());
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          "Latest Price",
                          style: Theme.of(context).textTheme.caption.copyWith(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        Text(rateData,
                            style: Theme.of(context).textTheme.title),
                      ],
                    );
                  },
                ),
              ),
              BlocProvider(
                create: (context) => _pairSwitchBloc,
                child: Flexible(
                  child: Text("Hello"),
                  // child: OrderTable(pairID: _pairSwitchBloc.currentPair.id),
                ),
              ),
            ],
          );
        }
        if (state is LoadingPair) {
          return LoadingWidget();
        }
        return Container();
      },
    );
  }

  _pairSwitchDialog(BuildContext context) async {
    await showDialog<String>(
      context: context,
      builder: (context) {
        return Center(
          child: BlocProvider(
            create: (context) => _pairSwitchBloc,
            child: MarketSelect(),
          ),
        );
      },
    );
  }
}

class PairName extends StatelessWidget {
  const PairName({
    Key key,
    this.currentPair,
  }) : super(key: key);

  final Pair currentPair;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '${currentPair.coinSymbol}/${currentPair.pairCoinSymbol}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }
}

class MarketSelect extends StatefulWidget {
  const MarketSelect({
    Key key,
  }) : super(key: key);

  @override
  _MarketSelectState createState() => _MarketSelectState();
}

class _MarketSelectState extends State<MarketSelect>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  @override
  void initState() {
    _controller = TabController(length: 7, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350.0,
      child: Card(
        color: PRIMARY_COLOR,
        child: Column(
          children: <Widget>[
            Container(
              height: 25.0,
              child: TabBar(
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
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

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
  String marketName;

  MarketService bloc = MarketService();
  PairSwitchBloc pairSwitchBloc;

  List<String> miscGroup;
  @override
  void initState() {
    miscGroup = CoinAndPairProvider.coins.values
        .where((coin) => coin.groupID == 1)
        .map((coin) => coin.symbol)
        .toList();

    pairSwitchBloc = BlocProvider.of<PairSwitchBloc>(context);
    switch (widget.market) {
      case Markets.TRY:
        marketName = 'TRY';
        break;
      case Markets.BTC:
        marketName = 'BTC';
        break;
      case Markets.ETH:
        marketName = 'ETH';
        break;
      case Markets.USD:
        marketName = 'USD';
        break;
      case Markets.EUR:
        marketName = 'EUR';
        break;
      case Markets.USDT:
        marketName = 'USDT';
        break;
      case Markets.MISC:
        marketName = 'MISC';
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
      padding: const EdgeInsets.all(10.0),
      child: StreamBuilder<Map<int, Pair>>(
          stream: bloc.pairStream,
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
                if (marketName == "MISC") {
                  currentPair = sortedPairs.where(filterMisc).elementAt(index);
                } else {
                  currentPair =
                      sortedPairs.where(filterMarket).elementAt(index);
                }
                Color changeColor = setColor(currentPair.change);
                return InkWell(
                  highlightColor: SKYellow,
                  splashColor: SKYellow,
                  onTap: () {
                    pairSwitchBloc.add(SelectPair(pair: currentPair));
                    Navigator.of(context).pop();
                  },
                  child: MarketSelectRow(currentPair, changeColor),
                );
              },
            );
          }),
    );
  }

  bool filterMarket(Pair pair) {
    return pair.pairCoinSymbol == marketName;
  }

  bool filterMisc(Pair pair) {
    return miscGroup.contains(pair.pairCoinSymbol);
  }

  Color setColor(String change) {
    double currentPairChange = double.parse(change);
    if (currentPairChange < 0) {
      return RED_COLOR;
    } else if (currentPairChange > 0) {
      return GREEN_COLOR;
    } else {
      return ACCENT_COLOR;
    }
  }
}
