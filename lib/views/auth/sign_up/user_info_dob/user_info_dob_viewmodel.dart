import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:no_name/core/services/auth_service.dart';
import 'package:no_name/core/services/utility_storage_service.dart';
import 'package:no_name/views/dashboard/dashboard_view.dart';
import 'package:no_name/widgets/utility_widgets.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../app/locator.dart';
import '../../../../core/constants/loading_dialog.dart';
import '../../../../core/exceptions/error_handling.dart';
import '../../../../core/utils/tools.dart';
import '../otp_verification/verification_complete.dart';
import '../sign_up_three/sign_up_three_view.dart';

class UserInfoDobViewModel extends ReactiveViewModel {
  final AuthService _authService = locator<AuthService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final StorageService _storageService = locator<StorageService>();
  final DialogService _dialogService = locator<DialogService>();

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

  Future<void> signUp(context) async {
    LoaderDialog.showLoadingDialog(context, message: "Signing up...");
    try {

      var deviceId = getRandomString(12);
      details['device_id'] = deviceId;
      details['date_of_birth'] = chosenDate.toString();

      var response = await dio(withToken: false).post('/auth/register', data: details);

      int? statusCode = response.statusCode;
      Map responseData = response.data!;

      print(responseData);

      if (statusCode == 200) {
        Map jsonData = jsonDecode(response.toString());
        if (responseData['status'] == 'success') {
          _storageService.addString("token", jsonData['data']['token']);
          _storageService.addString('email', details['email']);
          _storageService.addBool('isLoggedIn', true);
          await _authService.getDetails();

          _navigationService.clearStackAndShowView(
            VerificationComplete(
              title: "All done!",
              description:
              "Your account has been created. You're now ready to explore and enjoy all the features and benefits we have to offer.",
              buttonText: "Start exploring App",
              imageUrl: "assets/images/Design 1.png",
              onTap: () {
                NavigationService().clearStackAndShowView(const DashboardView());
              },
            ),
          );

        } else {
          _dialogService.completeDialog(DialogResponse());
          toast(json.decode(response.toString())['message'], color: Colors.red, seconds: 3);
        }
      } else {
        _dialogService.completeDialog(DialogResponse());
        flusher(json.decode(response.toString())['message'], context, color: Colors.red);
      }

    } on DioException catch (e) {
      _dialogService.completeDialog(DialogResponse());
      print(e.response);
      toast(DioExceptions.fromDioError(e).toString(), color: Colors.red, seconds: 3);
    }
  }

  Future<void> createAccount() async {
    details['date_of_birth'] = chosenDate.toString();
    print(details);
    NavigationService().clearStackAndShowView(
      VerificationComplete(
        title: "All done!",
        description:
        "Your account has been created. You're now ready to explore and enjoy all the features and benefits we have to offer.",
        buttonText: "Start exploring App",
        imageUrl: "assets/images/Design 1.png",
        onTap: () {
          NavigationService().clearStackAndShowView(const DashboardView());
        },
      ),
    );
  }
}
