import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pinput/pinput.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../app/locator.dart';
import '../core/services/auth_service.dart';
import '../core/services/utility_storage_service.dart';
import '../core/utils/size_config.dart';

class BottomPad<T extends ReactiveViewModel> extends StatefulWidget {
  final Function? function;

  const BottomPad({super.key, this.function});
  @override
  State<BottomPad> createState() => _BottomPadState();
}

class _BottomPadState extends State<BottomPad> {
  final AuthService _authService  = locator<AuthService>();
  final StorageService _storageService  = locator<StorageService>();
  final NavigationService _navigationService = locator<NavigationService>();

  bool get getBiometricAvailability => _authService.isBiometricsAvailable && _storageService.getString('pin') != null;

  TextEditingController pin = TextEditingController();

  void runProcess() {
    if(pin.text.length == 5) {
      _navigationService.back();
      widget.function!(pin.text);
    }
  }

  // void biometricAuthentication() {
  //   _navigationService.back();
  //   _authService.biometricsPinVerification().then((value) {
  //     function!(value);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final NavigationService navigationService = locator<NavigationService>();
    return StatefulBuilder(
      builder: (context, modalstate) => Container(
        padding: EdgeInsets.symmetric(vertical: SizeConfig.yMargin(context, 2), horizontal: SizeConfig.xMargin(context, 4)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      'Enter Your Pin',
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        fontSize: SizeConfig.textSize(context, 2),
                        color: Colors.black
                      ),
                    ),
                    const SizedBox(width: 8),
                    SvgPicture.asset("assets/icons/shield.svg", width: 15,)
                  ],
                ),
                IconButton(
                  onPressed: () => navigationService.back(),
                  icon: const Icon(
                    Icons.close,
                  )
                )
              ],
            ),
            Pinput(
              length: 5,
              controller: pin,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    keyPad(
                      context: context,
                      text: '1',
                      func: (text) => modalstate(() {
                        pin.text = '${pin.text}$text';
                        runProcess();
                      })
                    ),
                    keyPad(
                      context: context,
                      text: '2',
                      func: (text) => modalstate(() {
                        pin.text = '${pin.text}$text';
                        runProcess();
                      })
                    ),
                    keyPad(
                      context: context,
                      text: '3',
                      func: (text) => modalstate(() {
                        pin.text = '${pin.text}$text';
                        runProcess();
                      })
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    keyPad(
                      context: context,
                      text: '4',
                      func: (text) => modalstate(() {
                        pin.text = '${pin.text}$text';
                        runProcess();
                      })
                    ),
                    keyPad(
                      context: context,
                      text: '5',
                      func: (text) => modalstate(() {
                        pin.text = '${pin.text}$text';
                        runProcess();
                      })
                    ),
                    keyPad(
                      context: context,
                      text: '6',
                      func: (text) => modalstate(() {
                        pin.text = '${pin.text}$text';
                        runProcess();
                      })
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    keyPad(
                      context: context,
                      text: '7',
                      func: (text) => modalstate(() {
                        pin.text = '${pin.text}$text';
                        runProcess();
                      })
                    ),
                    keyPad(
                      context: context,
                      text: '8',
                      func: (text) => modalstate(() {
                        pin.text = '${pin.text}$text';
                        runProcess();
                      })
                    ),
                    keyPad(
                      context: context,
                      text: '9',
                      func: (text) => modalstate(() {
                        pin.text = '${pin.text}$text';
                        runProcess();
                      })
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: SizeConfig.yMargin(context, 2)),
                      width: SizeConfig.xMargin(context, 30),
                      child: Center(
                        child: getBiometricAvailability ? InkWell(
                          // onTap: () => biometricAuthentication(),
                          child: SvgPicture.asset(
                            'assets/svgs/fingerprint.svg',
                            height: SizeConfig.yMargin(context, 4.5),
                          ),
                        ) : const SizedBox(),
                      ),
                    ),
                    keyPad(
                      context: context,
                      text: '0',
                      func: (text) => modalstate(() {
                        pin.text = '${pin.text}$text';
                        runProcess();
                      })
                    ),
                    InkWell(
                      onTap: () {
                        modalstate(() {
                          pin.text = pin.text.substring(0, pin.text.length-1);
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: SizeConfig.yMargin(context, 2)),
                        width: SizeConfig.xMargin(context, 30),
                        child: Center(
                          child: pin.text == '' ? const SizedBox() : const Icon(
                            Icons.backspace
                          )
                        )
                      ),
                    )
                  ],
                ),
              ],
            )
          ],
        ),
    ),
    );
  }

  Widget keyPad({required BuildContext context, required String text, Function? func}) {
    return InkWell(
      onTap: () => func!(text),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: SizeConfig.yMargin(context, 2)),
        width: SizeConfig.xMargin(context, 30),
        child: Center(
          child: Text(
            text,
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
              fontSize: SizeConfig.textSize(context, 2.5),
              // color: BrandColors.primary
            ),
          ),
        )
      ),
    );
  } 
}