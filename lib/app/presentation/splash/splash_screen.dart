import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../homescreen/view/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this);

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 25, 66, 100),
            Color.fromARGB(255, 106, 34, 119),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Lottie.asset(
          'assets/lottie/splash.json',
          controller: _controller,
          width: 200,
          height: 200,
          fit: BoxFit.contain,
          onLoaded: (composition) {
            _controller
              ..duration =
                  composition.duration *
                  0.5 // 2x hız
              ..forward();
          },
        ),
      ),
    );
  }
}
