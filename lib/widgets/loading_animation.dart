import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

import '../core/constants/animation.dart';
import '../core/utils/size_config.dart';

class LoadingAnimation extends StatelessWidget {
  final double? height;

  const LoadingAnimation({Key? key, this.height}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      height: SizeConfig.yMargin(context, height??50),
      child: const FlareActor(
        Animations.loader,
        animation: Animations.loader_name,
        fit: BoxFit.cover,
      ),
    );
  }
}