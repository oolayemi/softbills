import 'package:flutter/material.dart';
import 'package:no_name/styles/brand_color.dart';
import 'package:no_name/views/auth/sign_in/sign_in_view.dart';
import 'package:no_name/widgets/utility_widgets.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../core/services/utility_storage_service.dart';
import 'account_viewmodel.dart';

class AccountView extends StatelessWidget {
  const AccountView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AccountViewModel>.reactive(
        viewModelBuilder: () => AccountViewModel(),
        builder: (context, model, child) {
          return CustomScaffoldWidget(
            appBar: const CustomAppBar(
              title: "Account",
              withBackButton: false,
            ),
            body: Stack(
              children: [
                Column(
                  children: [
                    _personalDetails(),
                    const SizedBox(height: 40),
                    _eachSection(
                        "Personal Data", () => model.gotoPersonalDataView()),
                    _eachSection("Settings", () => model.gotoSettingsView()),
                    _eachSection(
                        "Next of Kin Information", () => model.gotoNextOfKin()),
                  ],
                ),
                Positioned(
                  bottom: 10,
                  right: 0,
                  left: 0,
                  child: RoundedButton(
                    title: "Sign Out",
                    onPressed: () {
                      StorageService().removeString("token");
                      StorageService().removeString('email');
                      StorageService().removeBool('isLoggedIn');
                      NavigationService()
                          .clearStackAndShowView(const SignInView());
                    },
                  ),
                )
              ],
            ),
          );
        });
  }

  _personalDetails() {
    AccountViewModel model = AccountViewModel();
    return Row(
      children: [
        Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
              color: BrandColors.primary,
            shape: BoxShape.circle
          ),
          child: Center(
              child: Text(
                  "${model.profile?.firstName?.substring(0, 1) ?? "O"}${model.profile?.lastName?.substring(0, 1) ?? "O"}",
                  style: const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600))),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${model.profile?.firstName ?? "Olayemi"} ${model.profile?.lastName ?? "Olaomo"}",
                style: const TextStyle(fontSize: 18),
              ),
              Text(
                model.profile?.email ?? "olayemiolaomo5@gmail.com",
                style: TextStyle(
                    fontSize: 16, color: Colors.black.withOpacity(.6)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Tier ${model.profile?.tier ?? "1"}",
                      style: const TextStyle(fontSize: 18)),
                  InkWell(
                    onTap: () => model.gotoUpgrade(),
                    child: Row(
                      children: const [
                        Text(
                          "Upgrade",
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(width: 10),
                        Icon(
                          Icons.arrow_upward,
                          color: BrandColors.secondary,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }

  _eachSection(String title, dynamic onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        width: double.maxFinite,
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title),
            const Icon(Icons.arrow_forward_ios_outlined, color: BrandColors.secondary,),
          ],
        ),
      ),
    );
  }
}
