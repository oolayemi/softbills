import 'package:flutter/material.dart';
import 'package:no_name/widgets/utility_widgets.dart';
import 'package:stacked/stacked.dart';

import 'bvn_verification_viewmodel.dart';

class BVNVerificationView extends StatelessWidget {
  const BVNVerificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BVNVerificationViewModel>.reactive(
        onViewModelReady: (model) => model.setUp(),
        viewModelBuilder: () => BVNVerificationViewModel(),
        builder: (context, model, child) {
          return CustomScaffoldWidget(
            appBar: const CustomAppBar(
              title: "BVN Verification",
            ),
            body: Stack(
              children: [
                Form(
                  key: model.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Enter your BVN",
                        style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                      ),
                      const Text(
                        "Type in your BVN carefully",
                        style: TextStyle(fontSize: 15),
                      ),
                      const SizedBox(height: 40),
                      BuildTextField(
                        title: "BVN",
                        hintText: "Enter BVN",
                        controller: model.bvnController,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: 0,
                  left: 0,
                  child: RoundedButton(
                    title: "Confirm",
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
