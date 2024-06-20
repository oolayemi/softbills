import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:no_name/app/locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../core/constants/loading_dialog.dart';
import '../../../../core/exceptions/error_handling.dart';
import '../../../../core/utils/tools.dart';
import '../../../../widgets/utility_widgets.dart';
import '../otp_verification/email_otp_verification_view.dart';

class ValidateEmailViewModel extends ReactiveViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final DialogService _dialogService = locator<DialogService>();
  TextEditingController emailController = TextEditingController();
  Map<String, dynamic> details = {};

  final formKey = GlobalKey<FormState>();

  setUp(Map<String, dynamic> details){
    this.details = details;
  }


  Future<void> validateEmail(context) async {
    LoaderDialog.showLoadingDialog(context, message: "Validating email...");

    Map<String, dynamic> payload = {
      'email': emailController.text
    };

    try {
      final response = await dio().post('/auth/register/email/validate', data: payload);
      Map<String, dynamic> json = jsonDecode(response.toString());

      details['email'] = emailController.text;

      _dialogService.completeDialog(DialogResponse());
      _navigationService.navigateToView(EmailOtpVerificationView(email: emailController.text, details: details));

    } on DioException catch (e) {
      _dialogService.completeDialog(DialogResponse());
      print(e.response);
      toast(DioExceptions.fromDioError(e).toString(), color: Colors.red);
    }
  }

  @override
  // TODO: implement reactiveServices
  List<ReactiveServiceMixin> get reactiveServices => [];
}
