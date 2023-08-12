import 'package:flutter/material.dart';
import 'package:no_name/widgets/utility_widgets.dart';
import 'package:stacked/stacked.dart';

import 'personal_data_viewmodel.dart';

class PersonalDataView extends StatelessWidget {
  const PersonalDataView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ViewModelBuilder<PersonalDataViewModel>.reactive(
        viewModelBuilder: () => PersonalDataViewModel(),
        builder: (context, model, child) {
          return CustomScaffoldWidget(
            appBar: const CustomAppBar(
              title: "Personal Data"
            ),
            body: Stack(
              children: [
                Column(
                  children: [
                    const SizedBox(height: 30),
                    _eachColumn("Account Name", "Olayemi Olaomo Olamilekan", size),
                    _eachColumn("Phone Number", "2349043567890", size),
                    _eachColumn("Account Number", "2349043567890", size),
                  ],
                ),
                Positioned(
                  bottom: 10,
                  right: 0,
                  left: 0,
                  child: RoundedButton(title: "Edit Profile", onPressed: (){},),
                )
              ],
            ),
          );
        });
  }

  _eachColumn(String title, String value, size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: size.width / 3.5,
                child: Text(
                  title,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    value,
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              )
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0),
          child: Divider(height: 2),
        ),
      ],
    );
  }

}
