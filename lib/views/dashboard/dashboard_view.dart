import 'package:flutter/material.dart';
import 'package:no_name/views/homepage/homepage_view.dart';
import 'package:no_name/views/services/services_view.dart';
import 'package:stacked/stacked.dart';

import 'dashboard_viewmodel.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DashboardViewModel>.reactive(
      onViewModelReady: (model) => model.setup(),
      viewModelBuilder: () => DashboardViewModel(),
      builder: (context, model, child) {
        List<Widget> buildScreens() {
          return [
            const HomePageView(),
            const ServicesView(),
            const SizedBox(),
            const SizedBox(),
          ];
        }


        Widget getTabIcon(int index, String activeImagePath, String inactiveImagePath) {
          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Image.asset(
              model.selectedIndex == index ? activeImagePath : inactiveImagePath,
              width: 24,
              height: 24,
            ),
          );
        }

        return Scaffold(

          body: SafeArea(
            child: IndexedStack(
              index: model.selectedIndex,
              children: buildScreens(),
            ),
          ),
          bottomNavigationBar: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
            child: SizedBox(
              // height: 85,
              child: BottomNavigationBar(
                backgroundColor: Colors.white,
                showUnselectedLabels: true,
                currentIndex: model.selectedIndex,
                onTap: model.onItemTapped,
                selectedItemColor: const Color(0xFF080050),
                unselectedItemColor: Colors.black54,
                type: BottomNavigationBarType.fixed,
                landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
                items: [
                  BottomNavigationBarItem(
                    icon: getTabIcon(0, 'assets/images/Union (1).png', 'assets/images/Union (1).png'),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: getTabIcon(1, 'assets/images/wallet.png', 'assets/images/wallet.png'),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: getTabIcon(3, 'assets/images/Vector (7).png', 'assets/images/Vector (7).png'),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: getTabIcon(2, 'assets/images/Frame.png', 'assets/images/Frame.png'),
                    label: '',
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
