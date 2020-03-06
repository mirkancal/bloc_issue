/// Model for pairs
class Pair {
  int id;
  int coinID;
  String coinSymbol;
  int pairCoinID;
  String pairCoinSymbol;

  /// format price
  int numberOfDigitsPairCoin;

  /// format amount
  int numberOfDigitsCoin;
  bool isActive;
  String rate;
  String minimum;
  String maximum;
  String volume;
  String change;
  String changeValue;
  String changeDirection;

  Pair(
      {this.id,
      this.coinID,
      this.coinSymbol,
      this.pairCoinID,
      this.pairCoinSymbol,
      this.numberOfDigitsPairCoin,
      this.numberOfDigitsCoin,
      this.isActive,
      this.rate,
      this.minimum,
      this.maximum,
      this.volume,
      this.change,
      this.changeValue,
      this.changeDirection});

  Pair.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    coinID = json['coinID'];
    coinSymbol = json['coinSymbol'];
    pairCoinID = json['pairCoinID'];
    pairCoinSymbol = json['pairCoinSymbol'];
    numberOfDigitsPairCoin = json['numberOfDigitsPairCoin'];
    numberOfDigitsCoin = json['numberOfDigitsCoin'];
    isActive = json['isActive'];
    rate = json['rate'];
    minimum = json['minimum'];
    maximum = json['maximum'];
    volume = json['volume'];
    change = json['change'].toString();
    changeValue = json['changeValue'];
    changeDirection = json['changeDirection'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['coinID'] = this.coinID;
    data['coinSymbol'] = this.coinSymbol;
    data['pairCoinID'] = this.pairCoinID;
    data['pairCoinSymbol'] = this.pairCoinSymbol;
    data['numberOfDigitsPairCoin'] = this.numberOfDigitsPairCoin;
    data['numberOfDigitsCoin'] = this.numberOfDigitsCoin;
    data['isActive'] = this.isActive;
    data['rate'] = this.rate;
    data['minimum'] = this.minimum;
    data['maximum'] = this.maximum;
    data['volume'] = this.volume;
    data['change'] = this.change;
    data['changeValue'] = this.changeValue;
    data['changeDirection'] = this.changeDirection;
    return data;
  }

  @override
  String toString() {
    return "Pair id: ${this.id}\nPair: ${this.coinSymbol}/${this.pairCoinSymbol}";
  }
}
