import 'package:sk_bloc_issue/globals/coin_and_pair_provider.dart';
import 'package:sk_bloc_issue/models/pairs.dart';

List<Pair> sortCoins(Iterable<Pair> pairs) {
  var returnList = pairs.toList();

  returnList.sort((a, b) {
    var aCoin = CoinAndPairProvider.coins[a.coinID];
    var bCoin = CoinAndPairProvider.coins[b.coinID];

    if (aCoin == null || bCoin == null) {
      return 1;
    }

    return aCoin.symbol.compareTo(bCoin.symbol);
  });
  return returnList;
}
