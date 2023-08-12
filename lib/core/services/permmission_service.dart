
import 'package:permission_handler/permission_handler.dart';

abstract class IPermissionService {
  Future<bool> getContactsPermission();

  Future<bool> getStoragePermission();
}

class PermissionService implements IPermissionService {
  @override
  Future<bool> getContactsPermission() async {
    final PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.denied) {
      final Map<Permission, PermissionStatus> permissionStatus =
          await [Permission.contacts].request();
      var isAllow = permissionStatus[Permission.contacts] == PermissionStatus.granted;
            return isAllow;
    } else {
      var isAllow = permission == PermissionStatus.granted;
            return isAllow;
    }
  }

  @override
  Future<bool> getStoragePermission() async {
    final PermissionStatus permission = await Permission.storage.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.denied) {
      final Map<Permission, PermissionStatus> permissionStatus =
          await [Permission.storage].request();
      return permissionStatus[Permission.storage] == PermissionStatus.granted;
    } else {
      return permission == PermissionStatus.granted;
    }
  }
}
