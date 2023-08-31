import 'dart:async';

import 'package:no_name/app/locator.dart';
import 'package:no_name/core/services/utility_storage_service.dart';
import 'package:no_name/views/auth/initial_sign_up.dart';
import 'package:no_name/views/auth/sign_in/existing_sign_in_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../auth/sign_in/sign_in_view.dart';

class SplashScreenViewModel extends ReactiveViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final StorageService _storageService = locator<StorageService>();

  String imagePath = "assets/icons/softbills_icon.png";

  void setup() {
    Future.delayed(const Duration(seconds: 3), () {
      _navigationService.clearStackAndShowView(
        _storageService.getString('token') != null
            ? _storageService.getString('loginPin') != null
                ? const ExistingSignInView()
                : const SignInView()
            : _storageService.getBool('skippedOnboarding') == null || _storageService.getBool('skippedOnboarding') == false
                ? const InitialSignUpView()
                : const SignInView(),
      );
    });
  }

  @override
  // TODO: implement reactiveServices
  List<ReactiveServiceMixin> get reactiveServices => [];
}
