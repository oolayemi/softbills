import 'package:flutter/material.dart';
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
      body: Column(),
    );
  }
}
