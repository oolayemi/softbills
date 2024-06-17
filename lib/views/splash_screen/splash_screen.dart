import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'splash_screen_viewmodel.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashScreenViewModel>.reactive(
      onModelReady: (model) => model.setup(),
      viewModelBuilder: () => SplashScreenViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/BG.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: AnimatedOpacity(
                opacity: model.opacity,
                duration: const Duration(seconds: 2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/softbills 1.png'),
                    const SizedBox(height: 25),
                    Image.asset('assets/images/SoftBills.png'),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
