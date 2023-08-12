import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';
import 'package:no_name/core/services/utility_storage_service.dart';

String? env(name) {
  return dotenv.env[name];
}

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
final Random _rnd = Random();

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

matchCurrency(String value){
  return value == "naira" ? "NGN": value == 'dollar' ? "USD" : "BTC";
}

String formatAmount(amount) {
  amount = double.parse(amount.toString());
  return NumberFormat('#,###,###,###.########').format(amount);
}

String formatMoney(amount, {String walletType = 'naira'}) {
  String nairaSymbol = '₦';
  String dollarSymbol = "\$";
  String btcSymbol = 'btc';
  if (walletType == 'naira'){
    return "$nairaSymbol${formatAmount(amount)}";
  } else if(walletType == 'dollar') {
    return "$dollarSymbol${formatAmount(amount)}";
  } else {
    return "${formatAmount(amount)} $btcSymbol";
  }
}

Dio dio({bool withToken = true}) {
  return Dio(
    BaseOptions(
      baseUrl: env('APP_URL')!,
      connectTimeout: 90000,
      receiveTimeout: 90000,
      headers: withToken
          ? {
              "Content-Type": "application/json",
              "Accept": "application/json",
              "Authorization": "Bearer ${StorageService().getString('token')}"
            }
          : {
              "Content-Type": "application/json",
              "Accept": "application/json",
            },
    ),
  );
}

String ucWord(String string){
  return string.substring(0, 1).toUpperCase() + string.substring(1);
}
