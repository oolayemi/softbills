import 'package:flutter/material.dart';
import 'package:no_name/app/locator.dart';
import 'package:no_name/views/upgrade/upgrade_view.dart';
import 'package:no_name/widgets/utility_widgets.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'profile_viewmodel.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
        viewModelBuilder: () => ProfileViewModel(),
        onViewModelReady: (model) => model.setUp(),
        builder: (context, model, child) {
          return CustomScaffoldWidget(
            appBar: const CustomAppBar(
              title: "Profile",
            ),
            body: SingleChildScrollView(
              child: Form(
                key: model.formKey,
                child: Column(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: Center(
                            child: InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return ImageSourcePopup(model: model);
                                  },
                                );
                              },
                              child: CircleAvatar(
                                radius: 40,
                                backgroundImage: model.image == null
                                    ? model.profileData!.imageUrl != null
                                        ? NetworkImage(model.profileData!.imageUrl!)
                                        : const AssetImage("assets/images/image 128.png") as ImageProvider
                                    : FileImage(model.image!),
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Positioned(
                                      right: 28,
                                      left: 28,
                                      bottom: -10,
                                      child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          padding: const EdgeInsets.all(3),
                                          child: const Icon(Icons.camera_alt_outlined, color: Colors.white, size: 16)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Center(
                            child: Text(
                          model.profileData?.firstname ?? "N/A",
                          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18, color: Color(0xFF0991CC)),
                        )),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/Vector (8).png',
                              height: 16,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Tier ${model.profileData?.tier ?? "0"}',
                              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        model.profileData!.tier! < 3
                            ? Column(
                                children: [
                                  Center(
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width * .65,
                                      child: const Text(
                                        'Upgrade to increase your balance limit and have access to our credit feature',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  SizedBox(
                                    width: 150,
                                    height: 30,
                                    child: Center(
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          await locator<NavigationService>().navigateToView(const UpgradeView());
                                          model.notifyListeners();
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color(0XFFF58634),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(5),
                                          ),
                                        ),
                                        child: const Text(
                                          'Upgrade',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : const SizedBox(),
                        const SizedBox(height: 20),
                        Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: BuildTextField(
                                    title: "First name",
                                    hintText: "firstname",
                                    controller: model.firstNameController,
                                    validator: (value) => value!.isEmpty ? "First name field cannot be empty" : null,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                    child: BuildTextField(
                                  title: "Last name",
                                  hintText: "lastname",
                                  controller: model.lastNameController,
                                )),
                              ],
                            ),
                            BuildTextField(
                              title: "Email",
                              hintText: "email",
                              initialValue: model.profileData?.email,
                              enabled: false,
                            ),
                            BuildTextField(
                              title: "Mobile Number",
                              hintText: "mobile number",
                              textInputType: TextInputType.number,
                              maxLength: 11,
                              controller: model.phoneNumberController,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: RoundedButton(
                            title: "Update profile",
                            onPressed: () {
                              if (model.formKey.currentState!.validate()) {
                                model.updateProfile(context);
                              }
                            },
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
