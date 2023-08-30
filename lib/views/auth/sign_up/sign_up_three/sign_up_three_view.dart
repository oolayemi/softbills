import 'package:flutter/material.dart';
import 'package:no_name/widgets/utility_widgets.dart';
import 'package:stacked/stacked.dart';

import 'sign_up_three_viewmodel.dart';

class SignUpThreeView extends StatelessWidget {
  final Map<String, dynamic> details;

  const SignUpThreeView({Key? key, required this.details}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignUpThreeViewModel>.reactive(
        viewModelBuilder: () => SignUpThreeViewModel(),
        onModelReady: (model) => model.setUp(details),
        builder: (context, model, child) {
          return CustomScaffoldWidget(
            appBar: CustomAppBar(
              title: "",
              actions: [
                Row(
                  children: const [
                    Text("3/3"),
                    SizedBox(width: 10),
                    TabButton(selectedPage: 3, pageNumber: 1, width: 25, height: 8),
                    SizedBox(width: 5),
                    TabButton(selectedPage: 3, pageNumber: 2, width: 25, height: 8),
                    SizedBox(width: 5),
                    TabButton(selectedPage: 3, pageNumber: 3, width: 25, height: 8),
                    SizedBox(width: 5),
                  ],
                )
              ],
            ),
            body: Stack(
              children: [
                Container(
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Form(
                    key: model.formKey,
                    child: ListView(
                      children: [
                        const Text(
                          "Setup Transaction PIN",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Please set up your transaction pin",
                          style: TextStyle(
                            fontSize: 19,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 30),
                        BuildTextField(
                          title: "PIN",
                          hintText: "****",
                          maxLength: 4,
                          obscure: true,
                          controller: model.pinController,
                          textInputType: TextInputType.number,
                          validator: (String? value) => value!.isEmpty
                              ? "PIN field cannot be empty"
                              : value.length < 4
                                  ? "PIN must be at least 4 characters"
                                  : null,
                        ),
                        BuildTextField(
                          title: "Confirm PIN",
                          hintText: "****",
                          maxLength: 4,
                          obscure: true,
                          isLast: true,
                          textInputType: TextInputType.number,
                          validator: (String? value) => value!.isEmpty
                              ? "Confirm PIN field cannot be empty"
                              : value != model.pinController.text
                                  ? "PIN and Confirm PIN do not match"
                                  : null,
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: 0,
                  left: 0,
                  child: RoundedButton(
                    title: "Sign Up",
                    onPressed: () {
                      if (model.formKey.currentState!.validate()) {
                        model.signUp(context);
                      }
                    },
                  ),
                )
              ],
            ),
          );
        });
  }
}
