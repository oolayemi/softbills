import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:no_name/app/locator.dart';
import 'package:no_name/views/auth/sign_up/otp_verification/sms_otp_verification_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../core/constants/loading_dialog.dart';
import '../../../../core/exceptions/error_handling.dart';
import '../../../../core/utils/tools.dart';
import '../../../../widgets/utility_widgets.dart';

class ValidatePhoneViewModel extends ReactiveViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final DialogService _dialogService = locator<DialogService>();

  String? phone;

  final formKey = GlobalKey<FormState>();

  void setPhoneNumber(String phone) {
    this.phone = phone;
    notifyListeners();
  }

  Future<void> validatePhone(context) async {
    LoaderDialog.showLoadingDialog(context, message: "Validating phone...");
    String phoneNumber = phone!.replaceAll(' ', '');

    Map<String, dynamic> payload = {
      'phone': "0${phoneNumber.substring(phoneNumber.length - 10, phoneNumber.length)}"
    };

    try {
      final response = await dio().post('/auth/register/phone/validate', data: payload);
      Map<String, dynamic> json = jsonDecode(response.toString());

      _dialogService.completeDialog(DialogResponse());
      _navigationService.navigateToView(SmsOtpVerificationView(phone: phone!, details: payload));

    } on DioException catch (e) {
      _dialogService.completeDialog(DialogResponse());
      print(e.response);
      toast(DioExceptions.fromDioError(e).toString(), color: Colors.red);
    }
  }

}
