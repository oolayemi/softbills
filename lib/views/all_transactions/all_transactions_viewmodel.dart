import 'package:no_name/app/locator.dart';
import 'package:no_name/core/services/auth_service.dart';
import 'package:stacked/stacked.dart';

import '../../core/models/transaction_history_data.dart';

class AllTransactionsViewModel extends ReactiveViewModel {
  final AuthService _authService = locator<AuthService>();

  List<DataResponse>? get transactions => _authService.walletTransactions;

  @override
  // TODO: implement reactiveServices
  List<ReactiveServiceMixin> get reactiveServices => [];

}