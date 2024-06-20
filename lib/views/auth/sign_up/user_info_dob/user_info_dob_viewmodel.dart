import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../app/locator.dart';
import '../otp_verification/verification_complete.dart';
import '../sign_up_three/sign_up_three_view.dart';

class UserInfoDobViewModel extends ReactiveViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final TextEditingController datetimeController = TextEditingController();
  DateTime? chosenDate;
  DateFormat dateFormat = DateFormat('dd/MM/yyy');

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

  void gotoSignUpThree() {
    _navigationService.navigateToView(SignUpThreeView(details: details));
  }

  Future<void> chooseDate(context) async {
    chosenDate = await selectDate(
      context,
      initialDate: chosenDate ?? DateTime(DateTime.now().year - 5),
      startDate: DateTime(1950),
      lastDate: DateTime(DateTime.now().year - 5)

    );
    if (chosenDate != null) {
      datetimeController.text = dateFormat.format(chosenDate!);
    } else {
      datetimeController.clear();
    }
    notifyListeners();
  }

  Future<DateTime?> selectDate(BuildContext context, {DateTime? initialDate, DateTime? startDate, DateTime? lastDate}) async {
    return await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: startDate ?? DateTime.now(),
      lastDate: lastDate ?? DateTime.now(),
    );
  }

  Future<void> createAccount() async {
    details['dob'] = chosenDate.toString();
    print(details);
    NavigationService().navigateToView(
      VerificationComplete(
        title: "All done!",
        description:
        "Your account has been created. You're now ready to explore and enjoy all the features and benefits we have to offer.",
        buttonText: "Start exploring App",
        imageUrl: "assets/images/Design 1.png",
        onTap: () {},
      ),
    );
  }
}
