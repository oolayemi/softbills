import 'package:no_name/core/models/profile_response.dart';
import 'package:no_name/core/services/auth_service.dart';
import 'package:no_name/views/bvn_verification/bvn_verification_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/locator.dart';
import '../id_verification/id_verification_view.dart';

class KycViewModel extends ReactiveViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthService _authService = locator<AuthService>();

  ProfileData? get profile => _authService.profileResponse;


  void gotoBVN() {
    _navigationService.navigateToView(const BVNVerificationView());
  }

  void gotoIDVerification() {
    _navigationService.navigateToView(const IDVerificationView());
  }
  @override
  // TODO: implement reactiveServices
  List<ReactiveServiceMixin> get reactiveServices => [];

}