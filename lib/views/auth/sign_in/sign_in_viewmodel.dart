import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:device_information/device_information.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:no_name/app/locator.dart';
import 'package:no_name/core/services/auth_service.dart';
import 'package:no_name/core/services/utility_storage_service.dart';
import 'package:no_name/views/auth/sign_in/sign_in_view.dart';
import 'package:no_name/views/dashboard/dashboard_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../core/constants/loading_dialog.dart';
import '../../../core/exceptions/error_handling.dart';
import '../../../core/utils/tools.dart';
import '../../../widgets/utility_widgets.dart';
import 'set_login_pin.dart';

class SignInViewModel extends ReactiveViewModel {
  final StorageService _storageService = locator<StorageService>();
  final AuthService _authService = locator<AuthService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final DialogService _dialogService = locator<DialogService>();

  TextEditingController pinController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool get canUseBiometrics => _authService.isBiometricsAvailable;

  Future<void> setup() async {
    await _authService.setBiometricStatus();
    notifyListeners();
  }

  Future<void> validatePin(context) async {
    LoaderDialog.showLoadingDialog(context, message: "Signing in");
    String hashedPin = sha1.convert(utf8.encode(pinController.text)).toString();
    if (_storageService.getString('loginPin') == hashedPin) {
      await getDetails();
      _dialogService.completeDialog(DialogResponse());
      flusher("Sign in successful", context, color: Colors.green);
    } else {
      await Future.delayed(const Duration(seconds: 2));
      _dialogService.completeDialog(DialogResponse());
      flusher("Login PIN is incorrect", context, color: Colors.red);
    }
  }

  Future<void> setPin() async {
    _storageService.addString('loginPin', sha1.convert(utf8.encode(pinController.text)).toString());
    getDetails();
  }

  Future<void> getDetails({bool gotoDashboard = true}) async {
    await _authService.getProfile();
    // await _authService.getNextOfKin();
    await _authService.getWalletDetails();
    // await _authService.getVirtualAccounts();
    // await _authService.getAirtimeBeneficiaries();
    // await _authService.getDataBeneficiaries();
    // await _authService.getWalletTransactions(page: 1);
    // await _authService.getCurrentRate();
    //save pin, then otp verification
    gotoDashboard ? _navigationService.clearStackAndShowView(const DashboardView()) : null;
  }

  Future<bool> biometrics() async {
    final LocalAuthentication auth = LocalAuthentication();
    final bool didAuthenticate = await auth.authenticate(
        localizedReason: "Please authenticate to sign in", options: const AuthenticationOptions());

    return didAuthenticate;
  }

  Future<void> gotoSignUp() async {
    _storageService.removeBool('isLoggedIn');
    _storageService.removeString('token');
    _storageService.removeString('email');
    _storageService.removeString('loginPin');
    _storageService.removeBool('biometric');
    _storageService.removeBool('skippedOnboarding');

    // _storageService.addBool(key, value)
    _navigationService.clearStackAndShowView(const SignInView());
  }

  Future<void> signIn(context) async {
    LoaderDialog.showLoadingDialog(context, message: "Signing in...");
    try {
      var deviceId = getRandomString(10);
      var data = {'email': emailController.text, 'password': passwordController.text, 'device_id': deviceId};

      var response = await dio(withToken: false).post('/auth/login', data: data);

      int? statusCode = response.statusCode;
      Map responseData = response.data!;

      if (statusCode == 200) {
        Map jsonData = jsonDecode(response.toString());
        if (responseData['status'] == 'success') {
          _storageService.addString("token", jsonData['data']['token']);
          _storageService.addString('email', emailController.text);
          _storageService.addBool('isLoggedIn', true);
          await getDetails(gotoDashboard: false).then((value) {
            _navigationService.clearStackAndShowView(const SetLoginPinView());
          });
        } else {
          _dialogService.completeDialog(DialogResponse());
          flusher(json.decode(response.toString())['message'], context, color: Colors.red);
        }
      } else {
        _dialogService.completeDialog(DialogResponse());
        flusher(json.decode(response.toString())['message'], context, color: Colors.red);
      }
    } on DioError catch (e) {
      _dialogService.completeDialog(DialogResponse());
      print(e.response);
      flusher('Request error: ${DioExceptions.fromDioError(e).toString()}', context, color: Colors.red);
    }
  }

  @override
  // TODO: implement reactiveServices
  List<ReactiveServiceMixin> get reactiveServices => [];
}
