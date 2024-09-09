import 'package:flutter/material.dart';
import 'package:no_name/views/notifications/notification_viewmodel.dart';
import 'package:no_name/widgets/utility_widgets.dart';
import 'package:stacked/stacked.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NotificationViewModel>.reactive(
      viewModelBuilder: () => NotificationViewModel(),
      builder: (context, model, _) {
        return const CustomScaffoldWidget(
          body: SizedBox(),
        );
      }
    );
  }
}
