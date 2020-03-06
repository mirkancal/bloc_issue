import 'package:sk_bloc_issue/models/coins.dart';
import 'package:sk_bloc_issue/models/pairs.dart';
import 'package:sk_bloc_issue/repository/repository.dart';

/// This singleton will  be  provide
/// coins and pairs when the app launches
class CoinAndPairProvider {
  static final CoinAndPairProvider _singleton = CoinAndPairProvider._internal();
  static Repository repo = Repository();
  static Map<int, Coin> coins;
  static Map<int, Pair> pairs;
  static Future<List<Map<int, Object>>> myFuture;
  // static Future<Map<int, BannerModel>> banners;

  /// Use it when the app starts, gets the coins and pairs from API
  static void fireSingleton() async {
    myFuture = Future.wait([repo.getCoinList(), repo.getPairList()]);
    List<Map<int, Object>> data = await myFuture;
    coins = data[0];
    pairs = data[1];
  }

  factory CoinAndPairProvider() {
    return _singleton;
  }

  CoinAndPairProvider._internal();
}
