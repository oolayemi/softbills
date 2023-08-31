import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:no_name/app/locator.dart';
import 'package:no_name/core/services/auth_service.dart';
import 'package:no_name/views/services/transfer_funds_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../core/constants/loading_dialog.dart';
import '../../core/exceptions/error_handling.dart';
import '../../core/models/currency_rates.dart';
import '../../core/models/data_beneficiaries.dart';
import '../../core/models/data_billers.dart';
import '../../core/models/wallet_response.dart';
import '../../core/utils/tools.dart';
import '../../widgets/utility_widgets.dart';

class SmeDataViewModel extends ReactiveViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthService _authService = locator<AuthService>();
  final TransferFundsService _transferFundsService = locator<TransferFundsService>();
  final DialogService _dialogService = locator<DialogService>();

  List<DataBeneficiary>? get dataBeneficiaries => _authService.dataBeneficiaries;

  TextEditingController amountController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  WalletData? get wallet => _authService.walletResponse;

  List<SMEDataBillers>? get smeBillers => _transferFundsService.smeBillers;

  bool fetched = false;
  bool errorFetching = false;

  String? smeDataName;
  SMEDataBillers? package;

  List<Rates>? get rateList => _authService.ratesList;

  Rates? selectedRate;
  String? buildText;

  Future setup(BuildContext context) async {
    errorFetching = false;

    if (smeBillers!.isEmpty) {
      await getData(context);
      setBiller(smeBillers![0], context);
    } else {
      setBiller(smeBillers![0], context);
    }

    notifyListeners();
  }

  Future getData(context) async {
    try {
      final response = await dio().get('/sme-data/lookup');

      int? statusCode = response.statusCode;

      String? success = jsonDecode(response.toString())['status'];
      Map<String, dynamic> json = jsonDecode(response.toString());

      if (statusCode == 200) {
        if (success == 'success') {
          SMEDataBillersData temp = SMEDataBillersData.fromJson(json);
          _transferFundsService.setSMEBillers(temp.billers);
          print('billers 2::: ${temp.billers}');
          notifyListeners();
        } else {
          flusher(json['message'] ?? 'Error Fetching data', context, color: Colors.red);
          errorFetching = true;
        }
      } else {
        flusher(json['message'] ?? 'Error Fetching data', context, color: Colors.red);
        errorFetching = true;
        fetched = false;
      }
    } on DioError catch (e) {
      errorFetching = true;
      flusher(DioExceptions.fromDioError(e).toString(), context, color: Colors.red);
    }
  }

  void setBiller(SMEDataBillers val, BuildContext context) async {
    package = val;
    amountController.text = val.price ?? "100";
    print(amountController.text);
    notifyListeners();
  }

  void setPackage(SMEDataBillers val, BuildContext context) {
    package = val;
    amountController.text = val.price ?? "100";
    smeDataName = val.description;
    notifyListeners();
  }

  void setBeneficiary(DataBeneficiary dataBeneficiary) {
    phoneController.text = dataBeneficiary.phoneNumber!;
    notifyListeners();
  }

  Future purchaseData(context) async {
    LoaderDialog.showLoadingDialog(context, message: "Purchasing Data...");

    Map<String, dynamic> payload = {
      'mobile': phoneController.text,
      'service': package!.code,
      'amount': amountController.text
    };

    try {
      final response = await dio().post('/sme-data/purchase', data: payload);

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
          flusher(json['message'] ?? 'Error Fetching data', context, color: Colors.red);
        }
      } else {
        _dialogService.completeDialog(DialogResponse());
        flusher(json['message'] ?? 'Error Fetching data', context, color: Colors.red);
      }
    } on DioError catch (e) {
      errorFetching = true;
      print(e.response!.data);
      _dialogService.completeDialog(DialogResponse());
      flusher(DioExceptions.fromDioError(e).toString(), context, color: Colors.red);
    }
  }

  @override
  // TODO: implement reactiveServices
  List<ReactiveServiceMixin> get reactiveServices => [];
}
