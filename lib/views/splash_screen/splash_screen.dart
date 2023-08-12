import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../styles/brand_color.dart';
import 'splash_screen_viewmodel.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashScreenViewModel>.reactive(
      onModelReady: (model) => model.setup(),
      viewModelBuilder: () => SplashScreenViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Scaffold(
            backgroundColor: BrandColors.mainBackground,
            body: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/background/hori_vert_line.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: Image.asset(model.imagePath, height: 200, width: 200),
              ),
            ),
          ),
        );
      },
    );
  }
}
