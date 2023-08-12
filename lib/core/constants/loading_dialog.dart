import 'package:flutter/material.dart';

import '../utils/size_config.dart';

class LoaderDialog {
  static Future showLoadingDialog(BuildContext context, {String? message}) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/loading.gif',
                  height: MediaQuery.of(context).size.height * 0.10,
                  width: MediaQuery.of(context).size.height * 0.10,
                ),
                SizedBox(height: message != null ? 5 : 0),
                message != null
                    ? Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: SizeConfig.textSize(context, 2), fontStyle: FontStyle.italic),
                )
                    : const SizedBox()
              ],
            ),
          ),
        );
      },
    );
  }

  static Future<void> showNoInternet(BuildContext context, GlobalKey key) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          key: key,
          elevation: 0.0,
          backgroundColor: Colors.white,
          child: Center(
            child: Image.asset(
              'assets/images/loading.gif',
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
          ),
        );
      },
    );
  }
}