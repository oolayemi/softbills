import 'package:flutter/material.dart';
import 'package:no_name/app/locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../otp_verification/email_otp_verification_view.dart';

class ValidateEmailViewModel extends ReactiveViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  TextEditingController emailController = TextEditingController();
  String? phone;

  final formKey = GlobalKey<FormState>();


  void gotoEmailOtpView() {
    _navigationService.navigateToView(EmailOtpVerificationView(email: emailController.text));
  }

  @override
  // TODO: implement reactiveServices
  List<ReactiveServiceMixin> get reactiveServices => [];
}
