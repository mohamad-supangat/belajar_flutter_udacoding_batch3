import 'package:flutter_money_formatter/flutter_money_formatter.dart';

formatRupiah(amount) {
  return FlutterMoneyFormatter(
    amount: amount.toDouble(),
    settings: MoneyFormatterSettings(
      symbol: 'Rp.',
      thousandSeparator: '.',
      decimalSeparator: ',',
      symbolAndNumberSeparator: ' ',
      fractionDigits: 0,
      // compactFormatType: CompactFormatType.sort,
    ),
  ).output.symbolOnLeft;
}
