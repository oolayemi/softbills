import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:no_name/views/homepage/homepage_view.dart';
import 'package:no_name/views/services/services_view.dart';
import 'package:stacked/stacked.dart';

import '../../styles/brand_color.dart';
import '../account/account_view.dart';
import 'dashboard_viewmodel.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DashboardViewModel>.reactive(
      onModelReady: (model) => model.setup(),
      viewModelBuilder: () => DashboardViewModel(),
      builder: (context, model, child) {
        List<Widget> buildScreens() {
          return [
            const HomePageView(),
            const ServicesView(),
            const AccountView(),
          ];
        }

        getSVG(assetName, {Color? color}) {
          return Padding(
            padding: const EdgeInsets.all(2.0),
            child: SvgPicture.asset(
              "assets/icons/nav_bar/$assetName",
              height: 25,
              width: 25,
              color: color,
            ),

          );
        }

        return Scaffold(
          body: IndexedStack(
            index: model.selectedIndex,
            children: buildScreens(),
          ),
          bottomNavigationBar: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Divider(
                thickness: .2,
                height: .5,
              ),
              BottomNavigationBar(
                backgroundColor: BrandColors.mainBackground,
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home_filled),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_bag_outlined),
                    label: 'Services',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person_outlined),
                    label: 'Account',
                  ),
                ],
                currentIndex: model.selectedIndex,
                selectedItemColor: Colors.black,
                unselectedItemColor: Colors.grey,
                iconSize: 28,
                type: BottomNavigationBarType.fixed,
                onTap: model.onItemTapped,
              ),
            ],
          ),
        );
      },
    );
  }
}

//child: Row(
//                                   children: [
//                                     Radio(
//                                         value: 0,
//                                         activeColor: Palette.primaryColor,
//                                         visualDensity: const VisualDensity(
//                                             horizontal: VisualDensity.minimumDensity,
//                                             vertical: VisualDensity.minimumDensity),
//                                         groupValue: model.paymentOption,
//                                         onChanged: (value) {
//                                           model.paymentOption = 0;
//                                           setModalState(() {});
//                                         }),
//                                     const Text(
//                                       'Card',
//                                       style: TextStyle(
//                                           fontSize: 14.0,
//                                           fontWeight: FontWeight.w500,
//                                           color: Colors.black),
//                                     ),
//                                   ],
//                                 ),
//                               ),
