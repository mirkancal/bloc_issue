import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:sk_bloc_issue/blocs/pairswitch_bloc/pairswitch_event.dart';
import 'package:sk_bloc_issue/blocs/pairswitch_bloc/pairswitch_state.dart';
import 'package:sk_bloc_issue/models/pairs.dart';

class PairSwitchBloc extends Bloc<PairSwitchEvent, PairSwitchState> {
  Pair currentPair;
  @override
  PairSwitchState get initialState => InitialPairSwitchState();

  @override
  Stream<PairSwitchState> mapEventToState(
    PairSwitchEvent event,
  ) async* {
    if (event is SelectPair) {
      yield LoadingPair();
      currentPair = event.pair;
      // Check the await keyword
      // orderService.configureService(currentPair.id);
      yield NewPairSelected(currentPair.id);
    }
  }
}
