import 'package:no_name/app/locator.dart';
import 'package:no_name/views/betting/betting_view.dart';
import 'package:no_name/views/cabletv/cable_tv_view.dart';
import 'package:no_name/views/electricity/electricity_view.dart';
import 'package:no_name/views/swap/swap_view.dart';
import 'package:no_name/views/transfer/transfer_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../core/models/profile_response.dart';
import '../../core/services/auth_service.dart';
import '../airtime/airtime_view.dart';
import '../data/data_view.dart';
import '../sme_data/sme_data_view.dart';

class ServicesViewModel extends ReactiveViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthService _authService = locator<AuthService>();


  ProfileData? get profileData => _authService.profileResponse;

  void gotoAirtime() {
    _navigationService.navigateToView(const AirtimeView());
  }

  void gotoData() {
    _navigationService.navigateToView(const DataView());
  }

  void gotoSmeData() {
    _navigationService.navigateToView(const SmeDataView());
  }

  void gotoTransfer() {
    _navigationService.navigateToView(const TransferView());
  }

  void gotoCableTV() {
    _navigationService.navigateToView(const CableTvView());
  }

  void gotoElectricity() {
    _navigationService.navigateToView(const ElectricityView());
  }

  void gotoBilling() {
    _navigationService.navigateToView(const BettingView());
  }

  gotoSwap() {
    _navigationService.navigateToView(const SwapView());
  }

  @override
  // TODO: implement reactiveServices
  List<ReactiveServiceMixin> get reactiveServices => [];

}