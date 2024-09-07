import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:no_name/views/bvn_verification/bvn_verification_view.dart';
import 'package:no_name/views/upgrade/upgrade_viewmodel.dart';
import 'package:no_name/widgets/utility_widgets.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../nin_verification/nin_verification_view.dart';

class UpgradeView extends StatelessWidget {
  const UpgradeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UpgradeViewModel>.reactive(
        viewModelBuilder: () => UpgradeViewModel(),
        builder: (context, model, _) {
          return CustomScaffoldWidget(
            appBar: const CustomAppBar(
              title: "Upgrade",
            ),
            body: Column(
              children: [
                const Text(
                  "We need to verify your identity to remove all limits on your account",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 15),
                _eachSection("BVN", () async {
                  await NavigationService().navigateToView(const BVNVerificationView());
                  model.notifyListeners();
                }, model.profile!.tier! >= 2),
                _eachSection("NIN", () async {
                  await NavigationService().navigateToView(const NinVerificationView());
                  model.notifyListeners();
                }, model.profile!.tier! >= 3),
              ],
            ),
          );
        });
  }

  _eachSection(String title, dynamic onTap, bool isVerified, {Widget? suffixIcon}) {
    return GestureDetector(
      onTap: isVerified ? null : onTap,
      child: Container(
        height: 60,
        width: double.maxFinite,
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  SvgPicture.asset("assets/svg/shield.svg"),
                  const SizedBox(width: 8),
                  Text(title),
                  const SizedBox(width: 8),
                  Icon(
                    isVerified ? Icons.check_circle : Icons.info,
                    color: isVerified ? Colors.green : Colors.orange,
                    size: 20,
                  )
                ],
              ),
            ),
            if (!isVerified) suffixIcon ?? SvgPicture.asset("assets/svg/forward_button.svg"),
          ],
        ),
      ),
    );
  }
}
