import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
            appBar: AppBar(
              title: const Text(
                'Profile',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 19),
              ),
              leading: GestureDetector(
                onTap: Navigator.of(context).pop,
                child: Padding(
                  padding: const EdgeInsets.only(left: 17.0),
                  child: Image.asset('assets/images/Group 7768.png'),
                ),
              ),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 15.0),
                        child: Center(
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage('assets/images/image 128.png'),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Center(
                          child: Text(
                        'Yusuf',
                        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 30, color: Color(0xFF0991CC)),
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
                          const Text(
                            'Tier 1',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
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
                              // Navigator.push(context, MaterialPageRoute(builder: (context) => const Upgrade()));
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
                      const Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                  child: BuildTextField(
                                title: "First name",
                                hintText: "Yusuf",
                              )),
                              SizedBox(width: 12),
                              Expanded(
                                  child: BuildTextField(
                                title: "Last name",
                                hintText: "Lawal",
                              )),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          BuildTextField(
                            title: "Email",
                            hintText: "badmusyusuf007@gmail.com",
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          BuildTextField(
                            title: "Mobile Number",
                            hintText: "+23481275183206",
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
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
