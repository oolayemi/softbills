import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../app/locator.dart';
import '../sign_up_three/sign_up_three_view.dart';
import '../user_info_dob/user_info_dob_view.dart';

class UserInfoViewModel extends ReactiveViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  String? gender;

  setGender(value) {
    gender = value;
    notifyListeners();
  }

  Map<String, dynamic> details = {};
  final formKey = GlobalKey<FormState>();

  void setUp(Map<String, dynamic> detail) {
    setDetails(detail);
  }

  void setDetails(Map<String, dynamic> detail) {
    details = detail;
    print(details);
    notifyListeners();
  }

  void setPassword(String password) {
    details['password'] = password;
  }

  void goToDobPage() {
    details['firstname'] = firstNameController.text;
    details['lastname'] = lastNameController.text;
    details['gender'] = gender;

    _navigationService.navigateToView(UserInfoDobView(details: details));
  }
}
