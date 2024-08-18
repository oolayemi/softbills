import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:no_name/widgets/utility_widgets.dart';

import '../profile/profile_view.dart';

class TransactionView extends StatelessWidget {
  const TransactionView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      appBar: CustomAppBar(
        title: "Transactions",
        actions: [
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
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 7),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(.3),
                    blurRadius: 20.0,
                    spreadRadius: .5,
                    offset: Offset(
                      0.4,
                      12.4,
                    ),
                  )
                ],
              ),
              child: Row(
                children: [
                  Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(15),
                      )),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Airtime",
                          style: TextStyle(fontWeight: FontWeight.w600),
                          maxLines: 1,
                        ),
                        Text(
                          "4:34 PM",
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SvgPicture.asset("assets/svg/inward.svg"),
                      Text(
                        "N6,000",
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
