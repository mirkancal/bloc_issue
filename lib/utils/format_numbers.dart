import 'package:decimal/decimal.dart';
import 'package:intl/intl.dart';

String formatNumber(dynamic currency, String numberOfDigits) {
  final d = Decimal.tryParse;
  Decimal decimalCurrency;
  final formatter = NumberFormat.decimalPattern()
    ..maximumFractionDigits = int.parse(numberOfDigits)
    ..minimumFractionDigits = int.parse(numberOfDigits);

  // final formatter = NumberFormat.currency();
  if (currency is Decimal) {
    decimalCurrency = currency;
  }
  if (currency is String) {
    String cleanString = currency.replaceAll(",", "");
    decimalCurrency = d(cleanString);
  }
  if (currency is double) {
    decimalCurrency = d(currency.toString());
  }

  return formatter.format(decimalCurrency.toDouble());
}
