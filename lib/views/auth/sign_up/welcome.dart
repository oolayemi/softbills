import 'package:flutter/material.dart';
import 'package:no_name/app/router.dart';
import 'package:no_name/widgets/utility_widgets.dart';
import 'package:stacked_services/stacked_services.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      body: Stack(
        children: [
          ListView(
            children: [
              Container(
                height: MediaQuery.of(context).size.width * .85,
                width: MediaQuery.of(context).size.width * .85,
                decoration: BoxDecoration(
                  color: const Color(0xFFF4F1FF).withOpacity(.58),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              const SizedBox(height: 70),
              const SizedBox(
                width: 200,
                child: Column(
                  children: [
                    Text(
                      "Weli-done, Champ!",
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "This helps you to login to your account in snap of finger.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    )
                  ],
                ),
              )
            ],
          ),
          Positioned(
            bottom: 10,
            right: 0,
            left: 0,
            child: RoundedButton(
              title: "Go to Dashboard",
              onPressed: () {
                NavigationService().clearStackAndShow(Routes.dashboardViewRoute);
              },
            ),
          )
        ],
      ),
    );
  }
}
