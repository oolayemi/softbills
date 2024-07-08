import 'package:flutter/material.dart';
import 'package:no_name/views/upgrade/upgrade_view.dart';
import 'package:no_name/widgets/utility_widgets.dart';
import 'package:stacked/stacked.dart';

import 'profile_viewmodel.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
        viewModelBuilder: () => ProfileViewModel(),
        // onModelReady: (model) => model.setUp(),
        builder: (context, model, child) {
          return CustomScaffoldWidget(
            appBar: const CustomAppBar(
              title: "Profile",
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Center(
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: model.profileData?.imageUrl == null
                                ? const AssetImage('assets/images/image 128.png')
                                : NetworkImage(model.profileData!.imageUrl!) as ImageProvider,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                          child: Text(
                        model.profileData?.firstname ?? "N/A",
                        style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 22, color: Color(0xFF0991CC)),
                      )),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/Vector (8).png'),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Tier ${model.profileData?.tier ?? "0"}',
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Center(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * .7,
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
                        height: 40,
                        child: Center(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const UpgradeView()));
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
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: BuildTextField(
                                  title: "First name",
                                  hintText: "firstname",
                                  initialValue: model.profileData?.firstname,
                                )),
                              const SizedBox(width: 12),
                              Expanded(
                                  child: BuildTextField(
                                title: "Last name",
                                hintText: "lastname",
                                initialValue: model.profileData?.lastname,
                              )),
                            ],
                          ),
                          BuildTextField(
                            title: "Email",
                            hintText: "email",
                            initialValue: model.profileData?.email,
                          ),
                          BuildTextField(
                            title: "Mobile Number",
                            hintText: "mobile number",
                            initialValue: model.profileData?.phone,
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
                          onPressed: () {},
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
