import 'dart:async';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/locator.dart';
import '../../app/router.dart';
import '../services/utility_storage_service.dart';
import '../utils/tools.dart';

class LifeCycleManager extends StatefulWidget {
  final Widget? child;

  const LifeCycleManager({super.key, this.child});
  
  @override
  State<LifeCycleManager> createState() => _LifeCycleManagerState();
}

class _LifeCycleManagerState extends State<LifeCycleManager> with WidgetsBindingObserver {
  final NavigationService _navigationService = locator<NavigationService>();
  final StorageService _storageService = locator<StorageService>();

  static const _inactivityTimeout = Duration(minutes: 2);
  Timer? _keepAliveTimer;

  void _keepAlive(bool visible) {
    if(env('APP_DEBUG') == 'false') {
      _keepAliveTimer?.cancel();
      if (visible) {
        _keepAliveTimer = null;
      } else {
        _keepAliveTimer = Timer(_inactivityTimeout, () {

          if((_navigationService.currentRoute != Routes.signinViewRoute) && _storageService.getBool('isLoggedIn') == true) {
            _storageService.addBool('isLoggedIn', false);
            _navigationService.clearStackAndShow(Routes.signinViewRoute);
          }
        });
      }
    }
  }

  @override
  void initState() {
    _keepAlive(false);
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => _keepAlive(false),
      onPanDown: (_) => _keepAlive(false),
      child: widget.child
    );
  }

  @override
  didChangeAppLifecycleState(AppLifecycleState state) {
    print(state);
    switch(state) {
      case AppLifecycleState.resumed:
        _keepAlive(false);
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
        // TODO: Handle this case.
        _keepAlive(false);
        break;
    }
  }
}