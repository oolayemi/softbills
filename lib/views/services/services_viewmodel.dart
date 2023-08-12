import 'package:no_name/app/locator.dart';
import 'package:no_name/views/betting/betting_view.dart';
import 'package:no_name/views/cabletv/cable_tv_view.dart';
import 'package:no_name/views/electricity/electricity_view.dart';
import 'package:no_name/views/swap/swap_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../airtime/airtime_view.dart';
import '../data/data_view.dart';
import '../sme_data/sme_data_view.dart';

class ServicesViewModel extends ReactiveViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  void gotoAirtime() {
    _navigationService.navigateToView(const AirtimeView());
  }

  void gotoData() {
    _navigationService.navigateToView(const DataView());
  }

  void gotoSmeData() {
    _navigationService.navigateToView(const SmeDataView());
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