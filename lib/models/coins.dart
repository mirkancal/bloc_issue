/// Model for coins
class Coin {
  int id;
  String symbol;
  int groupID;
  int showPublic;
  int coinOrder;
  String fullName;
  String buyFee;
  String decimalPrecision;

  ///1 ieo, 0 normal
  String ieoProcess;
  String isFiat;
  String isLive;
  String mainAddress;
  String minConfirmationNumber;
  String minDeposit;
  String minThreshold;
  String minWithdraw;
  String relatedLimitCoin;
  String sellFee;
  String state;
  String subAddress;

  ///1 deposit, 0 normal
  String deposit;

  ///1 withdraw, 0 normal
  String withdraw;
  String withdrawFee;
  String withdrawLimitDaily;
  String withdrawLimitMonthly;
  Coin(
      {this.id,
      this.symbol,
      this.groupID,
      this.showPublic,
      this.coinOrder,
      this.fullName,
      this.buyFee,
      this.decimalPrecision,
      this.deposit,
      this.ieoProcess,
      this.isFiat,
      this.isLive,
      this.mainAddress,
      this.minConfirmationNumber,
      this.minDeposit,
      this.minThreshold,
      this.minWithdraw,
      this.relatedLimitCoin,
      this.sellFee,
      this.state,
      this.subAddress,
      this.withdraw,
      this.withdrawFee,
      this.withdrawLimitDaily,
      this.withdrawLimitMonthly});

  Coin.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    symbol = json['symbol'];
    groupID = json['groupID'];
    showPublic = json['showPublic'];
    coinOrder = json['coinOrder'];
    fullName = json['fullName'];
    buyFee = json['buyFee'];
    decimalPrecision = json['decimalPrecision'];
    deposit = json['deposit'];
    ieoProcess = json['ieoProcess'];
    isFiat = json['isFiat'];
    isLive = json['isLive'];
    mainAddress = json['mainAddress'];
    minConfirmationNumber = json['minConfirmationNumber'];
    minDeposit = json['minDeposit'];
    minThreshold = json['minThreshold'];
    minWithdraw = json['minWithdraw'];
    relatedLimitCoin = json['relatedLimitCoin'];
    sellFee = json['sellFee'];
    state = json['state'];
    subAddress = json['subAddress'];
    withdraw = json['withdraw'];
    withdrawFee = json['withdrawFee'];
    withdrawLimitDaily = json['withdrawLimitDaily'];
    withdrawLimitMonthly = json['withdrawLimitMonthly'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['symbol'] = this.symbol;
    data['groupID'] = this.groupID;
    data['showPublic'] = this.showPublic;
    data['coinOrder'] = this.coinOrder;
    data['fullName'] = this.fullName;
    data['buyFee'] = this.buyFee;
    data['decimalPrecision'] = this.decimalPrecision;
    data['deposit'] = this.deposit;
    data['ieoProcess'] = this.ieoProcess;
    data['isFiat'] = this.isFiat;
    data['isLive'] = this.isLive;
    data['mainAddress'] = this.mainAddress;
    data['minConfirmationNumber'] = this.minConfirmationNumber;
    data['minDeposit'] = this.minDeposit;
    data['minThreshold'] = this.minThreshold;
    data['minWithdraw'] = this.minWithdraw;
    data['relatedLimitCoin'] = this.relatedLimitCoin;
    data['sellFee'] = this.sellFee;
    data['state'] = this.state;
    data['subAddress'] = this.subAddress;
    data['withdraw'] = this.withdraw;
    data['withdrawFee'] = this.withdrawFee;
    data['withdrawLimitDaily'] = this.withdrawLimitDaily;
    data['withdrawLimitMonthly'] = this.withdrawLimitMonthly;
    return data;
  }

  @override
  String toString() {
    return "name: ${this.fullName}, symbol:  ${this.symbol}\nid: ${this.id}, order: ${this.coinOrder}";
  }
}
