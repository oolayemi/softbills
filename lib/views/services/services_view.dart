import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:no_name/views/services/services_viewmodel.dart';
import 'package:no_name/widgets/utility_widgets.dart';
import 'package:stacked/stacked.dart';

import '../profile/profile_view.dart';

class ServicesView extends StatelessWidget {
  const ServicesView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ServicesViewModel>.reactive(
      viewModelBuilder: () => ServicesViewModel(),
      builder: (context, model, child) {

        Widget quickLinks(String title, String imageUrl, Color bgColor, Function()? onTap) {
          return InkWell(
            onTap: onTap,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 65,
                  height: 65,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: bgColor
                  ),
                  child: Center(child: SvgPicture.asset(imageUrl, color: const Color(0xFF0F8CC3),),),
                ),
                const SizedBox(height: 5),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .20,
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          );
        }

        Widget buildRecent(context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Recents", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),),
              const SizedBox(height: 20),
              SingleChildScrollView(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    quickLinks("Internet Recharge", "assets/icons/network.svg", const Color(0xFF0F8CC3).withOpacity(.1), () => model.gotoData()),
                    quickLinks("Mobile Recharge", "assets/icons/mobile.svg", const Color(0xFF0F8CC3).withOpacity(.1),  () => model.gotoAirtime()),
                    quickLinks("Transfer", "assets/icons/two-way-arrow.svg", const Color(0xFF0F8CC3).withOpacity(.1), () => model.gotoTransfer()),
                  ],
                ),
              )
            ],
          );
        }
        Widget buildBillsPayment(context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Bill Payments", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),),
              const SizedBox(height: 20),
              Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      quickLinks("Internet Recharge", "assets/icons/network.svg", const Color(0xFF0F8CC3).withOpacity(.1), () => model.gotoData()),
                      quickLinks("Mobile Recharge", "assets/icons/mobile.svg", const Color(0xFF0F8CC3).withOpacity(.1), () => model.gotoAirtime()),
                      quickLinks("Transfer", "assets/icons/two-way-arrow.svg", const Color(0xFF0F8CC3).withOpacity(.1), () => model.gotoTransfer()),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      quickLinks("Electricity Bill", "assets/icons/lightbulb.svg", const Color(0xFF0F8CC3).withOpacity(.1), () => model.gotoElectricity()),
                      quickLinks("Airtime to Cash", "assets/icons/airtime-to-cash.svg", const Color(0xFF0F8CC3).withOpacity(.1), null),
                      quickLinks("Store", "assets/icons/shopping-bag.svg", const Color(0xFF0F8CC3).withOpacity(.1), null),

                    ],
                  ),
                  const SizedBox(height: 10),
                  // Row(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     quickLinks("Waste Bill", "assets/icons/waste-bill.svg", const Color(0xFF0F8CC3).withOpacity(.1), null),
                  //     quickLinks("Travel", "assets/icons/plan.svg", const Color(0xFF0F8CC3).withOpacity(.1), null),
                  //   ],
                  // ),
                ],
              )
            ],
          );
        }

        return CustomScaffoldWidget(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ProfileView(),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: CircleAvatar(
                                radius: 30,
                                backgroundImage: model.profileData?.imageUrl == null
                                    ? const AssetImage('assets/images/image 128.png')
                                    : NetworkImage(model.profileData!.imageUrl!) as ImageProvider,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      'Hi, ${model.profileData?.firstname ?? ''}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      buildRecent(context),
                      const SizedBox(height: 30),
                      buildBillsPayment(context)
                    ],
                  ),
                ),
                const SizedBox(height: 60),
            
              ],
            ),
          ),
        );
      },
    );
  }
}
