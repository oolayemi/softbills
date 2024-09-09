import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/locator.dart';
import '../../core/models/profile_response.dart';
import '../../core/services/auth_service.dart';

class CreditViewModel extends ReactiveViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthService _authService = locator<AuthService>();


  ProfileData? get profileData => _authService.profileResponse;
}