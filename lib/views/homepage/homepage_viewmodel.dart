import 'package:no_name/core/models/profile_response.dart';
import 'package:no_name/core/models/virtual_account_response.dart';
import 'package:no_name/core/models/wallet_response.dart';
import 'package:no_name/core/services/auth_service.dart';
import 'package:no_name/views/all_transactions/all_transactions_view.dart';
import 'package:no_name/views/betting/betting_view.dart';
import 'package:no_name/views/cabletv/cable_tv_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/locator.dart';
import '../../core/models/transaction_history_data.dart';
import '../airtime/airtime_view.dart';
import '../data/data_view.dart';
import '../sme_data/sme_data_view.dart';

class HomePageViewModel extends ReactiveViewModel {
  bool viewBalance = true;
  final NavigationService _navigationService = locator<NavigationService>();

  final AuthService _authService = locator<AuthService>();
  List<DataResponse>? get transactions => _authService.walletTransactions;

  ProfileData? get profileData => _authService.profileResponse;

  List<Wallet>? get walletTypes => _authService.walletResponse;
  List<VirtualAccountData>? get virtualAccounts => _authService.virtualAccountData;

  final RefreshController refreshController = RefreshController(initialRefresh: false);

  Wallet? selectedWallet;

  Future<void> setUp() async {
    selectedWallet = walletTypes!.first;
  }

  void onRefresh() async{
    await Future.delayed(const Duration(milliseconds: 1000));
    _authService.getWalletDetails();
    _authService.getWalletTransactions(page: 1);
    refreshController.refreshCompleted();
    notifyListeners();
  }

  void onLoading() async{
    await Future.delayed(const Duration(milliseconds: 1000));
    refreshController.loadComplete();
  }

  void toggleViewBalance() {
    viewBalance = !viewBalance;
    notifyListeners();
  }

  void gotoSeeAllTransactions() {
    _navigationService.navigateToView(const AllTransactionsView());
  }

  void gotoAirtime() {
    _navigationService.navigateToView(const AirtimeView());
  }

  void gotoData() {
    _navigationService.navigateToView(const DataView());
  }

  void gotoBetting() {
    _navigationService.navigateToView(const BettingView());
  }

  void gotoSmeData() {
    _navigationService.navigateToView(const SmeDataView());
  }

  void gotoCableTV() {
    _navigationService.navigateToView(const CableTvView());
  }

  void setWalletOption(Wallet val) {
    selectedWallet = val;

    print(selectedWallet);
    notifyListeners();
  }

  @override
  // TODO: implement reactiveServices
  List<ReactiveServiceMixin> get reactiveServices => [_authService];
}
