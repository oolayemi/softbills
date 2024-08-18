import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:no_name/views/fund_account/fund_account_viewmodel.dart';
import 'package:no_name/views/fund_transfer/fund_transfer_view.dart';
import 'package:no_name/views/fund_ussd/fund_ussd_view.dart';
import 'package:no_name/widgets/utility_widgets.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class FundAccountView extends StatelessWidget {
  const FundAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FundAccountViewModel>.reactive(
        viewModelBuilder: () => FundAccountViewModel(),
        builder: (context, model, _) {
          return CustomScaffoldWidget(
            appBar: const CustomAppBar(title: "Fund Account"),
            body: Container(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  ListTile(
                    leading: SvgPicture.asset("assets/svg/double_arrow.svg"),
                    title: const Text('Transfer', style: TextStyle(fontWeight: FontWeight.w600)),
                    trailing: SvgPicture.asset('assets/svg/ios_arrow.svg'),
                    onTap: () => NavigationService().navigateToView(const FundTransferView()),
                  ),
                  const SizedBox(height: 15),
                  ListTile(
                    leading: SvgPicture.asset("assets/svg/hash.svg"),
                    title: const Text('USSD', style: TextStyle(fontWeight: FontWeight.w600)),
                    trailing: SvgPicture.asset('assets/svg/ios_arrow.svg'),
                    onTap: () => NavigationService().navigateToView(const FundUssdView()),
                  ),
                  const SizedBox(height: 15),
                  ListTile(
                    leading: SvgPicture.asset("assets/svg/card.svg"),
                    title: const Text('Card', style: TextStyle(fontWeight: FontWeight.w600)),
                    trailing: SvgPicture.asset('assets/svg/ios_arrow.svg'),
                    onTap: () {},
                  ),
                  const SizedBox(height: 15),
                  ListTile(
                    leading: SvgPicture.asset("assets/svg/softpay.svg"),
                    title: const Text('Softpay', style: TextStyle(fontWeight: FontWeight.w600)),
                    trailing: SvgPicture.asset('assets/svg/ios_arrow.svg'),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          );
        });
  }
}
