import 'package:no_name/app/locator.dart';
import 'package:no_name/core/services/auth_service.dart';
import 'package:stacked/stacked.dart';

import '../../core/models/wallet_response.dart';

class FundTransferViewModel extends ReactiveViewModel {
  final AuthService _authService = locator<AuthService>();

  VirtualAccount? get virtualAccount => _authService.walletResponse?.virtualAccount;
}