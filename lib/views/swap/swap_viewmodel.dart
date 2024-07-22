import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:no_name/core/services/auth_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/locator.dart';
import '../../core/constants/loading_dialog.dart';
import '../../core/exceptions/error_handling.dart';
import '../../core/models/currency_rates.dart';
import '../../core/utils/tools.dart';
import '../../widgets/utility_widgets.dart';

class SwapViewModel extends ReactiveViewModel {
  String swapFromValue = 'DOLLAR';
  String swapToValue = "NAIRA";

  final formKey = GlobalKey<FormState>();

  final AuthService _authService = locator<AuthService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();

  List<Rates>? get rateList => _authService.ratesList;

  TextEditingController amountController = TextEditingController();

  Rates? selectedRate;
  String? buildText;
  String? exchangeText;

  void setUp() {
    getExchange();
  }

  void getExchange() {
    String fromValue = swapFromValue.toLowerCase();
    String toValue = swapToValue.toLowerCase();
    selectedRate =
        rateList?.where((element) => element.currencyFrom == fromValue).where((element) => element.currencyTo == toValue).first;

    if (selectedRate != null) {
      buildText = "1${matchCurrency(fromValue)} = ${selectedRate!.rate}${matchCurrency(toValue)}";
      exchangeText = (amountController.text.isNotEmpty)
          ? "${amountController.text}${matchCurrency(toValue)} = ${(int.parse(amountController.text) / selectedRate!.rate!).toStringAsFixed(2)}${matchCurrency(fromValue)}"
          : null;
    }
    notifyListeners();
  }

  Future exchangeCurrency(context) async {
    LoaderDialog.showLoadingDialog(context, message: "Exchanging currency...");

    Map<String, dynamic> payload = {
      'from': swapFromValue.toLowerCase(),
      'to': swapToValue.toLowerCase(),
      'amount': amountController.text,
    };

    try {
      final response = await dio().post('/rates/exchange', data: payload);

      String? success = jsonDecode(response.toString())['status'];

      Map<String, dynamic> json = jsonDecode(response.toString());
      print(json);

      if (success == 'success') {
        await _authService.getWalletDetails();
        await _authService.getWalletTransactions(page: 1);
        notifyListeners();
        _dialogService.completeDialog(DialogResponse());
        _navigationService.back();
      } else {
        _dialogService.completeDialog(DialogResponse());
        flusher(json['message'] ?? 'Error Fetching data', context, color: Colors.red);
      }
    } on DioException catch (e) {
      print(e.response?.data);
      _dialogService.completeDialog(DialogResponse());
      flusher(DioExceptions.fromDioError(e).toString(), context, color: Colors.red);
    }
  }

  @override
  // TODO: implement reactiveServices
  List<ReactiveServiceMixin> get reactiveServices => [_authService];
}
