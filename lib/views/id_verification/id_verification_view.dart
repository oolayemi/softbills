import 'package:flutter/material.dart';
import 'package:no_name/widgets/utility_widgets.dart';
import 'package:stacked/stacked.dart';

import 'id_verification_viewmodel.dart';

class IDVerificationView extends StatelessWidget {
  const IDVerificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<IDVerificationViewModel>.reactive(
        viewModelBuilder: () => IDVerificationViewModel(),
        builder: (context, model, child) {
          return const CustomScaffoldWidget(
            appBar: CustomAppBar(
              title: "ID Verification",
              withBackButton: false,
            ),
            body: Stack(
              children: [
                Column(
                  children: [
                    BuildTextField(title: "ID", hintText: "Choose an ID")
                  ],
                ),
                Positioned(
                  bottom: 10,
                  right: 0,
                  left: 0,
                  child: RoundedButton(title: "Validate"),
                )
              ],
            ),
          );
        });
  }

}
