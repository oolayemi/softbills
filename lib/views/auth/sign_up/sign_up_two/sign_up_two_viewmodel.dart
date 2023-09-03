import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../app/locator.dart';
import '../sign_up_three/sign_up_three_view.dart';

class SignUpTwoViewModel extends ReactiveViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  TextEditingController passwordController = TextEditingController();
  bool obscurePassword = true;
  bool isPasswordValid = false;

  void toggleObscurePassword() {
    obscurePassword = !obscurePassword;
    notifyListeners();
  }

  Map<String, dynamic> details = {};
  final formKey = GlobalKey<FormState>();

  void setUp(Map<String, dynamic> detail) {
    setDetails(detail);
  }

  void setDetails(Map<String, dynamic> detail) {
    details = detail;
    notifyListeners();
  }

  void setPassword(String password) {
    details['password'] = password;
  }

  void gotoSignUpThree() {
    _navigationService.navigateToView(SignUpThreeView(details: details));
  }

  @override
  // TODO: implement reactiveServices
  List<ReactiveServiceMixin> get reactiveServices => [];
}
