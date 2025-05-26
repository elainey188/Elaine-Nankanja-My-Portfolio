import 'package:flutter/material.dart';
import '../OnboardingPages/onboarding1.dart';
import '../OnboardingPages/onboarding2.dart';
import '../OnboardingPages/onboarding3.dart';

/*
    Description:
    - This is the first onboarding page
    - Next page shows Onboarding2
 */

/*
    TODO:
    - UI Layout
    - 'Skip' button
    - 'Next' button
    - Don't Allow for back navigation
 */

class Onboarding1 extends StatelessWidget {
  const Onboarding1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/backgrounds/emback.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const Onboarding3()),
                );
              },
              child: const Text(
                'Skip',
                style: TextStyle(color: Colors.white, fontSize: 18, fontFamily: 'lato'),
              ),
            ),
          ],
        ),
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: Center(
                    child: Image.asset('assets/backgrounds/one.png', // TODO: Replace with your image path
                      width: 397.68,
                      height: 323.14,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 10.0),
                  child: Text(
                    'Monitor Progress',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'lato',
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w600, // Semi-bold
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    'Visualize your Saving Progress with the Most Intuitive Design',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'lato',
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: const CircleButtonRow(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 15.0),
                      child: const ArrowForwardButton(),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Tripple dots
class CircleButtonRow extends StatelessWidget {
  const CircleButtonRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Onboarding1()),
            );
          },
          child: Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.deepPurple,
              border: Border.all(
                color: Colors.grey,
                width: 0.5,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Onboarding2()),
            );
          },
          child: Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey,
              border: Border.all(
                color: Colors.grey,
                width: 0.5,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Onboarding3()),
            );
          },
          child: Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey,
              border: Border.all(
                color: Colors.grey,
                width: 0.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// Next button
class ArrowForwardButton extends StatelessWidget {
  const ArrowForwardButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: IconButton(
          icon: const Icon(Icons.arrow_forward, color: Colors.black),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Onboarding2()),
            );
          },
        ),
      ),
    );
  }
}