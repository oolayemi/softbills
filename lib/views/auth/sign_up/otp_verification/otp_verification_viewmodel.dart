import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:no_name/app/locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:timer_count_down/timer_controller.dart';

import '../../../../core/constants/loading_dialog.dart';
import '../../../../core/exceptions/error_handling.dart';
import '../../../../core/utils/tools.dart';
import '../../../../widgets/utility_widgets.dart';
import '../create_password/create_password_view.dart';
import '../validate_email/validate_email_view.dart';
import 'verification_complete.dart';

class OtpVerificationViewModel extends ReactiveViewModel {
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();

  final TextEditingController otpController = TextEditingController();
  late String? value;
  Map<String, dynamic> details = {};
  bool isResendCodeEnable = false;

  late CountdownController countdownController;

  void setUp(String? value, Map<String, dynamic> details){
    countdownController = CountdownController(autoStart: true);
    this.value = value;
    this.details = details;

    print(details);
  }

  void enableResendCode(bool value) {
    isResendCodeEnable = value;
    notifyListeners();
  }

  var formKey = GlobalKey<FormState>();

  Future<void> verifyPhone(context) async {
    LoaderDialog.showLoadingDialog(context, message: "Validating otp...");

    Map<String, dynamic> payload = {
      'otp': otpController.text,
      'phone': value
    };

    try {
      final response = await dio().post('/auth/register/phone/verify', data: payload);
      Map<String, dynamic> json = jsonDecode(response.toString());

      _dialogService.completeDialog(DialogResponse());
      _navigationService.back();
      _navigationService.navigateToView(VerificationComplete(
        title: "Verification complete",
        description: "Your phone number has been verified",
        onTap: () {
          _navigationService.back();
          _navigationService.navigateToView(ValidateEmailView(details: details));
        },
      ));

    } on DioException catch (e) {
      _dialogService.completeDialog(DialogResponse());
      print(e.response);
      toast(DioExceptions.fromDioError(e).toString(), color: Colors.red);
    }
  }

  Future<void> verifyEmail(context) async {
    LoaderDialog.showLoadingDialog(context, message: "Validating otp...");

    Map<String, dynamic> payload = {
      'otp': otpController.text,
      'email': value
    };

    try {
      final response = await dio().post('/auth/register/email/verify', data: payload);
      Map<String, dynamic> json = jsonDecode(response.toString());

      _dialogService.completeDialog(DialogResponse());
      _navigationService.back();
      _navigationService.navigateToView(VerificationComplete(
        title: "Email verified",
        description: "Your email address has been verified successfully",
        onTap: () {
          _navigationService.back();
          NavigationService().navigateToView(CreatePasswordView(details: details));
        },
      ));

    } on DioException catch (e) {
      _dialogService.completeDialog(DialogResponse());
      print(e.response);
      toast(DioExceptions.fromDioError(e).toString(), color: Colors.red);
    }
  }

  void resendOtp(){
    countdownController.restart();
    otpController.clear();
  }
}