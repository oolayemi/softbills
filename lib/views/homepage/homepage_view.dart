import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:no_name/styles/brand_color.dart';
import 'package:no_name/views/homepage/homepage_viewmodel.dart';
import 'package:no_name/views/profile/profile_view.dart';
import 'package:stacked/stacked.dart';

import '../../widgets/utility_widgets.dart';

class HomePageView extends StatelessWidget {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomePageViewModel>.reactive(
        viewModelBuilder: () => HomePageViewModel(),
        onModelReady: (model) => model.setUp(),
        builder: (context, model, child) {
          Widget quickLinks(String title, String imageUrl, Color bgColor, Function()? onTap) {
            return InkWell(
              onTap: onTap,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: bgColor),
                    child: Center(child: SvgPicture.asset(imageUrl)),
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .20,
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            );
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Column(
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
                                      child: const Padding(
                                        padding: EdgeInsets.only(left: 15.0, top: 10),
                                        child: CircleAvatar(
                                          radius: 30,
                                          backgroundImage: AssetImage('assets/images/image 128.png'),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 8,
                                      right: 0,
                                      child: Container(
                                        width: 12,
                                        height: 12,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xFFE73726),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 10),
                              const Text(
                                'Hi, Yusuf',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0, right: 15),
                            child: SizedBox(
                              child: Card(
                                color: const Color(0xFF0991CC),
                                elevation: 4.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              const Text(
                                                'Balance',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w800,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              const SizedBox(width: 15),
                                              GestureDetector(
                                                onTap: () {
                                                  model.isSwitchedOn = !model.isSwitchedOn;
                                                  model.notifyListeners();
                                                },
                                                child: AnimatedContainer(
                                                  duration: const Duration(milliseconds: 300),
                                                  width: 40,
                                                  height: 20,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(15.0),
                                                    color: model.isSwitchedOn ? const Color(0xFFF58634) : const Color(0xFFF58634),
                                                  ),
                                                  child: Stack(
                                                    children: [
                                                      AnimatedPositioned(
                                                        duration: const Duration(milliseconds: 300),
                                                        curve: Curves.easeIn,
                                                        left: model.isSwitchedOn ? 20.0 : 0.0,
                                                        right: model.isSwitchedOn ? 0.0 : 20.0,
                                                        child: AnimatedSwitcher(
                                                          duration: const Duration(milliseconds: 300),
                                                          transitionBuilder: (Widget child, Animation<double> animation) {
                                                            return ScaleTransition(scale: animation, child: child);
                                                          },
                                                          child: model.isSwitchedOn
                                                              ? Icon(Icons.circle, color: Colors.white, size: 20, key: UniqueKey())
                                                              : Icon(Icons.circle, color: Colors.white, size: 20, key: UniqueKey()),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Text(
                                            'Transaction History >',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(top: 0),
                                        child: Text(
                                          '\u20A6250,000,000',
                                          style: TextStyle(
                                            fontSize: 25,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(3),
                                              decoration: BoxDecoration(
                                                  color: const Color(0xFFC4C4C4).withOpacity(.4), borderRadius: BorderRadius.circular(10)),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  const Text(
                                                    '0156275348',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 13),
                                                  GestureDetector(
                                                    child: const Icon(
                                                      Icons.copy_rounded,
                                                      size: 20,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                                              decoration: BoxDecoration(
                                                color: const Color(0xFFC4C4C4).withOpacity(.4),
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              child: const Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Icon(
                                                    Icons.add_circle_outline_outlined,
                                                    size: 24,
                                                    color: Colors.white,
                                                  ),
                                                  SizedBox(width: 4),
                                                  Text(
                                                    'Fund account',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Container(
                        padding: const EdgeInsets.all(25),
                        decoration: BoxDecoration(
                          color: const Color(0xFFD9D9D9).withOpacity(.5),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(50.0),
                            topRight: Radius.circular(50.0),
                          ),
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        quickLinks("Internet Recharge", "assets/icons/network.svg", const Color(0xFFF58634).withOpacity(.1),
                                            () => model.gotoData()),
                                        quickLinks("Mobile Recharge", "assets/icons/mobile.svg", const Color(0xFF0F8CC3).withOpacity(.1),
                                            () => model.gotoAirtime()),
                                        quickLinks("Transfer", "assets/icons/two-way-arrow.svg", const Color(0xFF05FABF).withOpacity(.1),
                                            () => model.gotoTransfer()),
                                      ],
                                    ),
                                    const SizedBox(height: 18),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        quickLinks("Electricity Bill", "assets/icons/lightbulb.svg",
                                            const Color(0xFF345AFA).withOpacity(.1), null),
                                        quickLinks("Store", "assets/icons/shopping-bag.svg", const Color(0xFF9F05B8).withOpacity(.1), null),
                                        quickLinks("More", "assets/icons/add.svg", const Color(0xFFF58634).withOpacity(.1), null),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 20), // Add spacing between the card and the picture
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: Image.asset(
                                'assets/images/banner_image.png',
                                fit: BoxFit.fill,
                              ),
                            ),
                            const SizedBox(height: 60),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  _fundAccountPopUp(context, HomePageViewModel model) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(builder: (BuildContext context, StateSetter setModalState) {
          return ClipRRect(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(24),
              topLeft: Radius.circular(24),
            ),
            child: Container(
              color: BrandColors.mainBackground,
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                top: 20,
                right: 20,
                left: 20,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(width: 1.2),
                        ),
                        child: InkWell(
                          onTap: () => Navigator.pop(context),
                          child: const Center(
                            child: Icon(
                              Icons.arrow_back_ios_new,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                      const Expanded(
                        child: Center(
                          child: Text(
                            "Fund your account",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * .8,
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Add funds to your account by making a bank transfer from your Nigerian bank account.",
                              textAlign: TextAlign.center)
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Account Name", style: TextStyle(fontSize: 14)),
                                  Text(model.wallet?.virtualAccount?.accountName ?? "N/A",
                                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                                ],
                              )
                            ],
                          ),
                          const Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Bank Name", style: TextStyle(fontSize: 14)),
                                  Text(model.wallet?.virtualAccount?.bankName ?? "N/A",
                                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                                ],
                              )
                            ],
                          ),
                          const Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Account Number", style: TextStyle(fontSize: 14)),
                                  Text(model.wallet?.virtualAccount?.accountNumber ?? "N/A",
                                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: RoundedButton(
                        title: "Share Details",
                        onPressed: () {
                          String data = "Account name: ${model.wallet?.virtualAccount?.accountName ?? "N/A"}\n"
                              "Account number: ${model.wallet?.virtualAccount?.accountNumber ?? "N/A"}\n"
                              "Bank name: ${model.wallet?.virtualAccount?.bankName ?? "N/A"}";
                          Clipboard.setData(ClipboardData(text: data));
                          Fluttertoast.showToast(msg: "Account details copied", backgroundColor: Colors.green);
                        }),
                  ),
                  const SizedBox(height: 30)
                ],
              ),
            ),
          );
        });
      },
      // return showModalBottomSheet(
      //   context: context,
      //   isScrollControlled: true,
      //   backgroundColor: Colors.transparent,
      //   builder: (context) {
      //     return StatefulBuilder(builder: (BuildContext context, StateSetter setModalState) {
      //       return ClipRRect(
      //         borderRadius: const BorderRadius.only(
      //           topRight: Radius.circular(24),
      //           topLeft: Radius.circular(24),
      //         ),
      //         child: Container(
      //           color: BrandColors.darkBlueBackground,
      //           padding: EdgeInsets.only(
      //             bottom: MediaQuery.of(context).viewInsets.bottom,
      //             top: 20,
      //             right: 20,
      //             left: 20,
      //           ),
      //           child: Column(
      //             mainAxisSize: MainAxisSize.min,
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: [
      //               Row(
      //                 children: [
      //                   Container(
      //                     height: 30,
      //                     width: 30,
      //                     decoration: BoxDecoration(
      //                       shape: BoxShape.circle,
      //                       border: Border.all(width: 1.2),
      //                     ),
      //                     child: InkWell(
      //                       onTap: () => Navigator.pop(context),
      //                       child: const Center(
      //                         child: Icon(
      //                           Icons.arrow_back_ios_new,
      //                           size: 20,
      //                         ),
      //                       ),
      //                     ),
      //                   ),
      //                   const SizedBox(width: 20),
      //                   const Text(
      //                     "Fund Account",
      //                     style: TextStyle(fontSize: 18),
      //                   )
      //                 ],
      //               ),
      //               const SizedBox(height: 15),
      //               SizedBox(
      //                 width: MediaQuery.of(context).size.width * .8,
      //                 child: const Text(
      //                   "How much do you want to fund?",
      //                   style: TextStyle(fontSize: 22),
      //                 ),
      //               ),
      //               const SizedBox(height: 25),
      //               const AmountTextField(title: "Amount"),
      //               const SizedBox(height: 25),
      //               const Text(
      //                 "Which account?",
      //                 style: TextStyle(fontSize: 16),
      //               ),
      //               const SizedBox(height: 5),
      //               Row(
      //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                 children: [
      //                   InkWell(
      //                     onTap: () {
      //                       model.paymentOption = 0;
      //                       setModalState(() {});
      //                     },
      //                     child: Container(
      //                       padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      //                       width: MediaQuery.of(context).size.width * .42,
      //                       decoration: BoxDecoration(
      //                         color: model.paymentOption == 0 ? const Color(0xFF3200E0) : null,
      //                         border: Border.all(color: Colors.grey, width: 1),
      //                         borderRadius: BorderRadius.circular(10.0),
      //                       ),
      //                       child: Row(
      //                         children: [
      //                           Radio(
      //                               value: 0,
      //                               activeColor: BrandColors.secondary,
      //                               visualDensity: const VisualDensity(
      //                                   horizontal: VisualDensity.minimumDensity, vertical: VisualDensity.minimumDensity),
      //                               groupValue: model.paymentOption,
      //                               onChanged: (value) {
      //                                 model.paymentOption = 0;
      //                                 setModalState(() {});
      //                               }),
      //                           const Text(
      //                             'BTC Account',
      //                             style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
      //                           ),
      //                         ],
      //                       ),
      //                     ),
      //                   ),
      //                   InkWell(
      //                     onTap: () {
      //                       model.paymentOption = 1;
      //                       setModalState(() {});
      //                     },
      //                     child: Container(
      //                       padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      //                       width: MediaQuery.of(context).size.width * .42,
      //                       decoration: BoxDecoration(
      //                         color: model.paymentOption == 1 ? const Color(0xFF3200E0) : null,
      //                         border: Border.all(color: Colors.grey, width: 1),
      //                         borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      //                       ),
      //                       child: Row(
      //                         children: [
      //                           Radio(
      //                               value: 1,
      //                               activeColor: BrandColors.secondary,
      //                               visualDensity: const VisualDensity(
      //                                   horizontal: VisualDensity.minimumDensity, vertical: VisualDensity.minimumDensity),
      //                               groupValue: model.paymentOption,
      //                               onChanged: (value) {
      //                                 model.paymentOption = 1;
      //                                 setModalState(() {});
      //                               }),
      //                           const Text(
      //                             'Naira Account',
      //                             style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
      //                           ),
      //                         ],
      //                       ),
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //               const SizedBox(height: 25),
      //               const Text(
      //                 "Please Note: 1USD = N750",
      //                 style: TextStyle(fontSize: 18),
      //               ),
      //               const SizedBox(height: 80),
      //               const SizedBox(
      //                 width: double.maxFinite,
      //                 child: RoundedButton(title: "Proceed"),
      //               ),
      //               const SizedBox(height: 20)
      //             ],
      //           ),
      //         ),
      //       );
      //     });
      //   },
    );
  }

  _selectWalletPopUp(context, HomePageViewModel model) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(builder: (BuildContext context, StateSetter setModalState) {
          return ClipRRect(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(24),
              topLeft: Radius.circular(24),
            ),
            child: Container(
              color: BrandColors.darkBlueBackground,
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(width: 1.2)),
                        child: InkWell(
                          onTap: () => Navigator.pop(context),
                          child: const Center(
                            child: Icon(
                              Icons.arrow_back_ios_new,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      const Text(
                        "Select Wallet",
                        style: TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                  const SizedBox(height: 25),
                  const Column(
                      //     children: model.walletTypes!.map((e) {
                      //   return InkWell(
                      //     onTap: () {
                      //       model.setWalletOption(e);
                      //       setModalState(() {});
                      //       Navigator.pop(context);
                      //     },
                      //     child: Container(
                      //       width: double.infinity,
                      //       margin: const EdgeInsets.only(bottom: 10),
                      //       padding: const EdgeInsets.symmetric(
                      //           vertical: 15, horizontal: 20),
                      //       decoration: BoxDecoration(
                      //         color:
                      //             model.selectedWallet!.walletType == e.walletType
                      //                 ? const Color(0xFF3200E0)
                      //                 : null,
                      //         border: Border.all(color: Colors.grey, width: 1),
                      //         borderRadius: BorderRadius.circular(10.0),
                      //       ),
                      //       child: Row(
                      //         children: [
                      //           Radio(
                      //               value: e,
                      //               activeColor: BrandColors.secondary,
                      //               visualDensity: const VisualDensity(
                      //                   horizontal: VisualDensity.minimumDensity,
                      //                   vertical: VisualDensity.minimumDensity),
                      //               groupValue: model.selectedWallet,
                      //               onChanged: (value) {
                      //                 model.setWalletOption(e);
                      //                 setModalState(() {});
                      //                 Navigator.pop(context);
                      //               }),
                      //           Text(
                      //             '${ucWord(e.walletType!)} Account',
                      //             style: const TextStyle(
                      //                 fontSize: 14.0, fontWeight: FontWeight.w500),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   );
                      // }).toList()
                      // [
                      //
                      //   const SizedBox(height: 15),
                      //   InkWell(
                      //     onTap: () {
                      //       model.setWalletOption('naira');
                      //       setModalState(() {});
                      //       Navigator.pop(context);
                      //     },
                      //     child: Container(
                      //       width: double.infinity,
                      //       padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                      //       decoration: BoxDecoration(
                      //         color: model.selectedWallet == 'naira' ? const Color(0xFF3200E0) : null,
                      //         border: Border.all(color: Colors.grey, width: 1),
                      //         borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                      //       ),
                      //       child: Row(
                      //         children: [
                      //           Radio(
                      //               value: 'naira',
                      //               activeColor: BrandColors.secondary,
                      //               visualDensity: const VisualDensity(
                      //                   horizontal: VisualDensity.minimumDensity, vertical: VisualDensity.minimumDensity),
                      //               groupValue: model.selectedWallet,
                      //               onChanged: (value) {
                      //                 model.setWalletOption('naira');
                      //                 setModalState(() {});
                      //                 Navigator.pop(context);
                      //               }),
                      //           const Text(
                      //             'Naira Account',
                      //             style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // ],
                      ),
                  const SizedBox(height: 25),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .65,
                    child: Text(
                      "Your balances and transactions reflects in whatever currency you select",
                      style: TextStyle(fontSize: 14, color: Colors.white.withOpacity(.66)),
                    ),
                  ),
                  const SizedBox(height: 25),
                ],
              ),
            ),
          );
        });
      },
    );
  }
}
