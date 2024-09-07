import 'package:flutter/material.dart';
import 'package:no_name/app/locator.dart';
import 'package:no_name/core/services/auth_service.dart';
import 'package:no_name/core/utils/tools.dart';
import 'package:no_name/styles/brand_color.dart';
import 'package:no_name/views/contact_us/contact_us_view.dart';
import 'package:no_name/views/more/more_viewmodel.dart';
import 'package:no_name/widgets/utility_widgets.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../profile/profile_view.dart';

class MoreView extends StatelessWidget {
  const MoreView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MoreViewModel>.reactive(
        viewModelBuilder: () => MoreViewModel(),
        builder: (context, model, _) {
          return CustomScaffoldWidget(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: model.profileData?.imageUrl == null
                              ? const AssetImage('assets/images/image 128.png')
                              : NetworkImage(model.profileData!.imageUrl!) as ImageProvider,
                        ),
                        const SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Account details",
                              style: TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 6),
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: const Color(0xFF52C0F3),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    model.virtualAccount?.bankName ?? '',
                                    style:
                                        const TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        model.virtualAccount?.accountNumber ?? '',
                                        style: const TextStyle(
                                            fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(width: 15),
                                      InkWell(
                                        onTap: () {
                                          copyToClipboard(model.virtualAccount!.accountNumber!,
                                              "Account number copied successfully");
                                        },
                                        child: const Icon(
                                          Icons.copy_all_outlined,
                                          color: Color(0xFFC4C4C4),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  ListTile(
                      title: const Text("Manage Profile", style: TextStyle(fontWeight: FontWeight.w900)),
                      trailing: const Icon(Icons.arrow_forward_ios_outlined, size: 18),
                      onTap: () async {
                        await NavigationService().navigateToView(const ProfileView());
                        model.notifyListeners();
                      }),
                  const SizedBox(height: 10),
                  const ListTile(
                    title: Text("Security", style: TextStyle(fontWeight: FontWeight.w900)),
                    trailing: Icon(Icons.arrow_forward_ios_outlined, size: 18),
                  ),
                  const SizedBox(height: 10),
                  ListTile(
                      title: const Text("Contact Us", style: TextStyle(fontWeight: FontWeight.w900)),
                      trailing: const Icon(Icons.arrow_forward_ios_outlined, size: 18),
                      onTap: () => NavigationService().navigateToView(const ContactUsView())),
                  const SizedBox(height: 10),
                  ListTile(
                    title: const Text("Log Out", style: TextStyle(fontWeight: FontWeight.w900)),
                    trailing: const Icon(Icons.arrow_forward_ios_outlined, size: 18),
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Container(
                              height: 350,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(40),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    const Text(
                                      "Are you sure?",
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        color: BrandColors.primary,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    const Text(
                                      "Are you sure you want to\nlogout?",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 16, color: Color(0xFFA4A9AE)),
                                    ),
                                    const SizedBox(height: 20),
                                    SizedBox(
                                      width: double.infinity,
                                      child: RoundedButton(
                                        onPressed: () => locator<AuthService>().signOut(),
                                        title: "Log Out",
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    SizedBox(
                                      width: double.infinity,
                                      child: RoundedButton(
                                        onPressed: () => Navigator.pop(context),
                                        title: "Cancel",
                                        bgColor: const Color(0xFFA4A9AE).withOpacity(.15),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
