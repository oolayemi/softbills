import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:no_name/app/locator.dart';
import 'package:no_name/core/services/auth_service.dart';
import 'package:no_name/views/services/transfer_funds_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../core/constants/loading_dialog.dart';
import '../../core/enums/wallet_types.dart';
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

  List<Wallet>? get walletTypes => _authService.walletResponse;

  Wallet? selectedWallet;

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
          tempBillers = temp.billers;
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

      final response = await dio().get('/data/${biller.type}/bundles');

      int? statusCode = response.statusCode;

      String? success = jsonDecode(response.toString())['status'];
      Map<String, dynamic> json = jsonDecode(response.toString());

      if (statusCode == 200) {
        if (success == 'success') {
          PlanResponse temp = PlanResponse.fromJson(json);
          fetched = true;
          errorFetching = false;
          _transferFundsService.setDataBillers(biller..plans = temp.plans);
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
      print(e.response);
      flusher(DioExceptions.fromDioError(e).toString(), context, color: Colors.red);
    }
  }

  Future setup(context) async {

    selectedWallet = walletTypes!.first;
    // data = [];
    errorFetching = false;
    getExchange();
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

  void getExchange() {
    String fromValue = selectedWallet!.walletType!.toLowerCase();
    String toValue = 'NAIRA'.toLowerCase();
    selectedRate = rateList?.where((element) => element.currencyFrom == fromValue).where((element) => element.currencyTo == toValue).first;

    if (selectedRate != null){
      buildText = (amountController.text.isNotEmpty && fromValue != toValue) ? "${amountController.text}${matchCurrency(toValue)} = ${(int.parse(amountController.text) / selectedRate!.rate!).toStringAsFixed(2)}${matchCurrency(fromValue)}" : null;
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
      'mobile': phoneController.text,
      'amount': selectedPlan!.amount,
      'operator': selectedBiller!.name!.toLowerCase(),
      'bundle': selectedPlan!.code.toString(),
      'wallet_source': selectedWallet!.walletType!
    };

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
            TransactionSuccessfulView(
              bottomWidgets: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 85,
                        width: 85,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: const Color(0xFF605F5F).withOpacity(.5),
                        ),
                        child: const Center(
                            child: Icon(
                              Icons.schedule_rounded,
                              size: 40,
                            )),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Schedule Data",
                        style: TextStyle(fontSize: 15),
                      )
                    ],
                  ),
                  const SizedBox(width: 80),
                  InkWell(
                    onTap: () => saveDataBeneficiary(context),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: 85,
                          width: 85,
                          decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(15), color: const Color(0xFF605F5F).withOpacity(.5)),
                          child: const Center(
                              child: Icon(
                                Icons.save_as,
                                size: 40,
                              )),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Save Beneficiary",
                          style: TextStyle(fontSize: 15),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
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
    amountController.text = val.amount.toString();
    getExchange();
    notifyListeners();
  }

}