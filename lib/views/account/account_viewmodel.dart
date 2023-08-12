import 'package:no_name/core/models/profile_response.dart';
import 'package:no_name/views/kyc/kyc_view.dart';
import 'package:no_name/views/next_of_kin/next_of_kin_view.dart';
import 'package:no_name/views/personal_data/personal_data_view.dart';
import 'package:no_name/views/settings/settings_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/locator.dart';
import '../../core/services/auth_service.dart';

class AccountViewModel extends ReactiveViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthService _authService = locator<AuthService>();

  ProfileData? get profile => _authService.profileResponse;

  void gotoPersonalDataView() {
    _navigationService.navigateToView(const PersonalDataView());
  }

  void gotoSettingsView() {
    _navigationService.navigateToView(const SettingsView());
  }

  void gotoNextOfKin() {
    _navigationService.navigateToView(const NextOfKinView());
  }

  void gotoUpgrade() {
    _navigationService.navigateToView(const KycView());
  }
  @override
  // TODO: implement reactiveServices
  List<ReactiveServiceMixin> get reactiveServices => [_authService];

}