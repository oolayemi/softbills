import 'package:flutter/material.dart';
import 'package:no_name/widgets/utility_widgets.dart';
import 'package:stacked/stacked.dart';

import 'bvn_verification_viewmodel.dart';

class BVNVerificationView extends StatelessWidget {
  const BVNVerificationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BVNVerificationViewModel>.reactive(
        onModelReady: (model) => model.setUp(),
        viewModelBuilder: () => BVNVerificationViewModel(),
        builder: (context, model, child) {
          return CustomScaffoldWidget(
            appBar: const CustomAppBar(
              title: "BVN Verification",
              withBackButton: false,
            ),
            body: Stack(
              children: [
                Form(
                  key: model.formKey,
                  child: Column(
                    children: [
                      const Text(
                        "",
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 40),
                      BuildTextField(
                        title: "BVN",
                        hintText: "Enter BVN",
                        controller: model.bvnController,
                      ),
                      const SizedBox(height: 10),
                      BuildTextField(
                        title: "Phone number",
                        hintText: "Enter your phone number",
                        controller: model.phoneNumberController,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: 0,
                  left: 0,
                  child: RoundedButton(
                    title: "Validate",
                    onPressed: () {
                      if (model.formKey.currentState!.validate()) {
                        model.verifyBvn(context);
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
