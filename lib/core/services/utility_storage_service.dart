import 'package:hive/hive.dart';
import 'package:stacked/stacked.dart';

import '../../app/locator.dart';
import '../utils/hive_boxes.dart';

class StorageService with ReactiveServiceMixin {
  final HiveInterface _hiveService = locator<HiveInterface>();
  
  bool get _isBoolBoxOpen => _hiveService.isBoxOpen(HiveBox.bools);
  Box<bool> get _boolBox => _hiveService.box<bool>(HiveBox.bools);

  bool get _isStringBoxOpen => _hiveService.isBoxOpen(HiveBox.strings);
  Box<String> get _stringsBox => _hiveService.box<String>(HiveBox.strings);
  
  StorageService() {
    listenToReactiveValues([]);
  }
  
  Future<void> init() async {
    // _hiveService.registerAdapter(UserAdapter());

    if (!_isBoolBoxOpen) {
      await _hiveService.openBox<bool>(HiveBox.bools);
    }
    if (!_isStringBoxOpen) {
      await _hiveService.openBox<String>(HiveBox.strings);
    }
  }

  void addString(String key, String? value) {
    _stringsBox.put(key, value!);
  }

  String? getString(String key) {
    return _stringsBox.get(key);
  }

  void removeString(String key) {
    _stringsBox.delete(key);
  }

  void addBool(String key, bool value) {
    _boolBox.put(key, value);
  }

  bool? getBool(String key) {
    return _boolBox.get(key);
  }

  void removeBool(String key) {
    _boolBox.delete(key);
  }

}