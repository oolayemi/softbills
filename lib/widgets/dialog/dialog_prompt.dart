import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:store_redirect/store_redirect.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../core/utils/size_config.dart';
import '../../core/utils/tools.dart';
import '../../styles/brand_color.dart';
import '../utility_widgets.dart';

class DialogPrompt extends StatelessWidget {
  final DialogRequest? request;
  final Function(DialogResponse)? onDialogTap;
  final bool? update;
  final bool? require;

  const DialogPrompt({Key? key, this.request, this.onDialogTap, this.update, this.require}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BackdropFilter(
        filter: ImageFilter.blur(sigmaX:5, sigmaY: 5),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                constraints: BoxConstraints(minWidth: SizeConfig.xMargin(context, 80), minHeight: SizeConfig.yMargin(context, 15), maxWidth: SizeConfig.xMargin(context, 80)),
                padding: EdgeInsets.symmetric(vertical: SizeConfig.yMargin(context, 2), horizontal: SizeConfig.xMargin(context, 6)),
                // height: SizeConfig.yMargin(context, 15),
                // width: SizeConfig.xMargin(context, 80),
                decoration: BoxDecoration(
                  color: BrandColors.primary,
                  borderRadius: BorderRadius.circular(8),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    colors: [
                      BrandColors.primary,
                      BrandColors.secondary
                    ]
                  )
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: SizeConfig.yMargin(context, 2)),
                      child: Text(
                        request!.title!,
                        style:Theme.of(context).textTheme.headline6!.copyWith(color: Colors.white, fontSize: SizeConfig.textSize(context, 2.2)),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: SizeConfig.yMargin(context, 2)),
                      child: Text(
                        request!.description!,
                        style:Theme.of(context).textTheme.headline5!.copyWith(color: Colors.white, fontSize: SizeConfig.textSize(context, 2)),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        require! ? const SizedBox() : InkWell(
                          borderRadius: BorderRadius.circular(5),
                          onTap: () => onDialogTap!(DialogResponse()),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: SizeConfig.yMargin(context, 1.5), horizontal: SizeConfig.xMargin(context, 8)),
                            decoration: BoxDecoration(
                              color: BrandColors.primary,
                              borderRadius: BorderRadius.circular(5)
                            ),
                            child: Text(
                              'Close',
                              style:Theme.of(context).textTheme.headline6!.copyWith(
                                fontSize: SizeConfig.textSize(context, 2),
                                color: Colors.white
                              ),
                            ),
                          ),
                        ),
                        !update! ? const SizedBox() : InkWell(
                          borderRadius: BorderRadius.circular(5),
                          onTap: () {
                            try {
                              StoreRedirect.redirect(androidAppId: '${env('ANDROID_APP_ID')}', iOSAppId: '${env('IOS_APP_ID')}')
                                .catchError(
                                  (e) {
                                    flusher('Unable to launch Store Application', context, sec: 3);
                                  }
                                );
                            } catch (e) {
                              flusher('Unable to launch Store Application', context, sec: 3);
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: SizeConfig.yMargin(context, 1.5), horizontal: SizeConfig.xMargin(context, 8)),
                            decoration: BoxDecoration(
                              color: BrandColors.primary,
                              borderRadius: BorderRadius.circular(5)
                            ),
                            child: Text(
                              'Update',
                              style:Theme.of(context).textTheme.headline6!.copyWith(
                                fontSize: SizeConfig.textSize(context, 2),
                                color: Colors.white
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}