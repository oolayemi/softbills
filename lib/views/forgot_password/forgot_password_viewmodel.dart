import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:no_name/app/locator.dart';
import 'package:no_name/widgets/utility_widgets.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:timer_count_down/timer_controller.dart';

import '../../core/constants/loading_dialog.dart';
import '../../core/exceptions/error_handling.dart';
import '../../core/utils/tools.dart';
import '../auth/sign_up/create_password/create_password_view.dart';
import 'fp_otp_verification_view.dart';

class ForgotPasswordViewModel extends ReactiveViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final DialogService _dialogService = locator<DialogService>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  CountdownController countdownController = CountdownController(autoStart: true);
  bool isResendCodeEnable = false;

  void enableResendCode(bool value) {
    isResendCodeEnable = value;
    notifyListeners();
  }

  Future<void> requestPasswordReset(context) async {
    LoaderDialog.showLoadingDialog(context, message: "Request password reset...");
    try {
      var data = {'value': emailController.text};
      var response = await dio(withToken: false).post('/forgot-password/request', data: data);
      Map<String, dynamic> responseData = response.data;

      _dialogService.completeDialog(DialogResponse());
      _navigationService.navigateToView(FPOtpVerificationView(email: emailController.text));
      flusher(responseData['message'], context);
    } on DioException catch (e) {
      _dialogService.completeDialog(DialogResponse());
      flusher(DioExceptions.fromDioError(e).toString(), context, color: Colors.red);
    }
  }

  Future<void> resendRequest(context, String email) async {
    LoaderDialog.showLoadingDialog(context, message: "Request password reset...");
    try {
      var data = {'value': email};
      var response = await dio(withToken: false).post('/forgot-password/request', data: data);
      Map<String, dynamic> responseData = response.data;
      enableResendCode(false);
      countdownController.restart();
      otpController.clear();
      _dialogService.completeDialog(DialogResponse());
      flusher(responseData['message'], context);
    } on DioException catch (e) {
      _dialogService.completeDialog(DialogResponse());
      flusher(DioExceptions.fromDioError(e).toString(), context, color: Colors.red);
    }
  }

  Future<void> verifyOtp(context, String value) async {
    LoaderDialog.showLoadingDialog(context, message: "Verifying otp...");
    try {
      var data = {'value': value, 'otp': otpController.text};
      var response = await dio(withToken: false).post('/forgot-password/verify-otp', data: data);
      Map<String, dynamic> responseData = response.data;

      _dialogService.completeDialog(DialogResponse());
      _navigationService.navigateToView(CreatePasswordView(from: "reset", details: {'value': value}));
      flusher(responseData['message'], context);
    } on DioException catch (e) {
      _dialogService.completeDialog(DialogResponse());
      flusher(DioExceptions.fromDioError(e).toString(), context, color: Colors.red);
    }
  }
}
