import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:no_name/app/locator.dart';
import 'package:no_name/core/services/auth_service.dart';
import 'package:no_name/views/services/transfer_funds_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../core/constants/loading_dialog.dart';
import '../../core/exceptions/error_handling.dart';
import '../../core/models/airtime_data_model.dart';
import '../../core/models/currency_rates.dart';
import '../../core/models/data_beneficiaries.dart';
import '../../core/models/data_billers.dart';
import '../../core/models/wallet_response.dart';
import '../../core/utils/tools.dart';
import '../../widgets/utility_widgets.dart';
import '../transaction_successful/transaction_successful_view.dart';

class DataViewModel extends ReactiveViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthService _authService = locator<AuthService>();
  final DialogService _dialogService = locator<DialogService>();
  final TransferFundsService _transferFundsService = locator<TransferFundsService>();

  List<DataBeneficiary>? get dataBeneficiaries => _authService.dataBeneficiaries;

  final formKey = GlobalKey<FormState>();

  WalletData? get wallet => _authService.walletResponse;

  List<AirTimeDataModel> get data => AirTimeDataModel.data;
  AirTimeDataModel? selected;

  List<DataBillers>? tempBillers = [];

  List<DataBillers> get billers => _transferFundsService.dataBillers;
  DataBillers? selectedBiller;

  List<Plans>? plans;
  Plans? selectedPlan;

  bool fetched = false;
  bool errorFetching = false;

  List<Rates>? get rateList => _authService.ratesList;

  Rates? selectedRate;
  String? buildText;


  TextEditingController phoneController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  Future getBillers(context) async {

    try {
      final response = await dio().get('/data/providers');

      int? statusCode = response.statusCode;

      String? success = jsonDecode(response.toString())['status'];
      Map<String, dynamic> json = jsonDecode(response.toString());

      if (statusCode == 200) {
        if (success == 'success') {
          DataBillersData temp = DataBillersData.fromJson(json);
          tempBillers = temp.data;
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
    } on DioError catch (e) {
      errorFetching = true;
      flusher(DioExceptions.fromDioError(e).toString(), context, color: Colors.red);
    }
  }

  Future getPlans(context, DataBillers biller) async {

    try {

      final response = await dio().get('/data/${biller.serviceID}/bundles');

      int? statusCode = response.statusCode;

      Map<String, dynamic> json = jsonDecode(response.toString());

      if (statusCode == 200) {
          PlanResponse temp = PlanResponse.fromJson(json);
          fetched = true;
          errorFetching = false;
          _transferFundsService.setDataBillers(biller..plans = temp.data);
          notifyListeners();
      } else {
        flusher(json['message'] ?? 'Error Fetching data', context, color: Colors.red);
        errorFetching = true;
        fetched = false;
      }
    } on DioError catch (e) {
      errorFetching = true;
      print(e.response);
      flusher(DioExceptions.fromDioError(e).toString(), context, color: Colors.red);
    }
  }

  Future setup(context) async {
    // data = [];
    errorFetching = false;
    notifyListeners();

    if (billers.isEmpty) {
      await getBillers(context);
      // print('loadOperators::::: ');
    }
    if (billers.isEmpty) {
      for (DataBillers item in tempBillers!) {
        if (!errorFetching) {
          await getPlans(context, item);
        }
      }
    } else {
      fetched = true;
    }
    if (!errorFetching && fetched) {
      setProvider(data[0]);
      setDataBiller(billers[0]);
    }
    notifyListeners();
  }

  void setProvider(AirTimeDataModel val) {
    selected = val;
    notifyListeners();
  }

  void setDataBiller(DataBillers val) {
    selectedBiller = val;
    plans = val.plans;
    selectedPlan = null;
    amountController.text = '';
    notifyListeners();
  }

  Future purchaseData(context) async {
    LoaderDialog.showLoadingDialog(context, message: "Purchasing Data...");

    Map<String, dynamic> payload = {
      'phone': phoneController.text,
      'amount': selectedPlan!.variationAmount,
      'service_id': selectedBiller!.serviceID,
      'variation_code': selectedPlan!.variationCode,
    };

    print(payload);

    try {
      final response = await dio().post('/data/purchase', data: payload);

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
    } on DioError catch (e) {
      _dialogService.completeDialog(DialogResponse());
      print(e.response);
      flusher(DioExceptions.fromDioError(e).toString(), context, color: Colors.red);
    }
  }

  Future<void> saveDataBeneficiary(context) async {
    var data = {"phone_number": phoneController.text, "operator": selectedBiller!.name!.toLowerCase(), "nickname": ""};
    try {
      var response = await dio().post('/data/beneficiaries/add', data: data);

      int? statusCode = response.statusCode;
      String? success = jsonDecode(response.toString())['status'];

      if (statusCode == 200 && success == 'success') {
        Fluttertoast.showToast(msg: "Beneficiary saved successfully");
        await _authService.getDataBeneficiaries();
      } else {
        Fluttertoast.showToast(msg: "An error occurred");
      }
    } on DioError catch (e) {
      print(e.response);
      Fluttertoast.showToast(msg: DioExceptions.fromDioError(e).message);
    }
  }

  void setBeneficiary(DataBeneficiary dataBeneficiary) {
    phoneController.text = dataBeneficiary.phoneNumber!;
    selectedBiller = billers.firstWhere((element) => element.name!.toLowerCase() == dataBeneficiary.operator);
    notifyListeners();
  }
  
  @override
  // TODO: implement reactiveServices
  List<ReactiveServiceMixin> get reactiveServices => [_authService, _transferFundsService];

  void setPlan(Plans val) {
    selectedPlan = val;
    amountController.text = val.variationAmount.toString();
    notifyListeners();
  }

}