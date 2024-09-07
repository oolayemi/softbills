import 'package:no_name/app/locator.dart';
import 'package:no_name/core/models/profile_response.dart';
import 'package:no_name/core/services/auth_service.dart';
import 'package:stacked/stacked.dart';

class UpgradeViewModel extends ReactiveViewModel {
  final AuthService _authService = locator<AuthService>();

  ProfileData? get profile => _authService.profileResponse;

}