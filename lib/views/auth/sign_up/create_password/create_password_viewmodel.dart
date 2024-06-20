import 'package:flutter/material.dart';
import 'package:no_name/app/locator.dart';
import 'package:no_name/views/auth/sign_in/sign_in_view.dart';
import 'package:no_name/views/auth/sign_up/otp_verification/verification_complete.dart';
import 'package:no_name/views/auth/sign_up/user_info/user_info_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class CreatePasswordViewModel extends ReactiveViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  TextEditingController passwordController = TextEditingController();
  bool obscurePassword = true;
  bool isPasswordValid = false;

  void toggleObscurePassword() {
    obscurePassword = !obscurePassword;
    notifyListeners();
  }

  final formKey = GlobalKey<FormState>();
  String? from;
  Map<String, dynamic>? details;

  void setUp(String from, Map<String, dynamic>? details) {
    this.from = from;
    this.details = details;

    print(details);
  }

  void gotoVerificationCompleteView() {
    _navigationService.navigateToView(VerificationComplete(
      title: "Password created",
      description: "Your password has been created",
      buttonText: from == "reset" ? "Back to Login" : null,
      onTap: () => NavigationService().navigateToView(
        from == "new"
            ? UserInfoView(details: details ?? {})
            : const SignInView()),
    ));
  }

  @override
  // TODO: implement reactiveServices
  List<ReactiveServiceMixin> get reactiveServices => [];
}
