import 'package:flutter/material.dart';
import 'package:simple_animations/animation_builder/play_animation_builder.dart';
import 'package:task4/modules/xo_game/view/get_started.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: PlayAnimationBuilder<double>(
          duration: const Duration(seconds: 2),
          curve: Curves.easeInOut,
          tween: Tween<double>(begin: -100.0, end: 200.0),
          builder: (context, value, child) {
            return Image.asset("assets/images/logo.png",
                width: value, height: value);
          },
          onCompleted: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => const GetStarted()));
          },
        ),
      ),
    );
  }
}
