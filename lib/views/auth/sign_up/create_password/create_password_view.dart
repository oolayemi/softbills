import 'package:flutter/material.dart';
import 'package:no_name/widgets/utility_widgets.dart';
import 'package:stacked/stacked.dart';

import 'create_password_viewmodel.dart';

class CreatePasswordView extends StatelessWidget {
  final String from;
  const CreatePasswordView({super.key, this.from = "new"});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CreatePasswordViewModel>.reactive(
        viewModelBuilder: () => CreatePasswordViewModel(),
        builder: (context, model, child) {
          return CustomScaffoldWidget(
            appBar: AppBar(
              leading: GestureDetector(
                onTap: Navigator.of(context).pop,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Image.asset('assets/images/Frame 1000002902.png'),
                ),
              ),
            ),
            body: Form(
              key: model.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Create your password",
                    // textAlign: textAlign,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  BuildTextField(
                    title: "Choose a password",
                    hintText: "password",
                    controller: model.passwordController,
                    validator: (String? value) => value!.isEmpty ? "Please fill in the password field" : null,
                  ),
                  const Text(
                    "At least 8 characters, containing a letter, a number and special character",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF333333),
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  SizedBox(
                    width: double.infinity,
                    child: RoundedButton(
                      title: "Done",
                      onPressed: () {
                        if (model.formKey.currentState!.validate()) {
                          model.gotoVerificationCompleteView();
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 20)
                ],
              ),
            ),
          );
        });
  }
}
