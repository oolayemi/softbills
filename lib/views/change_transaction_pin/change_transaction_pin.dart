import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:no_name/widgets/utility_widgets.dart';
import 'package:stacked/stacked.dart';

import 'change_transaction_pin_viewmodel.dart';

class ChangeTransactionPinView extends StatelessWidget {
  const ChangeTransactionPinView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChangeTransactionPinViewModel>.reactive(
        viewModelBuilder: () => ChangeTransactionPinViewModel(),
        builder: (context, model, child) {
          return CustomScaffoldWidget(
            appBar: const CustomAppBar(title: "Change Transaction PIN"),
            body: Stack(
              children: [
                Container(
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Form(
                    key: model.formKey,
                    child: ListView(
                      children: [
                        BuildTextField(
                          title: "Current PIN",
                          hintText: "****",
                          maxLength: 4,
                          controller: model.oldPin,
                          textInputType: TextInputType.number,
                          validator: (String? value) => value!.isEmpty
                              ? "Old PIN field cannot be empty"
                              : value.length < 4
                              ? "Old PIN must be at least 4 characters"
                              : null,
                        ),
                        BuildTextField(
                          title: "New PIN",
                          hintText: "****",
                          maxLength: 4,
                          controller: model.newPin,
                          textInputType: TextInputType.number,
                          validator: (String? value) => value!.isEmpty
                              ? "New PIN field cannot be empty"
                              : value.length < 4
                              ? "New PIN must be at least 4 characters"
                              : null,
                        ),
                        BuildTextField(
                          title: "Confirm PIN",
                          hintText: "****",
                          maxLength: 4,
                          isLast: true,
                          controller: model.confirmNewPin,
                          textInputType: TextInputType.number,
                          validator: (String? value) => value!.isEmpty
                              ? "Confirm PIN field cannot be empty"
                              : value != model.newPin.text
                              ? "New PIN and Confirm PIN do not match"
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
                    title: "Change PIN",
                    onPressed: () {
                      if (model.formKey.currentState!.validate()) {
                        model.changePin(context);
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
