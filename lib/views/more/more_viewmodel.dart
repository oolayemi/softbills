import 'package:stacked/stacked.dart';

import '../../app/locator.dart';
import '../../core/models/profile_response.dart';
import '../../core/models/wallet_response.dart';
import '../../core/services/auth_service.dart';

class MoreViewModel extends ReactiveViewModel {
  final AuthService _authService = locator<AuthService>();
  ProfileData? get profileData => _authService.profileResponse;
  VirtualAccount? get virtualAccount => _authService.walletResponse?.virtualAccount;
}