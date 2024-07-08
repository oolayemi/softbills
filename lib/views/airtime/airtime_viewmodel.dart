import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:no_name/app/locator.dart';
import 'package:no_name/core/models/airtime_beneficiaries.dart';
import 'package:no_name/core/models/airtime_billers.dart';
import 'package:no_name/core/services/auth_service.dart';
import 'package:no_name/views/services/transfer_funds_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../core/constants/loading_dialog.dart';
import '../../core/exceptions/error_handling.dart';
import '../../core/models/airtime_data_model.dart';
import '../../core/models/currency_rates.dart';
import '../../core/models/wallet_response.dart';
import '../../core/utils/tools.dart';
import '../../widgets/utility_widgets.dart';
import '../transaction_successful/transaction_successful_view.dart';

class AirtimeViewModel extends ReactiveViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthService _authService = locator<AuthService>();
  final DialogService _dialogService = locator<DialogService>();
  final TransferFundsService _transferFundsService = locator<TransferFundsService>();

  final formKey = GlobalKey<FormState>();

  int selectedAmount = 0;

  List<AirTimeDataModel> get data => AirTimeDataModel.data;
  AirTimeDataModel? selected;

  List<AirtimeBeneficiary>? get airtimeBeneficiaries => _authService.airtimeBeneficiaries;

  WalletData? get wallet => _authService.walletResponse;

  List<AirtimeBillers> tempBillers = [];

  bool fetched = false;
  bool errorFetching = false;

  List<AirtimePlans>? plans;
  AirtimePlans? selectedPlan;

  List<AirtimeBillers> get billers => _transferFundsService.airtimeBillers;
  AirtimeBillers? selectedBiller;

  TextEditingController phoneController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  List<Rates>? get rateList => _authService.ratesList;

  Rates? selectedRate;
  String? buildText;

  void changeSelectAmount(int page, int? value){
    selectedAmount = page;
    if(page != 0){
      amountController.text = "$value";
    }
    notifyListeners();
  }

  Future setup(BuildContext context) async {
    errorFetching = false;

    notifyListeners();
    if (billers.isEmpty) {
      await getBillers(context);
      // print('loadOperators::::: ');
    }
    if (!errorFetching && fetched) {
      setProvider(data[0]);
      setAirtimeBiller(billers[0]);
    }
    notifyListeners();
  }

  void setProvider(AirTimeDataModel val) {
    selected = val;
    notifyListeners();
  }

  void setAirtimeBiller(AirtimeBillers val) {
    selectedBiller = val;
    plans = val.plans;
    selectedPlan = null;
    // amountController.text = '';
    notifyListeners();
  }

  Future getBillers(context) async {
    try {
      final response = await dio().get('/airtime/providers');

      int? statusCode = response.statusCode;

      String? success = jsonDecode(response.toString())['status'];
      Map<String, dynamic> json = jsonDecode(response.toString());

      if (statusCode == 200) {
        if (success == 'success') {
          AirtimeBillersData temp = AirtimeBillersData.fromJson(json);
          tempBillers = temp.data ?? [];
          _transferFundsService.setAirtimeBillers(temp.data!);
          // fetched = true;
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
    } on DioException catch (e) {
      errorFetching = true;
      print(e.response);
      flusher(DioExceptions.fromDioError(e).toString(), context, color: Colors.red);
    }
  }

  Future purchaseAirtime(context) async {
    LoaderDialog.showLoadingDialog(context, message: "Purchasing Airtime...");

    Map<String, dynamic> payload = {
      'amount': amountController.text,
      'phone': phoneController.text,
      'service_id': selectedBiller!.serviceID,
    };

    try {
      final response = await dio().post('/airtime/purchase', data: payload);

      int? statusCode = response.statusCode;
      String? success = jsonDecode(response.toString())['status'];

      Map<String, dynamic> json = jsonDecode(response.toString());

      if (statusCode == 200) {
        if (success == 'success') {
          await _authService.getWalletDetails();
          await _authService.getWalletTransactions(page: 1);
          notifyListeners();
          _dialogService.completeDialog(DialogResponse());
          _navigationService.popRepeated(2);
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

  Future<void> saveAirtimeBeneficiary(context) async {
    var data = {"phone_number": phoneController.text, "operator": selectedBiller!.name!.toLowerCase(), "nickname": ""};
    try {
      var response = await dio().post('/airtime/beneficiaries/add', data: data);

      int? statusCode = response.statusCode;
      String? success = jsonDecode(response.toString())['status'];

      if (statusCode == 200 && success == 'success') {
        Fluttertoast.showToast(msg: "Beneficiary saved successfully");
        await _authService.getAirtimeBeneficiaries();
      } else {
        Fluttertoast.showToast(msg: "An error occurred");
      }
    } on DioException catch (e) {
      print(e.response);
      Fluttertoast.showToast(msg: DioExceptions.fromDioError(e).message);
    }
  }

  void setBeneficiary(AirtimeBeneficiary airtimeBeneficiary) {
    phoneController.text = airtimeBeneficiary.phoneNumber!;
    selectedBiller = billers.firstWhere((element) => element.name!.toLowerCase() == airtimeBeneficiary.operator);
    notifyListeners();
  }
}