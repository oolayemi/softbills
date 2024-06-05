import 'package:flutter/material.dart';
import 'package:no_name/widgets/utility_widgets.dart';

class VerificationComplete extends StatelessWidget {
  final String title;
  final String description;
  final String? buttonText;
  final String? imageUrl;
  final Function()? onTap;

  const VerificationComplete({super.key, required this.title, required this.description, this.onTap, this.buttonText, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      padding: 0.0,
      body: Container(
        color: const Color(0xFF0991CC),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(imageUrl ?? 'assets/images/Verified Icon 1.png', height: 263, width: 263),
                    Text(
                      title,
                      style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 24, color: Color(0xFFFFFFFF)),
                    ),
                    Text(
                      description,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                        color: Color(0xFFFFFFFF),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15, bottom: 20),
              child: SizedBox(width: double.infinity, child: RoundedButton(title: buttonText ?? 'Continue', bgColor: Colors.white, onPressed: onTap)),
            ),
          ],
        ),
      ),
    );
  }
}
