import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:no_name/app/locator.dart';
import 'package:no_name/views/auth/sign_in/sign_in_view.dart';
import 'package:no_name/views/auth/sign_up/otp_verification/verification_complete.dart';
import 'package:no_name/views/auth/sign_up/user_info/user_info_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../core/constants/loading_dialog.dart';
import '../../../../core/exceptions/error_handling.dart';
import '../../../../core/utils/tools.dart';
import '../../../../widgets/utility_widgets.dart';

class CreatePasswordViewModel extends ReactiveViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final DialogService _dialogService = locator<DialogService>();

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

  Future<void> changePassword(context) async {
    LoaderDialog.showLoadingDialog(context, message: "Verifying otp...");
    try {
      var data = {
        'value': details!['value'],
        'new_password': passwordController.text,
        'new_password_confirmation': passwordController.text,
      };
      var response = await dio(withToken: false).post('/forgot-password/reset', data: data);
      Map<String, dynamic> responseData = response.data;

      _dialogService.completeDialog(DialogResponse());
      NavigationService().clearStackAndShowView(const SignInView());
      _navigationService.navigateToView(VerificationComplete(
        title: "Password created",
        description: "Your password has been created",
        buttonText: "Back to Login",
        onTap: () => NavigationService().clearStackAndShowView(const SignInView()),
      ));
    } on DioException catch (e) {
      _dialogService.completeDialog(DialogResponse());
      flusher(DioExceptions.fromDioError(e).toString(), context, color: Colors.red);
    }
  }

  void gotoVerificationCompleteView() {
    details!['password'] = passwordController.text;
    _navigationService.back();
    _navigationService.navigateToView(VerificationComplete(
      title: "Password created",
      description: "Your password has been created",
      buttonText: from == "reset" ? "Back to Login" : null,
      onTap: () =>
          NavigationService().navigateToView(from == "new" ? UserInfoView(details: details ?? {}) : const SignInView()),
    ));
  }

  @override
  // TODO: implement reactiveServices
  List<ReactiveServiceMixin> get reactiveServices => [];
}
