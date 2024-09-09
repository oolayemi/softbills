import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:no_name/styles/brand_color.dart';
import 'package:no_name/views/credit/credit_viewmodel.dart';
import 'package:no_name/widgets/utility_widgets.dart';
import 'package:stacked/stacked.dart';

import '../profile/profile_view.dart';

class CreditView extends StatelessWidget {
  const CreditView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CreditViewModel>.reactive(
      viewModelBuilder: () => CreditViewModel(),
      builder: (context, model, _) {
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
                const SizedBox(height: 20),
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 100,
                            padding: const EdgeInsets.only(top: 15, left: 10),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: const Color(0xFF13C999).withOpacity(.15),
                              borderRadius: BorderRadius.circular(20)
                            ),
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Credit Limit", style: TextStyle(fontSize: 22, color: Color(0xFF13C999))),
                                Text("N5000", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900, color: Color(0xFF13C999))),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Container(
                            height: 100,
                            padding: const EdgeInsets.only(top: 15, left: 10),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: const Color(0xFFFF6363).withOpacity(.15),
                                borderRadius: BorderRadius.circular(20)
                            ),
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Loan Period", style: TextStyle(fontSize: 22, color: Color(0xFFFF6363))),
                                Text("30 Days", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900, color: Color(0xFFFF6363))),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Container(
                      height: 170,
                      padding: const EdgeInsets.all(22),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: const Color(0xFF095F85).withOpacity(.10),
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Softpay Loan", style: TextStyle(fontSize: 18, color: Color(0xFF095F85))),
                          const Text("N0.00", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900, color: Color(0xFF095F85))),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Due Date", style: TextStyle(fontSize: 16, color: Color(0xFF095F85))),
                                  Text("--", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Color(0xFF095F85))),
                                ],
                              ),
                              InkWell(
                                onTap: () {
                                  // NavigationService().navigateToView(const FundAccountView());
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: BrandColors.primary,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(
                                        Icons.add_circle_outline_outlined,
                                        size: 20,
                                        color: Colors.white,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        'Borrow Now',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      }
    );
  }
}
