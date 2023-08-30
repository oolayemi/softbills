import 'package:flutter/material.dart';
import 'package:no_name/styles/brand_color.dart';
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
                _eachSection(
                  "BVN",
                  null,
                  // model.profile!.tier! >= 2 ? null : () => model.gotoBVN(),
                  suffixIcon: const Icon(Icons.arrow_forward_ios_outlined,
                      color: BrandColors.secondary),
                ),
                _eachSection(
                  "ID",
                  () => model.gotoIDVerification(),
                  suffixIcon: const Icon(Icons.arrow_forward_ios_outlined,
                      color: BrandColors.secondary),
                ),
              ],
            ),
          );
        });
  }

  _eachSection(String title, dynamic onTap,
      {Widget suffixIcon = const Icon(Icons.arrow_forward_ios_outlined)}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        width: double.maxFinite,
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text(title), suffixIcon],
        ),
      ),
    );
  }
}
