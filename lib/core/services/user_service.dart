
import 'package:hive/hive.dart';
import 'package:stacked/stacked.dart';

import '../../app/locator.dart';
import '../utils/hive_boxes.dart';

class UserService with ReactiveServiceMixin {

  final HiveInterface _hiveService = locator<HiveInterface>();

  bool get _isBoxOpen => _hiveService.isBoxOpen(HiveBox.user);
  // Box<User> get _userBox => _hiveService.box<User>(HiveBox.user);

  // RxValue<User> _user = RxValue<User>(initial: null);
  // User get user => _user.value;

  // UserService() {
  //   listenToReactiveValues([_user]);
  // }

  Future<void> init() async {
    // _hiveService.registerAdapter(TokenAdapter());
    // _hiveService.registerAdapter(WalletAdapter());
    // _hiveService.registerAdapter(CommissionAdapter());
    // _hiveService.registerAdapter(UserAdapter());
    // _hiveService.registerAdapter(PlanAdapter());

    // if (!_isBoxOpen) {
    //   await _hiveService.openBox<User>(HiveBox.user);
    // }
  }

  void getUser() {
    // _user.value = _userBox.get(0);
  }

  // void addUser(User newUser) {
  //   // _userBox.put(0, newUser);
  // }

  // void addPassword(String pass) {
  //   User updatedUser = _user.value..password = pass;
  //   _userBox.putAt(0, updatedUser);
  // }

  // void updateWallet(Wallet wallet) {
  //   User updatedUser = _user.value..wallet = wallet;
  //   _userBox.putAt(0, updatedUser);
  // }

  void clearUser() {
    // _userBox.clear();
  }
}