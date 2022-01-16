import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:project_menschen_fahren/config/app_config.dart';
import 'package:project_menschen_fahren/constants.dart';
import 'package:project_menschen_fahren/main.dart';
import 'package:project_menschen_fahren/models/button_color.dart';
import 'package:project_menschen_fahren/models/button_type.dart';
import 'package:project_menschen_fahren/pages/login_page.dart';
import 'package:project_menschen_fahren/routes_name.dart';
import 'package:project_menschen_fahren/widgets/components/custom_button.dart';


class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
    );

    return MaterialApp(
      title: 'Introduction screen',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: OnBoardingPage(),
    );
  }
}

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  Future<void> _onIntroEnd(context) async{
    final AppConfig config = await AppConfig.forEnvironment("dev");
    runApp(MyApp(config: config,));
  }

  Widget _buildFullscrenImage() {
    return Image.asset(
      'assets/images/travel.jpg',
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
    );
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset('assets/images/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0,fontFamily: Constants.PRIMARY_FONT_FAMILY);

    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700,fontFamily: Constants.PRIMARY_FONT_FAMILY),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
      globalHeader: Align(
        alignment: Alignment.topRight,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 16, right: 16),
            child: _buildImage('travel.jpg', 100),
          ),
        ),
      ),
      globalFooter: SizedBox(
        width: double.infinity,
        height: 60,
        child: CustomButton(buttonText: 'Let\s go right away!', onPressedFunc: () => _onIntroEnd(context), buttonType: ButtonType.ELEVATED,buttonColor: ButtonColor.SECONDARY,),
      ),
      pages: [
        PageViewModel(
          title: "Create Event",
          body:
          "Create a public or private event and invite people to the event.",
          image: _buildImage('travel.jpg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Meet new people and travel",
          body:
          "Request to join and travel together with a group you feel comfortable with.",
          image: _buildImage('travel.jpg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Invite friends to Event",
          body:
          "Create private event and invite friends without any hassle.",
          image: _buildImage('travel.jpg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Make plans together",
          body:
          "Introduce yourself, mention your hobbies and find new like minded travel buddies.\n\n Celebrate Birthday parties, seminar, concert, conference with interested people. ",
          image: _buildFullscrenImage(),
          decoration: pageDecoration.copyWith(
            contentMargin: const EdgeInsets.symmetric(horizontal: 16),
            fullScreen: true,
            bodyFlex: 2,
            imageFlex: 3,
          ),
        ),
        PageViewModel(
          title: "Platform for Event",
          body: "Make plans with friends for hike, trek, party or other program and make a detail itenary about the plan without any hassel.",
          image: _buildImage('travel.jpg'),
          /*footer: ElevatedButton(
            onPressed: () {
              introKey.currentState?.animateScroll(0);
            },
            child: const Text(
              'FooButton',
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.lightBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),*/
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Don't feel bored and find something to do.",
          bodyWidget: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            /*children: const [
              Text("Click on ", style: bodyStyle),
              Icon(Icons.edit),
              Text(" to edit a post", style: bodyStyle),
            ],*/
          ),
          decoration: pageDecoration.copyWith(
            bodyFlex: 2,
            imageFlex: 4,
            bodyAlignment: Alignment.bottomCenter,
            imageAlignment: Alignment.topCenter,
          ),
          image: _buildImage('travel.jpg'),
          reverse: true,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      //rtl: true, // Display as right-to-left
      skip: const Text('Skip'),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        //color: Colors.black87,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: const Center(child: Text("This is the screen after Introduction")),
    );
  }
}