import 'package:flutter/material.dart';
import 'package:no_name/views/services/services_viewmodel.dart';
import 'package:no_name/widgets/utility_widgets.dart';
import 'package:stacked/stacked.dart';

class ServicesView extends StatelessWidget {
  const ServicesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ServicesViewModel>.reactive(
      viewModelBuilder: () => ServicesViewModel(),
      builder: (context, model, child) {
        return CustomScaffoldWidget(
          appBar: const CustomAppBar(
            title: "Services",
            withBackButton: false,
          ),
          body: Column(
            children: [
              _buildBillsPayment(context),
              const SizedBox(height: 60),
              _buildTransfers(context),
              const SizedBox(height: 60),
              _buildVAServices()
            ],
          ),
        );
      },
    );
  }



  _buildBillsPayment(context) {
    ServicesViewModel model = ServicesViewModel();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Bills Payment"),
        const SizedBox(height: 20),
        SingleChildScrollView(
          child: Row(
            children: [
              EachLink(icon: Icons.tv_rounded, title: "Cable TV", onTap: () => model.gotoCableTV()),
              const SizedBox(width: 35),
              EachLink(icon: Icons.light, title: "Electricity", onTap: () => flusher("Coming soon", context, color: Colors.blue, sec: 1)),
              const SizedBox(width: 35),
              // EachLink(icon: Icons.flight, title: "Flight", onTap: () => flusher("Coming soon", context, color: Colors.blue, sec: 1)),
              // const SizedBox(width: 35),
              EachLink(icon: Icons.sports_basketball, title: "Betting", onTap: () => model.gotoBilling()),
            ],
          ),
        )
      ],
    );
  }

  _buildTransfers(context) {
    ServicesViewModel model = ServicesViewModel();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Transfers"),
        const SizedBox(height: 20),
        Row(
          children: [
            EachLink(icon: Icons.currency_exchange, title: "Transfer", onTap: () => flusher("Coming soon", context, color: Colors.blue, sec: 1),),
            const SizedBox(width: 35),
            EachLink(icon: Icons.attach_money_outlined, title: "Dollar Card", onTap: () => model.gotoSwap()),
          ],
        )
      ],
    );
  }

  _buildVAServices() {
    ServicesViewModel model = ServicesViewModel();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("VAS services"),
        const SizedBox(height: 20),
        Row(
          children: [
            EachLink(icon: Icons.phone_android_outlined, title: "Airtime", onTap: () => model.gotoAirtime()),
            const SizedBox(width: 35),
            EachLink(icon: Icons.wifi, title: "Data", onTap: () => model.gotoData()),
            const SizedBox(width: 35),
            EachLink(icon: Icons.wifi_tethering, title: "SME Data", onTap: () => model.gotoSmeData()),
            const SizedBox(width: 35),
              EachLink(icon: Icons.pin_sharp, title: "EPins", onTap: () => model.gotoSmeData()),
          ],
        )
      ],
    );
  }
}
