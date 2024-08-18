import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:no_name/core/utils/tools.dart';
import 'package:no_name/widgets/utility_widgets.dart';
import 'package:stacked/stacked.dart';

import 'fund_transfer_viewmodel.dart';

class FundTransferView extends StatelessWidget {
  const FundTransferView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FundTransferViewModel>.reactive(
        viewModelBuilder: () => FundTransferViewModel(),
        builder: (context, model, _) {
          return CustomScaffoldWidget(
            appBar: const CustomAppBar(title: "Fund (Transfer)"),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const Text("Use the details below to send money to your Softbills Account",
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
                  const SizedBox(height: 30),
                  eachContainer("Bank", model.virtualAccount?.bankName ?? ''),
                  const SizedBox(height: 25),
                  eachContainer("Account Name", model.virtualAccount?.accountName ?? ''),
                  const SizedBox(height: 25),
                  eachContainer("Account Number", model.virtualAccount?.accountNumber ?? '', shouldCopy: true),
                  const SizedBox(height: 45),
                  SizedBox(
                    width: double.infinity,
                    child: RoundedButton(title: "Share", onPressed: () {}),
                  )
                ],
              ),
            ),
          );
        });
  }

  Widget eachContainer(String name, String value, {bool shouldCopy = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: BoxDecoration(
            color: const Color(0xFFA4A9AE).withOpacity(.15),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
              shouldCopy == true
                  ? InkWell(
                      onTap: () => copyToClipboard(value, "${ucWord(name)} copied successfully"),
                      child: const Icon(Icons.copy_all),
                    )
                  : const SizedBox(),
            ],
          ),
        )
      ],
    );
  }
}
