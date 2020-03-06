import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:sk_bloc_issue/models/pairs.dart';

@immutable
abstract class PairSwitchEvent extends Equatable {
  PairSwitchEvent([List props = const []]) : super();
}

class SelectPair extends PairSwitchEvent {
  final Pair pair;

  SelectPair({
    @required this.pair,
  }) : super([pair]);

  @override
  String toString() =>
      'PairSelect { pair: ${pair.coinSymbol}/${pair.pairCoinSymbol} }';

  @override
  // TODO: implement props
  List<Object> get props => [pair];
}
