import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:no_name/app/locator.dart';
import 'package:no_name/core/services/auth_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../core/constants/loading_dialog.dart';
import '../../core/exceptions/error_handling.dart';
import '../../core/models/betting_data.dart';
import '../../core/models/currency_rates.dart';
import '../../core/models/wallet_response.dart';
import '../../core/utils/tools.dart';
import '../../widgets/utility_widgets.dart';
import '../services/transfer_funds_service.dart';

class BettingViewModel extends ReactiveViewModel {
  final TransferFundsService _transferFundsService = locator<TransferFundsService>();
  final AuthService _authService = locator<AuthService>();
  final DialogService _dialogService = locator<DialogService>();

  TextEditingController betNumber = TextEditingController();
  TextEditingController amountController = TextEditingController();
  WalletData? get wallet => _authService.walletResponse;

  final formKey = GlobalKey<FormState>();

  String? betName;
  String? customerName;
  bool verified = false;
  var check, minPayAmount;

  List<BettingData> get betting => _transferFundsService.bettingList;
  List<BettingData> tempBetting = [];
  BettingData? selectedbiller;

  List<Rates>? get rateList => _authService.ratesList;

  Rates? selectedRate;
  String? buildText;


  void setBettingName(String val) {
    verified = false;
    betName = val;
    notifyListeners();
  }

  void setup(BuildContext context) async{
    if(betting.isEmpty) {
      await getData(context);
    }
    notifyListeners();
  }

  Future getData(context) async {

    try {
      final response = await dio().get('/betting/fetch-billers');

      int? statusCode = response.statusCode;

      String? success = jsonDecode(response.toString())['status'];
      Map<String, dynamic> json = jsonDecode(response.toString());

      if (statusCode == 200) {
        if (success == 'success') {
          BettingData temp = BettingData.fromJson(json);
          // _transferFundsService.setBettingList(temp.)
          print('Data 1::: $json');
          // print('Data 2::: ${value['data']}');

          check = json['data'];
          notifyListeners();
        } else {
          flusher(json['message'] ?? 'Error Fetching data', context, color: Colors.red);
        }
      } else {
        flusher(json['message'] ?? 'Error Fetching data', context, color: Colors.red);
      }
    } on DioException catch (e) {
      flusher(DioExceptions.fromDioError(e).toString(), context, color: Colors.red);
    }
  }

  Future validateBetting(context) async {
    LoaderDialog.showLoadingDialog(context, message: "Validating Betting details...");

    Map<String, dynamic> payload = {
      'customerId': betNumber.text,
      'type': betName
    };

    try {
      final response = await dio().post('/betting/validate', data: payload);

      int? statusCode = response.statusCode;
      String? success = jsonDecode(response.toString())['status'];

      Map<String, dynamic> json = jsonDecode(response.toString());
      print(json);

      if (statusCode == 200) {
        if (success == 'success') {
          verified = true;
          customerName = json['data']['name'];
          minPayAmount = json['data']['minPayableAmount'];
          _dialogService.completeDialog(DialogResponse());
          flusher('Verified Successfully', context, color: Colors.green);
          notifyListeners();

        } else {
          _dialogService.completeDialog(DialogResponse());
          flusher(json['message'] ?? 'Error Fetching data', context, color: Colors.red);
        }
      } else {
        _dialogService.completeDialog(DialogResponse());
        flusher(json['message'] ?? 'Error Fetching data', context, color: Colors.red);
      }
    } on DioException catch (e) {
      print(e.response!.data);
      _dialogService.completeDialog(DialogResponse());
      flusher(DioExceptions.fromDioError(e).toString(), context, color: Colors.red);
    }
  }

  Future purchaseBetting(context) async {
    LoaderDialog.showLoadingDialog(context, message: 'Purchasing $betName of ${amountController.text}');

    Map<String, dynamic> payload = {
      'customerId': betNumber.text,
      'type': betName,
      'amount': amountController.text,
      'name': customerName
    };

    try {

      final response = await dio().post('/betting/purchase', data: payload);

      int? statusCode = response.statusCode;
      String? success = jsonDecode(response.toString())['status'];

      Map<String, dynamic> json = jsonDecode(response.toString());

      if (statusCode == 200) {
        if (success == 'success') {
          await _authService.getWalletDetails();
          await _authService.getWalletTransactions(page: 1);
          notifyListeners();
          _dialogService.completeDialog(DialogResponse());

        } else {
          _dialogService.completeDialog(DialogResponse());
          flusher(json['message'] ?? 'Error Fetching data', context, color: Colors.red);
        }
      } else {
        _dialogService.completeDialog(DialogResponse());
        flusher(json['message'] ?? 'Error Fetching data', context, color: Colors.red);
      }
    } on DioException catch (e) {
      print(e.response!.data);
      _dialogService.completeDialog(DialogResponse());
      flusher(DioExceptions.fromDioError(e).toString(), context, color: Colors.red);
    }
  }

  @override
  // TODO: implement reactiveServices
  List<ReactiveServiceMixin> get reactiveServices => [];

}