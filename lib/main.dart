import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sk_bloc_issue/blocs/pairswitch_bloc/pairswitch_bloc.dart';
import 'package:sk_bloc_issue/globals/coin_and_pair_provider.dart';
import 'package:sk_bloc_issue/pages/home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (_) {
      runApp(
        App(),
      );
    },
  );
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  PairSwitchBloc pairSwitchBloc;
  @override
  void initState() {
    CoinAndPairProvider.fireSingleton();
    pairSwitchBloc = PairSwitchBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: pairSwitchBloc,
      child: MaterialApp(
        title: "Issue App",
        home: Home(),
      ),
    );
  }
}

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    print(transition.toString());
    super.onTransition(bloc, transition);
  }
}
