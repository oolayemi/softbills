import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:no_name/app/locator.dart';
import 'package:no_name/core/models/bank_data.dart';
import 'package:no_name/core/services/auth_service.dart';
import 'package:no_name/views/services/transfer_funds_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../core/constants/loading_dialog.dart';
import '../../core/exceptions/error_handling.dart';
import '../../core/models/currency_rates.dart';
import '../../core/models/wallet_response.dart';
import '../../core/utils/tools.dart';
import '../../widgets/utility_widgets.dart';
import '../transaction_successful/transaction_successful_view.dart';

class TransferViewModel extends ReactiveViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthService _authService = locator<AuthService>();
  final DialogService _dialogService = locator<DialogService>();
  final TransferFundsService _transferFundsService = locator<TransferFundsService>();

  final formKey = GlobalKey<FormState>();
  bool loadingName = false;
  bool verified = false;

  int selectedAmount = 0;
  String? accountName;


  WalletData? get wallet => _authService.walletResponse;

  bool fetched = false;
  bool errorFetching = false;

  List<Bank> get banks => _transferFundsService.banks ?? [];
  Bank? selectedBank;

  TextEditingController accountNumberController = TextEditingController();
  TextEditingController narrationController = TextEditingController();

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

  void resetName() {
    accountName = null;
    verified = false;
    notifyListeners();
  }

  void setLoading(bool val) {
    loadingName = val;
    notifyListeners();
  }

  Future setup(BuildContext context) async {
    errorFetching = false;

    notifyListeners();
    if (banks.isEmpty) {
      await getBanks(context);
      // print('loadOperators::::: ');
    }
    if (!errorFetching && fetched) {
      setBank(banks[0]);
    }
    notifyListeners();
  }

  void setBank(Bank val) {
    selectedBank = val;
    notifyListeners();
  }

  Future getBanks(context) async {
    try {
      final response = await dio().get('/wallet/bank-list');

      int? statusCode = response.statusCode;

      String? success = jsonDecode(response.toString())['status'];
      Map<String, dynamic> json = response.data;

      log(jsonEncode(json));

      if (statusCode == 200) {
        if (success == 'success') {
          BankListResponse temp = BankListResponse.fromJson(json);
          _transferFundsService.setBankList(temp.data);
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
      'account_number': accountNumberController.text,
      'bank_code': selectedBank?.cbnCode
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

  Future validateName(context) async {
    if (accountNumberController.text.length == 10) {
      LoaderDialog.showLoadingDialog(context,
          message: "Verifying account number...");
      setLoading(true);

      Map<String, dynamic> payload = {
        'bank_code': selectedBank!.cbnCode,
        'account_number': accountNumberController.text
      };

      try {
        final response = await dio().post('/wallet/name-enquiry', data: payload);

        int? statusCode = response.statusCode;

        Map<String, dynamic> json = jsonDecode(response.toString());
        String? success = json['status'];

        if (statusCode == 200) {
          if (success == 'success') {
            accountName = json['data']['accountName'];

            setLoading(false);
            _dialogService.completeDialog(DialogResponse());
            verified = true;
            notifyListeners();
          } else {
            setLoading(false);
            resetName();
            _dialogService.completeDialog(DialogResponse());
            flusher(json['message'] ?? 'Error Fetching data', context,
                color: Colors.red);
          }
        } else {
          setLoading(false);
          resetName();
          _dialogService.completeDialog(DialogResponse());
          flusher(json['message'] ?? 'Error Fetching data', context,
              color: Colors.red);
        }
      } on DioException catch (e) {
        setLoading(false);
        resetName();
        _dialogService.completeDialog(DialogResponse());
        flusher(DioExceptions.fromDioError(e).toString(), context,
            color: Colors.red);
      }
    } else {
      toast("Please check the account number");
    }
  }
}