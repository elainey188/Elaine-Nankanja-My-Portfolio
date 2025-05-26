import 'package:flutter/material.dart';
import 'package:mobileproject/OnboardingPages/onboarding1.dart';
import '../HomePage/home-main.dart';
import '../OnboardingPages/onboarding1.dart';
import '../SigninPage/signin-main.dart';

/*
    Description:
    - This is the landing page of the app
    - This page will be shown to the user when they first open the app
    - The user can sign in with Apple, Google, or Email
    - "Get Started" button will take the user to the onboarding pages
 */

/*
    TODO:
    - UI Layout
    - 'Get Started' button
    - Apple 'Sign In' button
    - Google 'Sign In' button
    - 'Sign In' button

 */


class LandingMain extends StatelessWidget {
  const LandingMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(left: 25.0, top: 35.0),
          child: Text(
            'INSTANT+',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Background
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/backgrounds/back.png'), // TODO: Add background image
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Text "Start taking control of your finances!"
              Padding(
                padding: EdgeInsets.only(left: 50.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: 277.0,
                    child: const Text(
                      'Start taking control of your finances!',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // "Get Started" button navigate to onboarding pages
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const Onboarding1()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    child: Ink(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF7388FF), Color(0xFFCA73FF), Color(0xFFFF739D)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.5), // Light grey with 0.5 opacity
                          width: 1,
                        ),
                      ),
                      child: Container(
                        width: 162,
                        height: 61,
                        alignment: Alignment.center,
                        child: const Text(
                          'Get Started',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  // Apple "Sign In" button
                  Container(
                    height: 61,
                    width: 61,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.5), // Light grey with 0.5 opacity
                        width: 1,
                      ),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.apple),
                      color: Colors.white,
                      onPressed: () {
                        // TODO: Apple sign in
                      },
                    ),
                  ),
                  const SizedBox(width: 15),
                  // Google "Sign In" button
                  Container(
                    height: 61,
                    width: 61,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.5),
                        width: 1,
                      ),
                    ),
                    child: IconButton(
                      icon: SizedBox(
                        width: 18,
                        height: 18,
                        child: Image.asset('assets/icons/google_icon.png'),
                      ),
                      onPressed: () {
                        // TODO: Google sign in
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.only(left: 50.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      "You have an account?",
                      style: TextStyle(color: Colors.white),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const SigninMain()),
                        );
                      },
                      child: const Text(
                        'Sign in',
                        style: TextStyle(color: Colors.purple),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // App Version
              const Padding(
                padding: EdgeInsets.only(bottom: 20.0),
                child: Text(
                  'App Version 1.0.0',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}