import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:no_name/widgets/utility_widgets.dart';


class ContactUsView extends StatelessWidget {
  const ContactUsView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      appBar: const CustomAppBar(
        title: "Contact Us",
      ),
      body: Column(
        children: [
          eachContainer("assets/svg/call.svg", "Call Us", "+1 123 3698 789"),
          const SizedBox(height: 20),
          eachContainer("assets/svg/mail.svg", "Email", "support@fintech.com")
        ],
      ),
    );
  }

  Widget eachContainer(String svgIcon, String name, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
        const SizedBox(height: 5),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: BoxDecoration(
            color: const Color(0xFFA4A9AE).withOpacity(.15),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset(svgIcon),
              const SizedBox(width: 10),
              Expanded(
                child: SelectableText(
                  value,
                  maxLines: 1,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
