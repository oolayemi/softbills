import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/locator.dart';
import '../../core/constants/loading_dialog.dart';
import '../../core/exceptions/error_handling.dart';
import '../../core/models/cable_tv_data.dart';
import '../../core/models/currency_rates.dart';
import '../../core/models/wallet_response.dart';
import '../../core/services/auth_service.dart';
import '../../core/utils/tools.dart';
import '../../widgets/utility_widgets.dart';
import '../services/transfer_funds_service.dart';
import '../transaction_successful/transaction_successful_view.dart';

class CableTvViewModel extends ReactiveViewModel {
  final TransferFundsService _transferFundsService = locator<TransferFundsService>();
  final AuthService _authService = locator<AuthService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();

  TextEditingController iucNumberController = TextEditingController();
  TextEditingController amountController = TextEditingController();


  List<CableBillers>? get cableBillers => _transferFundsService.cableBillers;
  CableBillers? biller;

  Map<String?, List<CableTvPackage>?> get cablePackages => _transferFundsService.packages;
  CableTvPackage? package;

  bool verified = false;
  String? customerName;

  WalletData? get wallet => _authService.walletResponse;

  List<Rates>? get rateList => _authService.ratesList;

  Rates? selectedRate;
  String? buildText;

  final formKey = GlobalKey<FormState>();

  void setup(context) async{
    if(cableBillers!.isEmpty) {
      await getData(context);
    }
    if(cableBillers!.isNotEmpty) {
      setBiller(cableBillers![0], context);
    }
    notifyListeners();
  }

  void setBiller(CableBillers val, BuildContext context) async{
    biller = val;
    package = null;
    verified = false;
    customerName = null;
    amountController.text = '';
    notifyListeners();
    if(cablePackages[val.name] == null) {
      await fetchPackages(context, val);
    }
    notifyListeners();
  }

  void setPackage(CableTvPackage val) {
    package = val;
    amountController.text = val.variationAmount!.toString();
    notifyListeners();
  }

  Future getData(context) async {

    try {

      final response = await dio().get('/cable/providers');

      int? statusCode = response.statusCode;

      String? success = jsonDecode(response.toString())['status'];
      Map<String, dynamic> json = jsonDecode(response.toString());

      if (statusCode == 200) {
        if (success == 'success') {
          CableTvData temp = CableTvData.fromJson(json);
          _transferFundsService.setCableBillers(temp.data);
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

  Future fetchPackages(context, CableBillers biller) async {
    try {

      final response = await dio().get('/cable/${biller.serviceID}/provider');

      int? statusCode = response.statusCode;

      String? success = jsonDecode(response.toString())['status'];
      Map<String, dynamic> json = jsonDecode(response.toString());

      if (statusCode == 200) {
        if (success == 'success') {
          PlansData temp = PlansData.fromJson(json);
          _transferFundsService.addPackage(biller.name, temp.data);
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

  Future validateProvider(context) async {
    LoaderDialog.showLoadingDialog(context, message: "Validating details...");

    Map<String, dynamic> payload = {
      'billers_code': iucNumberController.text,
      'service_id': biller!.serviceID.toString()
    };

    try {
      final response = await dio().post('/cable/validate', data: payload);

      int? statusCode = response.statusCode;
      String? success = jsonDecode(response.toString())['status'];

      Map<String, dynamic> json = jsonDecode(response.toString());
      print(json);

      _dialogService.completeDialog(DialogResponse());
      if (statusCode == 200) {
        if (success == 'success') {
          verified = true;
          customerName = json['data']['Customer_Name'];
          flusher('Verified Successfully', context, color: Colors.green);
          notifyListeners();
        } else {
          flusher(json['message'] ?? 'Error Fetching data', context, color: Colors.red);
        }
      } else {
        flusher(json['message'] ?? 'Error Fetching data', context, color: Colors.red);
      }
    } on DioException catch (e) {
      _dialogService.completeDialog(DialogResponse());
      flusher(DioExceptions.fromDioError(e).toString(), context, color: Colors.red);
    }
  }

  Future purchasePackage(context) async {
    LoaderDialog.showLoadingDialog(context, message: "Purchasing Cable TV...");

    Map<String, dynamic> payload = {
      'service_id': biller!.serviceID,
      'billers_code': iucNumberController.text,
      'variation_code': package!.variationCode,
      'amount': package!.variationAmount,
      'subscription_type': 'change'
    };

    try {

      final response = await dio().post('/cable/purchase', data: payload);

      int? statusCode = response.statusCode;
      String? success = jsonDecode(response.toString())['status'];

      Map<String, dynamic> json = jsonDecode(response.toString());

      if (statusCode == 200) {
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
          flusher(json['message'] ?? 'Error Fetching data', context, color: Colors.red);
        }
      } else {
        _dialogService.completeDialog(DialogResponse());
        flusher(json['message'] ?? 'Error Fetching data', context, color: Colors.red);
      }
    } on DioException catch (e) {
      _dialogService.completeDialog(DialogResponse());
      flusher(DioExceptions.fromDioError(e).toString(), context, color: Colors.red);
    }
  }

}