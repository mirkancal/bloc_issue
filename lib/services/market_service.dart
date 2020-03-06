import 'package:rxdart/rxdart.dart';
import 'package:sk_bloc_issue/globals/coin_and_pair_provider.dart';
import 'package:sk_bloc_issue/models/pairs.dart';
import 'package:sk_bloc_issue/repository/repository.dart';

class MarketService {
  static final MarketService _marketService = MarketService._internal();

  MarketService._internal() {
    loadFromSingleton();
  }

  factory MarketService() {
    return _marketService;
  }

  Repository repo = Repository();

  // SocketService _socketIOService = SocketService();

  final _pairController = BehaviorSubject<Map<int, Pair>>();
  Sink<Map<int, Pair>> get _inPair => _pairController.sink;
  Stream<Map<int, Pair>> get pairStream => _pairController.stream;

  void loadFromSingleton() {
    _inPair.add(CoinAndPairProvider.pairs);
  }
}
