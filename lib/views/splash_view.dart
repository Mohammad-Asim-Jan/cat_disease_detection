import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../utils/constants.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    _navigateToHome(isUserLogin());
  }

  bool isUserLogin() {
    return Supabase.instance.client.auth.currentUser != null;
  }

  _navigateToHome(bool isUserLoggedIn) async {
    await Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(
          context, isUserLoggedIn ? '/home' : '/login');
    }); // Delay for 3 seconds
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Top-left yellow shape
          Positioned(
            top: -150,
            right: -150,
            child: ClipOval(
              child: Container(
                height: 270, // Adjust based on your design
                width: 270,
                color: Constants.mainColor,
              ),
            ),
          ),
          // Bottom-right yellow shape
          Positioned(
            bottom: -340,
            left: -325,
            child: ClipOval(
              child: Container(
                height: 530, // Adjust based on your design
                width: 510,
                color: Constants.mainColor,
              ),
            ),
          ),
          // Main content of Splash screen
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // App logo or mascot
                Image.asset(
                  'assets/images/AppLogo.png',
                  height: 300, // Adjust the size according to your design
                ),
                const SizedBox(height: 20),
                // Space between logo and app name
                // App name with a tagline
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text('K',
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge
                            ?.copyWith(color: Colors.deepOrange, fontSize: 32)),
                    Text(
                      'itty ',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    Text('H',
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge
                            ?.copyWith(color: Colors.deepOrange, fontSize: 32)),
                    Text('ealth',
                        style: Theme.of(context).textTheme.headlineLarge),
                  ],
                ),
                Text(
                  'Your Kitty\'s Health Companion',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: Colors.lightGreen.shade700,
                      ),
                ),
                const SizedBox(height: 90),
                // Space before the progress indicator
              ],
            ),
          ),
        ],
      ),
    );
  }
}
