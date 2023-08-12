import 'package:flutter/material.dart';
import 'package:no_name/widgets/utility_widgets.dart';
import 'package:stacked/stacked.dart';

import 'kyc_viewmodel.dart';

class KycView extends StatelessWidget {
  const KycView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<KycViewModel>.reactive(
        viewModelBuilder: () => KycViewModel(),
        builder: (context, model, child) {
          return CustomScaffoldWidget(
            appBar: const CustomAppBar(
              title: "KYC",
              withBackButton: false,
            ),
            body: Column(
              children: [
                const Text(
                  "",
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 40),
                _eachSection(
                  "BVN",
                  model.profile!.tier! >= 2 ? null : () => model.gotoBVN(),
                  suffixIcon: model.profile!.tier! >= 2
                      ? const Icon(Icons.check_circle, color: Colors.green)
                      : const Icon(Icons.arrow_forward_ios_outlined),
                ),
                _eachSection("ID", () => model.gotoIDVerification()),
              ],
            ),
          );
        });
  }

  _eachSection(String title, dynamic onTap, {Widget suffixIcon = const Icon(Icons.arrow_forward_ios_outlined)}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        width: double.maxFinite,
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: const Color(0xFF3C3C3C).withOpacity(.57), borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text(title), suffixIcon],
        ),
      ),
    );
  }
}
