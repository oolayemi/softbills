import 'package:flutter/material.dart';
import 'package:no_name/app/locator.dart';
import 'package:no_name/core/services/utility_storage_service.dart';
import 'package:no_name/views/auth/sign_in/sign_in_view.dart';
import 'package:no_name/views/auth/sign_up/validate_phone/validate_phone_view.dart';
import 'package:no_name/widgets/utility_widgets.dart';
import 'package:stacked_services/stacked_services.dart';

class InitialSignUpView extends StatefulWidget {
  const InitialSignUpView({super.key});

  @override
  State<InitialSignUpView> createState() => _InitialSignUpViewState();
}

class _InitialSignUpViewState extends State<InitialSignUpView> {
  int currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  List<Widget> buildIndicators(currentPage) {
    List<Widget> indicators = [];
    for (int i = 0; i < pages.length; i++) {
      indicators.add(
        Container(
          width: 23,
          height: 4,
          margin: const EdgeInsets.symmetric(horizontal: 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3),
            shape: BoxShape.rectangle,
            color: currentPage == i ? const Color(0xFF0991CC) : const Color(0xFFC4C4C4),
          ),
        ),
      );
    }
    return indicators;
  }

  final List<Widget> pages = [
    const OnboardingPage(
      title: "Payments Made Easier",
      description: "It's all about Soft Life",
      image: AssetImage('assets/images/surprised-african-woman-covering-her-mouth-by-hand-while-looking-smartphone-screen 1.png'),
      image2: AssetImage('assets/images/Copy.png'),
      buttonText: "Get Started ",
      isFirstPage: true,
    ),
    const OnboardingPage(
      title: "Get Started",
      description: "Swipe left to see more features!",
      image: AssetImage("assets/images/from-smartphone.png"),
      image2: AssetImage("assets/images/Copy (1).png"),
      buttonText: "Get started",
      isSecondPage: true,
    ),
    const OnboardingPage(
      title: "Explore",
      description: "Discover what this app has to offer.",
      image: AssetImage("assets/images/Asset.png"),
      image2: AssetImage("assets/images/Copy (2).png"),
      buttonText: "Finish",
      isLastPage: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: pages.length,
            onPageChanged: (index) {
              setState(() {
                currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return pages[index];
            },
          ),
          Positioned(
            bottom: 40.0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: buildIndicators(currentPage),
                ),
                const SizedBox(height: 15),
                if ((pages[currentPage] as OnboardingPage).isLastPage)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: RoundedButton(
                            title: "Register",
                            onPressed:  () {
                              // locator<StorageService>().addBool('skippedOnboarding', true);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ValidatePhoneView(),
                                ), // Replace NextScreen with your desired screen
                              );
                            },
                          ),
                        ), const SizedBox(width: 20),
                        Expanded(
                          child: RoundedButton(
                            title: "Sign in",
                            onPressed: () {
                              // locator<StorageService>().addBool('skippedOnboarding', true);
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const SignInView()), // Replace NextScreen with your desired screen
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: RoundedButton(
                        title: (pages[currentPage] as OnboardingPage).buttonText,
                        onPressed: () {
                          if (currentPage < pages.length - 1) {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.ease,
                            );
                          }
                        },
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final ImageProvider image;
  final ImageProvider image2;
  final String buttonText;
  final bool isSecondPage;
  final bool isFirstPage;
  final bool isLastPage;

  const OnboardingPage({
    super.key,
    required this.title,
    required this.description,
    required this.image,
    required this.buttonText,
    this.isSecondPage = false,
    this.isFirstPage = false,
    this.isLastPage = false,
    required this.image2,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          if (isFirstPage)
            Image(
              image: image,
              height: MediaQuery.of(context).size.height * 0.75,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
          if (isFirstPage)
            const SizedBox(height: 10.0),
          if (isFirstPage)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Image(
                image: image2,
                height: 59,
                width: 329,
                fit: BoxFit.cover,
              ),
            ),
          if (isFirstPage)
            const SizedBox(height: 30.0),

          if (isSecondPage)
            Container(
              margin: const EdgeInsets.only(top: 94),
              child: Image(
                image: image,
                height: 460,
                width: 460,
                fit: BoxFit.cover,
              ),
            ),
          if (isSecondPage)
            const SizedBox(height: 10.0),
          if (isSecondPage)
            Container(
              margin: const EdgeInsets.only(top: 0),
              child: Image(
                image: image2,
                height: 90,
                width: 329,
                fit: BoxFit.cover,
              ),
            ),
          if (isSecondPage)
            const SizedBox(height: 30.0),

          if (isLastPage)
            Container(
              margin: const EdgeInsets.only(top: 189, left: 66),
              child: Image(
                image: image,
                height: 216.55,
                width: 250,
                fit: BoxFit.cover,
              ),
            ),
          if (isLastPage)
            const SizedBox(height: 10.0),
          if (isLastPage)
            Container(
              margin: const EdgeInsets.only(top: 60, left: 23),
              child: Image(
                image: image2,
                height: 117,
                width: 329,
                fit: BoxFit.cover,
              ),
            ),
          if (isLastPage)
            const SizedBox(height: 30.0),
        ],
      ),
    );
  }
}
