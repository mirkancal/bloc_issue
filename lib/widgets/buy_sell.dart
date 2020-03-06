import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sk_bloc_issue/blocs/pairswitch_bloc/pairswitch_bloc.dart';
import 'package:sk_bloc_issue/blocs/pairswitch_bloc/pairswitch_state.dart';

class BuySellPart extends StatefulWidget {
  @override
  _BuySellPartState createState() => _BuySellPartState();
}

class _BuySellPartState extends State<BuySellPart>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    _controller = TabController(length: 2, vsync: this);
    _controller.addListener(_handleTabSelection);
    super.initState();
  }

  void _handleTabSelection() {
    setState(() {});
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
        height: 250.0,
        child: Column(
          children: <Widget>[
            Container(
              height: 226,
              child: BuySellCard(type: 'SELL'),
            )
          ],
        ),
      ),
    );
  }
}

class BuySellCard extends StatefulWidget {
  final String type;
  BuySellCard({
    this.type,
    Key key,
  }) : super(key: key);

  @override
  _BuySellCardState createState() => _BuySellCardState();
}

class _BuySellCardState extends State<BuySellCard> {
  TextEditingController _priceController = TextEditingController();
  TextEditingController _amountController = TextEditingController();
  Decimal _total = Decimal.zero;
  String _price;
  String _amount;
  PairSwitchBloc _pairSwitchBloc;
  bool _isLoading = false;

  _calculateTotal() {
    final d = Decimal.tryParse;
    _price = _priceController.text == '' ? "0.0" : _priceController.text;
    _amount = _amountController.text == '' ? "0.0" : _amountController.text;

    setState(() {
      _total = d(_price.replaceAll(",", "")) * d(_amount.replaceAll(",", ""));
    });
  }

  @override
  void initState() {
    _pairSwitchBloc = BlocProvider.of<PairSwitchBloc>(context);

    _priceController.addListener(_calculateTotal);
    _amountController.addListener(_calculateTotal);

    super.initState();
  }

  @override
  void dispose() {
    _priceController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _pairSwitchBloc,
      listener: (context, state) {
        if (state is NewPairSelected) {
          _amountController.text = "";
          _priceController.text = "";
        }
      },
      child: BlocBuilder(
        bloc: _pairSwitchBloc,
        builder: (context, state) {
          if (state is NewPairSelected) {
            return Container(
              padding: const EdgeInsets.fromLTRB(36.0, 0.0, 36.0, 0.0),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      child: Column(
                        children: <Widget>[
                          Flexible(
                            child: TextFormField(
                              keyboardType:
                                  _pairSwitchBloc.currentPair.id == 1 ||
                                          _pairSwitchBloc.currentPair.id == 21
                                      ? TextInputType.number
                                      : TextInputType.numberWithOptions(
                                          decimal: true),
                              controller: _priceController,
                              textAlign: TextAlign.end,
                              decoration: InputDecoration(
                                // TODO Localization
                                labelText: "Price",
                                suffix: Text(
                                    _pairSwitchBloc.currentPair.pairCoinSymbol),
                              ),
                            ),
                          ),
                          Flexible(
                            child: TextFormField(
                              textAlign: TextAlign.end,
                              decoration: InputDecoration(
                                // TODO Localization
                                labelText: "Amount",
                                suffix: Text(
                                    _pairSwitchBloc.currentPair.coinSymbol),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
