import 'package:flutter/material.dart';
import 'package:no_name/widgets/utility_widgets.dart';
import 'package:stacked/stacked.dart';

import 'validate_email_viewmodel.dart';

class ValidateEmailView extends StatelessWidget {
  final Map<String, dynamic> details;
  const ValidateEmailView({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ValidateEmailViewModel>.reactive(
        viewModelBuilder: () => ValidateEmailViewModel(),
        onViewModelReady: (model) => model.setUp(details),
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
                    "Enter your email",
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
                    title: "Your email",
                    hintText: "johndoe@example.net",
                    controller: model.emailController,
                    validator: (String? value) => value!.isEmpty ? "Please fill in the email field" : null,
                  ),
                  const Text(
                    "We'll send you a code. It helps keep your account secure",
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
                      title: "Send Code",
                      onPressed: () {
                        if (model.formKey.currentState!.validate()) {
                          model.validateEmail(context);
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
