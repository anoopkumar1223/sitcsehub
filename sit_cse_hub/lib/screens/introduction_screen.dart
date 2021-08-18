import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:sit_cse_hub/resources/resource.dart';
import 'package:sit_cse_hub/screens/user_selection_screen.dart';

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => UserSelectionScreen()),
    );
  }

  Widget _buildLottie(String assetPath, [double width = 300]) {
    return Lottie.asset(
      assetPath,
      width: width,
    );
  }

  @override
  Widget build(BuildContext context) {
    TextStyle bodyStyle = TextStyle(
      fontSize: 20,
      fontFamily: Resource.string.lato,
    );

    PageDecoration pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(
        letterSpacing: 2,
        fontSize: 28.0,
        fontWeight: FontWeight.w700,
        fontFamily: Resource.string.bangers,
      ),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(
        16.0,
        0.0,
        16.0,
        16.0,
      ),
      pageColor: Resource.color.backgroundColor,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Resource.color.backgroundColor,
      globalHeader: Align(
        alignment: Alignment.topRight,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(top: 16, right: 16),
          ),
        ),
      ),
      globalFooter: SizedBox(
        width: double.infinity,
        height: 60,
        child: ElevatedButton(
          child: Text(
            'Let\s go right away!',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              Resource.color.primaryTheme,
            ),
          ),
          onPressed: () => _onIntroEnd(context),
        ),
      ),
      pages: [
        PageViewModel(
          title: "<SITCSEHUB/>",
          body:
              "An application which connects faculty and students of CSE department of SIT",
          image: _buildLottie(
            'assets/images/profile_girl_with_laptop.json',
          ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Get instant notifications",
          body: "Get all the notifications from your faculty",
          image: _buildLottie(
            Resource.image.notificationGif,
            200,
          ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Update yourself regularly",
          body:
              "Get timetables, calendar of events, lecture plans and much more at one place",
          image: _buildLottie(
            Resource.image.homeGif,
          ),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      skip: Text(
        'Skip',
        style: TextStyle(
          fontSize: 16,
          fontFamily: Resource.string.lato,
          fontWeight: FontWeight.w600,
        ),
      ),
      next: Icon(
        Icons.arrow_forward,
        size: 30,
      ),
      done: Text(
        'Done',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          fontFamily: Resource.string.lato,
        ),
      ),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: EdgeInsets.all(
        16,
      ),
      controlsPadding: kIsWeb
          ? EdgeInsets.all(
              10.0,
            )
          : EdgeInsets.fromLTRB(
              2.0,
              1.0,
              2.0,
              1.0,
            ),
      color: Resource.color.primaryTheme,
      skipColor: Resource.color.primaryTheme,
      doneColor: Resource.color.primaryTheme,
      nextColor: Resource.color.primaryTheme,
      dotsDecorator: DotsDecorator(
        activeColor: Resource.color.primaryTheme,
        size: Size(
          8.0,
          8.0,
        ),
        activeSize: Size(
          18.0,
          8.0,
        ),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              15.0,
            ),
          ),
        ),
      ),
    );
  }
}
