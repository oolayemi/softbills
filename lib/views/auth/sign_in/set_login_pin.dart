import 'package:flutter/material.dart';
import 'package:no_name/widgets/utility_widgets.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';
import 'package:pinput/pinput.dart';
import 'package:stacked/stacked.dart';

import 'sign_in_viewmodel.dart';

class SetLoginPinView extends StatelessWidget {
  const SetLoginPinView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignInViewModel>.reactive(
      viewModelBuilder: () => SignInViewModel(),
      onModelReady: (model) => model.setup(),
      builder: (context, model, child) {
        return CustomScaffoldWidget(
          body: Stack(
            children: [
              Container(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                child: ListView(
                  children: [
                    Center(
                      child: Column(
                        children: [
                          Image.asset("assets/images/user.png", height: 100, width: 100),
                          const SizedBox(height: 20),
                          const Text(
                            "Set Login PIN",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "Please set your login PIN for sign in...",
                            style: TextStyle(
                              fontSize: 19,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 100),
                    Pinput(
                      controller: model.pinController,
                      //useNativeKeyboard: false,
                      obscureText: true,
                      onCompleted: (String? value) => model.setPin(),
                      defaultPinTheme: PinTheme(
                        width: 80,
                        height: 80,
                        textStyle: const TextStyle(fontSize: 28, fontWeight: FontWeight.w600, color: Colors.white),
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          border: Border.all(color: const Color(0xFFE1D7C0).withOpacity(.2)),
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              Positioned(
                bottom: 10,
                right: 0,
                left: 0,
                child: Column(
                  children: [
                    NumericKeyboard(
                      onKeyboardTap: (String value) {
                        if (model.pinController.text.length < 4) model.pinController.text = model.pinController.text + value;
                      },
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      rightButtonFn: () {
                        if (model.pinController.text.isNotEmpty) {
                          model.pinController.text = model.pinController.text.substring(0, model.pinController.text.length - 1);
                        }
                      },
                      rightIcon: const Icon(
                        Icons.backspace,
                        color: Colors.red,
                      ),
                      leftButtonFn: null,
                      leftIcon: null,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(""),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
