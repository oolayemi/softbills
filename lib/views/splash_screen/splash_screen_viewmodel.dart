import 'dart:async';

import 'package:no_name/app/locator.dart';
import 'package:no_name/core/services/utility_storage_service.dart';
import 'package:no_name/views/auth/initial_sign_up.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';


class SplashScreenViewModel extends ReactiveViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final StorageService _storageService = locator<StorageService>();

  double opacity = 0.0;

  void setup() {
    _animateSplashScreen();
  }

  void _animateSplashScreen() async {
    // Start fade-in animation
    opacity = 1.0;
    notifyListeners();

    // Wait for 3 seconds
    await Future.delayed(const Duration(seconds: 3));

    // Start fade-out animation

    opacity = 0.0;
    notifyListeners();

    // Wait for 2 seconds
    await Future.delayed(const Duration(seconds: 2));

    _navigationService.clearStackAndShowView(
      // _storageService.getString('token') != null
      //     ? _storageService.getString('loginPin') != null
      //         ? const ExistingSignInView()
      //         : const SignInView()
      //     : _storageService.getBool('skippedOnboarding') == null || _storageService.getBool('skippedOnboarding') == false
               const InitialSignUpView()
              // : const SignInView(),
    );
  }

  @override
  // TODO: implement reactiveServices
  List<ReactiveServiceMixin> get reactiveServices => [];
}
