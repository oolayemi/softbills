import 'package:flutter/material.dart';
import 'package:no_name/app/locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../sign_up_two/sign_up_two_view.dart';

class SignUpOneViewModel extends ReactiveViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  String? gender;
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  String? phone;

  final formKey = GlobalKey<FormState>();

  void setGender(String? val) {
    gender = val;
    notifyListeners();
  }

  void setPhoneNumber(String phone) {
    this.phone = phone;
    notifyListeners();
  }

  void gotoSignUpTwo() {
    var map = {
      'firstname': firstnameController.text,
      'lastname': lastnameController.text,
      'email': emailController.text,
      'gender': gender!,
      'phone': phone!
    };
    _navigationService.navigateToView(SignUpTwoView(details: map));
  }

  @override
  // TODO: implement reactiveServices
  List<ReactiveServiceMixin> get reactiveServices => [];
}
