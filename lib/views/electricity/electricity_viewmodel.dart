import 'dart:convert';

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

  bool loadingName = false;
  bool verified = false;

  List<ElectricityBillers>? get electricityBillers => _transferFundsService.electricityBillers;
  ElectricityBillers? selectedBiller;

  List<Wallet>? get walletType => _authService.walletResponse;

  Wallet? selectedWallet;

  void setup(BuildContext context) async {
    selectedWallet = walletType!.first;
    if (electricityBillers!.isEmpty) {
      await getData(context);
      if (electricityBillers!.isNotEmpty) setElectricityBiller(electricityBillers![0]);
    }
    if (electricityBillers!.isNotEmpty) {
      if (electricityBillers!.isNotEmpty) setElectricityBiller(electricityBillers![0]);
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

  void setLoading(bool val) {
    loadingName = val;
    notifyListeners();
  }

  Future getData(context) async {

    try {

      final response = await dio().get('/electricity/billers');

      int? statusCode = response.statusCode;

      Map<String, dynamic> json = jsonDecode(response.toString());
      String? success = json['status'];

      if (statusCode == 200) {
        if (success == 'success') {
          ElectricityData temp = ElectricityData.fromJson(json);
          _transferFundsService.setElectricitybiller(temp.billers);
          notifyListeners();
        } else {
          flusher(json['message'] ?? 'Error Fetching data', context, color: Colors.red);
        }
      } else {
        flusher(json['message'] ?? 'Error Fetching data', context, color: Colors.red);
      }
    } on DioError catch (e) {
      print(e.response);
      flusher(DioExceptions.fromDioError(e).toString(), context, color: Colors.red);
    }
  }

  Future validateMeter(context) async {
    LoaderDialog.showLoadingDialog(context, message: "Validating meter number...");
    setLoading(true);

    Map<String, dynamic> payload = {'account_number': meterNoController.text, 'type': selectedBiller!.type};

    try {

      final response = await dio().post('/electricity/validate-meter', data: payload);

      int? statusCode = response.statusCode;

      Map<String, dynamic> json = jsonDecode(response.toString());
      String? success = json['status'];

      if (statusCode == 200) {
        if (success == 'success') {
          accountName = json['data']['customerName'];
          minimumAmount = json['data']['minimumAmount'].toString();

          setLoading(false);
          _dialogService.completeDialog(DialogResponse());
          verified = true;
          notifyListeners();
        } else {
          setLoading(false);
          resetName();
          _dialogService.completeDialog(DialogResponse());
          flusher(json['message'] ?? 'Error Fetching data', context, color: Colors.red);
        }
      } else {
        setLoading(false);
        resetName();
        _dialogService.completeDialog(DialogResponse());
        flusher(json['message'] ?? 'Error Fetching data', context, color: Colors.red);
      }
    } on DioError catch (e) {
      setLoading(false);
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
      'wallet_source': selectedWallet!.walletType,
    };

    try {

      final response = await dio().post('/electricity/purchase', data: payload);

      int? statusCode = response.statusCode;
      String? success = jsonDecode(response.toString())['status'];

      Map<String, dynamic> json = jsonDecode(response.toString());
      print(json);

      if (statusCode == 200) {
        if (success == 'success') {
          await _authService.getWalletDetails();
          await _authService.getWalletTransactions(page: 1);
          notifyListeners();
          _dialogService.completeDialog(DialogResponse());
          _navigationService.back();
        } else {
          _dialogService.completeDialog(DialogResponse());
          print(json);
          flusher(json['message'] ?? 'Error Fetching data', context, color: Colors.red);
        }
      } else {
        _dialogService.completeDialog(DialogResponse());
        flusher(json['message'] ?? 'Error Fetching data', context, color: Colors.red);
      }

    } on DioError catch (e) {
      _dialogService.completeDialog(DialogResponse());
      print(e);
      flusher(DioExceptions.fromDioError(e).toString(), context, color: Colors.red);
    }
  }

  @override
  // TODO: implement reactiveServices
  List<ReactiveServiceMixin> get reactiveServices => [];

}