import 'package:flutter/material.dart';
import 'package:no_name/widgets/utility_widgets.dart';
import 'package:stacked/stacked.dart';

import 'nin_verification_viewmodel.dart';

class NinVerificationView extends StatelessWidget {
  const NinVerificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NinVerificationViewModel>.reactive(
        onViewModelReady: (model) => model.setUp(),
        viewModelBuilder: () => NinVerificationViewModel(),
        builder: (context, model, child) {
          return CustomScaffoldWidget(
            appBar: const CustomAppBar(
              title: "NIN Verification",
            ),
            body: Stack(
              children: [
                Form(
                  key: model.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Enter your NIN",
                        style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                      ),
                      const Text(
                        "Type in your NIN carefully",
                        style: TextStyle(fontSize: 15),
                      ),
                      const SizedBox(height: 40),
                      BuildTextField(
                        title: "NIN",
                        hintText: "Enter NIN",
                        textInputType: TextInputType.number,
                        maxLength: 11,
                        controller: model.ninController,
                        validator: (value) => value!.isEmpty ? "" : null,
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
                        model.verifyNin(context);
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
