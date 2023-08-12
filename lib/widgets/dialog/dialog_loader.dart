import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../core/utils/size_config.dart';
import '../loading_animation.dart';

class LoaderDialog extends StatelessWidget {
  final DialogRequest? request;

  const LoaderDialog({Key? key, this.request}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: SizeConfig.yMargin(context, 18),
              child: const LoadingAnimation(),
            ),
            SizedBox(height: SizeConfig.yMargin(context, .2)),
            request!.title != null
              ? Text(
                  request!.title!,
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Roboto',
                    fontSize: SizeConfig.textSize(context, 2)
                  ),
                )
              : const SizedBox(),
          ],
        ),
      ),
    );
  }
}