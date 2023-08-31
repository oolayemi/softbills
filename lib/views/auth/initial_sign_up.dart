import 'package:flutter/material.dart';
import 'package:no_name/app/locator.dart';
import 'package:no_name/views/auth/sign_up/sign_up_one/sign_up_one_view.dart';
import 'package:no_name/widgets/utility_widgets.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:timeline_tile/timeline_tile.dart';

class InitialSignUpView extends StatelessWidget {
  const InitialSignUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      padding: 0.0,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 280,
                  width: double.maxFinite,
                  // decoration: const BoxDecoration(
                  //     borderRadius: BorderRadius.only(
                  //   bottomLeft: Radius.circular(10),
                  //   bottomRight: Radius.circular(10),
                  // )),
                  child: Image.asset(
                    "assets/images/background/bills_payment.webp",
                    fit: BoxFit.fill,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * .85,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Thank you for choosing SoftBills",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Below are a few steps required to get you started.",
                          style: TextStyle(fontSize: 19),
                        ),
                        const SizedBox(height: 20),
                        _buildTimelineTile(
                          "Enter your Personal Information",
                          "",
                          isFirst: true,
                        ),
                        _buildTimelineTile(
                          "Verify your  Phone Number",
                          "",
                        ),
                        _buildTimelineTile(
                          "Enter your Personal Information",
                          "",
                          isLast: true,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Positioned(
              bottom: 15,
              right: 0,
              left: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: RoundedButton(
                    title: "Alright, I'm in!",
                    onPressed: () {
                      NavigationService navigatorService =
                          locator<NavigationService>();
                      navigatorService.clearStackAndShowView(const SignUpOneView());
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }

  _buildTimelineTile(String title, String subtitle,
      {bool isFirst = false, bool isLast = false}) {
    return TimelineTile(
      alignment: TimelineAlign.manual,
      lineXY: 0.1,
      isFirst: isFirst,
      isLast: isLast,
      indicatorStyle: IndicatorStyle(
        width: 30,
        height: 30,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        indicator: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.black,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black, width: 2.0)),
          child: const SizedBox(),
        ),
      ),
      endChild: Padding(
        padding: const EdgeInsets.only(left: 0.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
            ),
          ],
        ),
      ),
      beforeLineStyle: const LineStyle(thickness: 10),
    );
  }
}
