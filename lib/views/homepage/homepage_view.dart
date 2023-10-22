import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:no_name/core/utils/tools.dart';
import 'package:no_name/styles/brand_color.dart';
import 'package:no_name/views/homepage/homepage_viewmodel.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:stacked/stacked.dart';

import '../../widgets/transaction_history.dart';
import '../../widgets/utility_widgets.dart';

class HomePageView extends StatelessWidget {
  const HomePageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomePageViewModel>.reactive(
        viewModelBuilder: () => HomePageViewModel(),
        onModelReady: (model) => model.setUp(),
        builder: (context, model, child) {
          return Scaffold(
            backgroundColor: const Color(0xFFEEF0F2),
            body: SafeArea(
              child: SmartRefresher(
                enablePullDown: true,
                header: const WaterDropHeader(),
                controller: model.refreshController,
                onRefresh: model.onRefresh,
                onLoading: model.onLoading,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Hello ${model.profileData?.firstname},",
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                          // SvgPicture.asset("assets/icons/qr_code.svg", height: 35),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              _walletCard(context, model),
                              const SizedBox(height: 30),
                              _quickLinks(),
                              // const SizedBox(height: 30),
                              // Image.asset("assets/images/intro.png", fit: BoxFit.fitWidth),
                              const SizedBox(height: 30),
                              _recentTransactions(context),
                              const SizedBox(height: 15),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget _walletCard(context, HomePageViewModel model) {
    return Container(
      height: 170,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              BrandColors.primary,
              BrandColors.primary,
            ],
          ),
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Row(
            children: const [
              Text("Balance",
                  style: TextStyle(fontSize: 16, color: Colors.white)),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Text.rich(
                TextSpan(
                  text: model.viewBalance
                      ? formatMoney(model.wallet?.balance.toString() ?? "0")
                      : "*****",
                  style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w900,
                      color: Colors.white),
                  children: const <TextSpan>[
                    TextSpan(
                      text: "",
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 15),
              InkWell(
                onTap: () => model.toggleViewBalance(),
                child: Row(
                  children: [
                    Icon(
                      !model.viewBalance
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      !model.viewBalance ? "Show" : "Hide",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              )
            ],
          ),
          const Expanded(child: SizedBox()),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 140,
                height: 38,
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.2),
                    borderRadius: BorderRadius.circular(35)),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        model.wallet?.number,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Clipboard.setData(
                            ClipboardData(text: model.wallet?.number));
                        Fluttertoast.showToast(
                            msg: "Account number copied",
                            backgroundColor: Colors.green);
                      },
                      child: const Icon(Icons.copy, color: Colors.white),
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: () => _fundAccountPopUp(context, model),
                child: Container(
                  width: 100,
                  height: 38,
                  //padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.2),
                      borderRadius: BorderRadius.circular(35)),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white.withOpacity(.2),
                        radius: 20,
                        child: const Icon(
                          Icons.add,
                          size: 35,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        "Fund",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _quickLinks() {
    HomePageViewModel model = HomePageViewModel();
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            EachRoundLink(
              icon: Icons.phone_android_outlined,
              title: "Airtime",
              onTap: () => model.gotoAirtime(),
            ),
            EachRoundLink(
                icon: Icons.wifi,
                title: "Data",
                onTap: () {
                  model.gotoData();
                }),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            EachRoundLink(
                icon: Icons.sports_basketball_outlined,
                title: "Betting",
                onTap: () {
                  model.gotoBetting();
                }),
            EachRoundLink(
                icon: Icons.tv_rounded,
                title: "Cable TV",
                onTap: () {
                  model.gotoCableTV();
                }),
          ],
        ),
        // const SizedBox(height: 10),
        // EachLink(
        //     icon: Icons.wifi_tethering,
        //     title: "SME Data",
        //     onTap: () {
        //       model.gotoSmeData();
        //     }),
      ],
    );
  }

  _recentTransactions(context) {
    HomePageViewModel model = HomePageViewModel();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Recent Transactions",
              style: TextStyle(fontSize: 18),
            ),
            InkWell(
              onTap: () {
                model.gotoSeeAllTransactions();
              },
              child: const Text(
                "See All",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        eachTransaction(context),
        eachTransaction(context),
        eachTransaction(context),
        eachTransaction(context),
        // RecentTransactionSection(
        //     transactionList: model.transactions!.take(5).toList(),
        // )
      ],
    );
  }

  Widget eachTransaction(context, {bool isLast = false}) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  color: BrandColors.secondary.withOpacity(.3), width: 1)),
          child: ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TransactionHistory()),
              );
            },
            leading: Container(
              height: 40,
              width: 40,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: BrandColors.secondary),
              child: const Center(
                child: Icon(Icons.outbound_outlined, color: Colors.white,),
              ),
            ),
            horizontalTitleGap: 8,
            title: const Text(
              "Airtime worth of 300k and 200k",
              maxLines: 1,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            subtitle: Text(
              DateFormat('hh:mm a').format(DateTime.now()),
              style: const TextStyle(fontSize: 14),
            ),
            trailing: Text(
              formatMoney("123.32"),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8)
      ],
    );
  }

  _fundAccountPopUp(context, HomePageViewModel model) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setModalState) {
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
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * .8,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                              "Add funds to your account by making a bank transfer from your Nigerian bank account.",
                              textAlign: TextAlign.center)
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
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
                                  const Text("Account Name",
                                      style: TextStyle(fontSize: 14)),
                                  Text(
                                      model.wallet?.virtualAccount
                                              ?.accountName ??
                                          "N/A",
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold)),
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
                                  const Text("Bank Name",
                                      style: TextStyle(fontSize: 14)),
                                  Text(
                                      model.wallet?.virtualAccount?.bankName ??
                                          "N/A",
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold)),
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
                                  const Text("Account Number",
                                      style: TextStyle(fontSize: 14)),
                                  Text(
                                      model.wallet?.virtualAccount
                                              ?.accountNumber ??
                                          "N/A",
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold)),
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
                          String data =
                              "Account name: ${model.wallet?.virtualAccount?.accountName ?? "N/A"}\n"
                              "Account number: ${model.wallet?.virtualAccount?.accountNumber ?? "N/A"}\n"
                              "Bank name: ${model.wallet?.virtualAccount?.bankName ?? "N/A"}";
                          Clipboard.setData(ClipboardData(text: data));
                          Fluttertoast.showToast(
                              msg: "Account details copied",
                              backgroundColor: Colors.green);
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
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setModalState) {
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
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(width: 1.2)),
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
                  Column(
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
                      style: TextStyle(
                          fontSize: 14, color: Colors.white.withOpacity(.66)),
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
