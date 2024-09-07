import 'dart:async';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:no_name/core/services/utility_storage_service.dart';

import '../../app/locator.dart';
import '../exceptions/error_handling.dart';
import '../services/auth_service.dart';

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

String formatMoney(amount) {
  String nairaSymbol = '₦';
    return "$nairaSymbol${formatAmount(amount)}";
}

Dio dio({bool withToken = true}) {
  return Dio(
    BaseOptions(
      baseUrl: env('APP_URL')!,
      connectTimeout: const Duration(seconds: 90),
      receiveTimeout: const Duration(seconds: 90),
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
  )..interceptors.add(CustomInterceptor());
}

String ucWord(String string){
  return string.substring(0, 1).toUpperCase() + string.substring(1);
}

class CustomInterceptor extends Interceptor {
  @override
  FutureOr<dynamic> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // Pass the request on to the next interceptor
    return handler.next(options);
  }

  @override
  FutureOr<dynamic> onResponse(Response response, ResponseInterceptorHandler handler) async {
    // Pass the response on to the next interceptor
    if(response.statusCode == 401){
      print("Response error");
      locator<AuthService>().signOut();
      return;
    }
    return handler.next(response);
  }

  @override
  FutureOr<dynamic> onError(DioException err, ErrorInterceptorHandler handler) async {
    // Do something with the error
    // For example, log the error message
    if(err.response?.statusCode == 401) {
      Fluttertoast.showToast(msg: DioExceptions.fromDioError(err).message);
      locator<AuthService>().signOut();
      return;
    }

    // Pass the error on to the next interceptor
    return handler.next(err);
  }
}

void copyToClipboard(String value, String message) {
  Clipboard.setData(ClipboardData(text: value)).then(
        (value) => Fluttertoast.showToast(msg: message, backgroundColor: Colors.blue),
  );
}

String parseDate(DateTime date) {
  DateTime now = DateTime.now();
  if (date.year == now.year && date.month == now.month && date.day == now.day) {
    return "Today";
  }

  if (date.year == now.year && date.month == now.month && date.day == now.day-1) {
    return "Yesterday";
  }

  return DateFormat('dd MMMM, yyyy').format(date);
}

String formatTime(int totalSeconds) {
  int minutes = totalSeconds ~/ 60;
  int seconds = totalSeconds % 60;

  if (minutes != 0) return '${minutes}m ${seconds}s';
  return '${seconds}s';
}