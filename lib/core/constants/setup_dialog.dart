import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/locator.dart';
import '../../widgets/loading_animation.dart';
import '../enums/dialog_type.dart';
import '../utils/size_config.dart';

final DialogService? _dialogService = locator<DialogService>();

void setupDialog() {
  // final dialogService = locator<DialogService>();

  final builders = {
    DialogType.basic: (context, sheetRequest, completer) =>
        _BasicDialog(request: sheetRequest, completer: completer),
    DialogType.form:  (context, sheetRequest, completer) =>
        _FormDialog(request: sheetRequest, completer: completer),
    DialogType.load:  (context, sheetRequest, completer) =>
        _LoadingDialog(request: sheetRequest),
  };

  _dialogService!.registerCustomDialogBuilders(builders);
}

class _BasicDialog extends StatelessWidget {
  final DialogRequest? request;
  final Function(DialogResponse)? completer;
  const _BasicDialog({Key? key, this.request, this.completer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: /* Build your dialog UI here */
        Column(
          children: [
            const SizedBox(height: 10.0,),
            Text(request!.title!),
            const SizedBox(height: 20.0,),


          ],
        )
      // Container(),
    );
  }
}

class _LoadingDialog extends StatelessWidget {
  final DialogRequest? request;
  final Function(DialogResponse)? completer;
  const _LoadingDialog({Key? key, this.request, this.completer}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Dialog(
      backgroundColor: Colors.transparent,
        elevation: 0.0,
        child: /* Build your dialog UI here */
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              color: Colors.transparent,
              height: SizeConfig.yMargin(context, 18),
              child: LoadingAnimation(),
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

            SizedBox(height: SizeConfig.yMargin(context, .2)),
            InkWell(
              onTap: (){
                _dialogService!.completeDialog(DialogResponse(confirmed: true));
              },
              child: Text(request!.mainButtonTitle!, style: TextStyle(
                  color: Colors.red,
                  fontFamily: 'Roboto',
                  fontSize: SizeConfig.textSize(context, 2)
              ),),
            )

          ],
        ),
      // Container(),
    );
  }
}

class _FormDialog extends StatelessWidget {
  final DialogRequest? request;
  final Function(DialogResponse)? completer;
  const _FormDialog({Key? key, this.request, this.completer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: /* Build your dialog UI here */
        Container(),
    );
  }
}

// void setupDialog() {
//   _dialogService.registerCustomDialogUi(
//     (context, dialogRequest) => customDialogUi(
//       dialogRequest,
//       (dialogResponse) => _dialogService.completeDialog(dialogResponse),
//     )
//   );
// }