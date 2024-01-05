import 'dart:ui';

import 'package:flutter/material.dart';

import '../../core/utils/size_config.dart';
import '../../styles/brand_color.dart';

showSuccessDialog(context, {String title = 'Transaction Successful', required String successMessage, dynamic action }){
  return Navigator.of(context).push(PageRouteBuilder(
    opaque: false,
    barrierColor: Colors.black.withOpacity(0.5),
    barrierDismissible: false,
    pageBuilder: (BuildContext context, __, _) => BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Center(
        child: Material(
          borderRadius: BorderRadius.circular(SizeConfig.yMargin(context, 1.5)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(SizeConfig.yMargin(context, 1.5)),
            child: Container(
              width: SizeConfig.xMargin(context, 80),
              color: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: SizeConfig.yMargin(context, 3)),
                    color: BrandColors.mainBlack,
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        title,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(fontSize: SizeConfig.textSize(context, 2), color: Colors.white),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        vertical: SizeConfig.yMargin(context, 2), horizontal: SizeConfig.xMargin(context, 6)),
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          successMessage,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 18),
                        ),

                        const SizedBox(height: 10),
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(vertical: SizeConfig.yMargin(context, 1)),
                          child: InkWell(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: SizeConfig.yMargin(context, 1.5), horizontal: SizeConfig.xMargin(context, 6.5)),
                              decoration: BoxDecoration(
                                  color: BrandColors.secondary,
                                  borderRadius: BorderRadius.circular(SizeConfig.yMargin(context, .8))),
                              child: Text(
                                'Close',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .copyWith(fontSize: SizeConfig.textSize(context, 2), color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  ));
}