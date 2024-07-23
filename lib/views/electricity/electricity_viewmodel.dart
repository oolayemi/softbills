import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:no_name/app/locator.dart';
import 'package:no_name/core/services/auth_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../core/constants/loading_dialog.dart';
import '../../core/exceptions/error_handling.dart';
import '../../core/models/electricity_data.dart';
import '../../core/models/wallet_response.dart';
import '../../core/utils/tools.dart';
import '../../widgets/utility_widgets.dart';
import '../services/transfer_funds_service.dart';
import '../transaction_successful/transaction_successful_view.dart';

class ElectricityViewModel extends ReactiveViewModel {
  final AuthService _authService = locator<AuthService>();
  final TransferFundsService _transferFundsService = locator<TransferFundsService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final DialogService _dialogService = locator<DialogService>();

  final formKey = GlobalKey<FormState>();

  TextEditingController amountController = TextEditingController();
  TextEditingController meterNoController = TextEditingController();

  String? accountName;
  String? minimumAmount;

  String selectedType = "prepaid";

  bool verified = false;

  List<ElectricityBillers>? get electricityBillers => _transferFundsService.electricityBillers;
  ElectricityBillers? selectedBiller;

  WalletData? get wallet => _authService.walletResponse;

  void setup(BuildContext context) async {
    if (electricityBillers!.isEmpty) {
      await getData(context);
      if (electricityBillers!.isNotEmpty) {
        setElectricityBiller(electricityBillers![0]);
      }
    }
    if (electricityBillers!.isNotEmpty) {
      if (electricityBillers!.isNotEmpty) {
        setElectricityBiller(electricityBillers![0]);
      }
    }
    notifyListeners();
  }

  void setElectricityBiller(ElectricityBillers val) {
    verified = false;
    accountName = null;
    minimumAmount = null;
    selectedBiller = val;
    notifyListeners();
  }

  void resetName() {
    accountName = null;
    minimumAmount = null;
    verified = false;
    notifyListeners();
  }

  void pop() {
    _navigationService.back();
  }

  Future getData(context) async {
    try {
      final response = await dio().get('/electricity/providers');

      int? statusCode = response.statusCode;

      Map<String, dynamic> json = jsonDecode(response.toString());
      String? success = json['status'];

      if (statusCode == 200) {
        if (success == 'success') {
          ElectricityData temp = ElectricityData.fromJson(json);
          _transferFundsService.setElectricitybiller(temp.data);
          notifyListeners();
        } else {
          flusher(json['message'] ?? 'Error Fetching data', context, color: Colors.red);
        }
      } else {
        flusher(json['message'] ?? 'Error Fetching data', context, color: Colors.red);
      }
    } on DioException catch (e) {
      print(e.response);
      flusher(DioExceptions.fromDioError(e).toString(), context, color: Colors.red);
    }
  }

  Future validateMeter(context) async {
    LoaderDialog.showLoadingDialog(context, message: "Validating meter number...");

    Map<String, dynamic> payload = {
      'account_number': meterNoController.text,
      'type': selectedBiller!.type,
    };

    try {
      final response = await dio().post('/electricity/validate', data: payload);

      int? statusCode = response.statusCode;

      Map<String, dynamic> json = jsonDecode(response.toString());
      log(jsonEncode(json));
      String? success = json['status'];

      if (statusCode == 200) {
        if (success == 'success' && json['data']['customerName'] != null) {
          accountName = json['data']['customerName'];

          _dialogService.completeDialog(DialogResponse());
          verified = true;
          notifyListeners();
        } else {
          resetName();
          _dialogService.completeDialog(DialogResponse());
          flusher(json['message'] ?? 'Error Fetching data', context, color: Colors.red);
        }
      } else {
        resetName();
        _dialogService.completeDialog(DialogResponse());
        flusher(json['message'] ?? 'Error Fetching data', context, color: Colors.red);
      }
    } on DioException catch (e) {
      resetName();
      _dialogService.completeDialog(DialogResponse());
      flusher(DioExceptions.fromDioError(e).toString(), context, color: Colors.red);
    }
  }

  Future purchaseElectricity(context) async {
    LoaderDialog.showLoadingDialog(context, message: 'Purchasing ${selectedBiller!.narration} of ${amountController.text}');

    Map<String, dynamic> payload = {
      'account_number': meterNoController.text,
      'type': selectedBiller!.type,
      'amount': amountController.text,
    };

    try {
      final response = await dio().post('/electricity/purchase', data: payload);
      String? success = jsonDecode(response.toString())['status'];
      Map<String, dynamic> json = jsonDecode(response.toString());

      if (success == 'success') {
        await _authService.getWalletDetails();
        await _authService.getWalletTransactions(page: 1);
        notifyListeners();
        _dialogService.completeDialog(DialogResponse());
        _navigationService.back();
        _navigationService.navigateToView(
          const TransactionSuccessfulView(),
        );
      } else {
        _dialogService.completeDialog(DialogResponse());
        print(json);
        flusher(json['message'] ?? 'Error Fetching data', context, color: Colors.red);
      }
    } on DioException catch (e) {
      _dialogService.completeDialog(DialogResponse());
      flusher(DioExceptions.fromDioError(e).toString(), context, color: Colors.red);
    }
  }

  @override
  // TODO: implement reactiveServices
  List<ReactiveServiceMixin> get reactiveServices => [];
}
