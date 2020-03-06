import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:sk_bloc_issue/data/coin_json.dart';
import 'package:sk_bloc_issue/data/pair_json.dart';
import 'package:sk_bloc_issue/models/coins.dart';
import 'package:sk_bloc_issue/models/pairs.dart';

class Repository {
  Future<Map<int, Coin>> getCoinList() async {
    final responseBody = coinJson;
    return compute(parseCoinList, responseBody);
  }

  Future<Map<int, Pair>> getPairList() async {
    final responseBody = pairJson;
    return compute(parsePairList, responseBody);
  }
}

Map<int, Pair> parsePairList(String responseBody) {
  final Map<String, dynamic> parsed =
      jsonDecode(responseBody) as Map<String, dynamic>;
  List data = parsed['data'];
  Map<int, Pair> mapToReturn = Map.fromIterable(data.where((item) {
    return item['isActive'];
  }), key: (item) => item['id'], value: (item) => Pair.fromJson(item));
  return mapToReturn;
}

Map<int, Coin> parseCoinList(String responseBody) {
  final Map<String, dynamic> parsed =
      jsonDecode(responseBody) as Map<String, dynamic>;
  List data = parsed['data'];
  Map<int, Coin> mapToReturn = Map.fromIterable(data.where((item) {
    return true;
  }), key: (item) => item['id'], value: (item) => Coin.fromJson(item));
  return mapToReturn;
}
