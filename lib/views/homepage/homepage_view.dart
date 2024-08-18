import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:no_name/core/utils/tools.dart';
import 'package:no_name/views/fund_account/fund_account_view.dart';
import 'package:no_name/views/homepage/homepage_viewmodel.dart';
import 'package:no_name/views/profile/profile_view.dart';
import 'package:no_name/views/transactions/transaction_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomePageView extends StatelessWidget {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomePageViewModel>.reactive(
        viewModelBuilder: () => HomePageViewModel(),
        onViewModelReady: (model) => model.setUp(),
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
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 15.0, top: 10),
                                        child: CircleAvatar(
                                          radius: 30,
                                          backgroundImage: model.profileData?.imageUrl == null
                                              ? const AssetImage('assets/images/image 128.png')
                                              : NetworkImage(model.profileData!.imageUrl!) as ImageProvider,
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
                              Text(
                                'Hi, ${model.profileData?.firstname ?? "N/A"}',
                                style: const TextStyle(
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
                                  padding: const EdgeInsets.symmetric(vertical: 28.0, horizontal: 16),
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
                                                    color: model.isSwitchedOn
                                                        ? const Color(0xFFF58634)
                                                        : const Color(0xFFF58634),
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
                                                          transitionBuilder:
                                                              (Widget child, Animation<double> animation) {
                                                            return ScaleTransition(scale: animation, child: child);
                                                          },
                                                          child: model.isSwitchedOn
                                                              ? Icon(Icons.circle,
                                                                  color: Colors.white, size: 20, key: UniqueKey())
                                                              : Icon(Icons.circle,
                                                                  color: Colors.white, size: 20, key: UniqueKey()),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          InkWell(
                                            onTap: () {
                                              NavigationService().navigateToView(const TransactionView());
                                            },
                                            child: const Text(
                                              'Transaction History >',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 0),
                                        child: Text(
                                          formatMoney(model.wallet?.balance ?? 0),
                                          // '\u20A6${formatMoney(model.wallet?.balance ?? 0)}',
                                          style: const TextStyle(
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
                                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                                              decoration: BoxDecoration(
                                                color: const Color(0xFFC4C4C4).withOpacity(.4),
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    model.wallet?.number ?? "N/A",
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 13),
                                                  GestureDetector(
                                                    onTap: () {
                                                      if (model.wallet?.number != null) {
                                                        copyToClipboard(
                                                          model.wallet!.number!,
                                                          "Wallet number copied successfully",
                                                        );
                                                      }
                                                    },
                                                    child: const Icon(
                                                      Icons.copy_rounded,
                                                      size: 20,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                NavigationService().navigateToView(const FundAccountView());
                                              },
                                              child: Container(
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
                                        quickLinks("Internet Recharge", "assets/icons/network.svg",
                                            const Color(0xFFF58634).withOpacity(.1), () => model.gotoData()),
                                        quickLinks("Mobile Recharge", "assets/icons/mobile.svg",
                                            const Color(0xFF0F8CC3).withOpacity(.1), () => model.gotoAirtime()),
                                        quickLinks("Transfer", "assets/icons/two-way-arrow.svg",
                                            const Color(0xFF05FABF).withOpacity(.1), () => model.gotoTransfer()),
                                      ],
                                    ),
                                    const SizedBox(height: 18),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        quickLinks("Electricity Bill", "assets/icons/lightbulb.svg",
                                            const Color(0xFF345AFA).withOpacity(.1), () => model.gotoElectricity()),
                                        quickLinks("Store", "assets/icons/shopping-bag.svg",
                                            const Color(0xFF9F05B8).withOpacity(.1), null),
                                        quickLinks("More", "assets/icons/add.svg",
                                            const Color(0xFFF58634).withOpacity(.1), null),
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
}
