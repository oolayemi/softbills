import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:no_name/core/services/auth_service.dart';
import 'package:no_name/core/services/utility_storage_service.dart';
import 'package:no_name/core/utils/tools.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../app/locator.dart';
import '../../../../core/constants/loading_dialog.dart';
import '../../../../core/exceptions/error_handling.dart';
import '../../../../widgets/utility_widgets.dart';
import '../otp_verification/sms_otp_verification_view.dart';

class SignUpThreeViewModel extends ReactiveViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthService _authService = locator<AuthService>();
  final StorageService _storageService = locator<StorageService>();
  final DialogService _dialogService = locator<DialogService>();

  final formKey = GlobalKey<FormState>();

  TextEditingController pinController = TextEditingController();

  Map<String, dynamic> details = {};

  void setUp(Map<String, dynamic> detail) {
    setDetails(detail);
  }

  void setDetails(Map<String, dynamic> detail) {
    details = detail;
    notifyListeners();
  }

  Future<void> getDetails() async {
    await _authService.getProfile();
    await _authService.getNextOfKin();
    await _authService.getWalletDetails();
    await _authService.getVirtualAccounts();
    await _authService.getAirtimeBeneficiaries();
    await _authService.getDataBeneficiaries();
    await _authService.getWalletTransactions(page: 1);
    //save pin, then otp verification
    _navigationService.clearStackAndShowView(SmsOtpVerificationView(phone: details['phone'], details: details));
  }

  Future<void> signUp(context) async {
    LoaderDialog.showLoadingDialog(context, message: "Signing up...");
    try {

      var deviceId = getRandomString(12);
      details['device_id'] = deviceId;
      details['phone'] = "0${details['phone'].substring(details['phone'].length - 10, details['phone']!.length)}";
      details['transaction_pin'] = pinController.text;
      
      var response = await dio(withToken: false).post('/auth/register', data: details);

      int? statusCode = response.statusCode;
      Map responseData = response.data!;

      print(responseData);

      if (statusCode == 200) {
        Map jsonData = jsonDecode(response.toString());
        if (responseData['status'] == 'success') {
          _storageService.addString("token", jsonData['data']['token']);
          _storageService.addString('email', details['email']);
          _storageService.addBool('isLoggedIn', true);
          await _authService.getDetails();

        } else {
          _dialogService.completeDialog(DialogResponse());
          flusher(json.decode(response.toString())['message'], context, color: Colors.red);
        }
      } else {
        _dialogService.completeDialog(DialogResponse());
        flusher(json.decode(response.toString())['message'], context, color: Colors.red);
      }

    } on DioException catch (e) {
      _dialogService.completeDialog(DialogResponse());
      print(e.response);
      flusher('Request error: ${DioExceptions.fromDioError(e).toString()}', context, color: Colors.red);
    }
  }

  @override
  // TODO: implement reactiveServices
  List<ReactiveServiceMixin> get reactiveServices => [_authService];
}
