import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class PairSwitchState extends Equatable {
  PairSwitchState([List props = const []]) : super();
}

class InitialPairSwitchState extends PairSwitchState {
  @override
  String toString() => 'InitialPairSwitch';

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class NewPairSelected extends PairSwitchState {
  int id;
  NewPairSelected(this.id);
  @override
  String toString() => 'NewPairSelected';

  @override
  // TODO: implement props
  List<Object> get props => [id];
}

class LoadingPair extends PairSwitchState {
  @override
  String toString() => 'LoadingPair';

  @override
  // TODO: implement props
  List<Object> get props => null;
}
