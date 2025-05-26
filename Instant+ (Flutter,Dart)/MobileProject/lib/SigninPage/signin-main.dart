import 'package:flutter/material.dart';
import '../SignupPage/signup-main.dart';
import '../MainScreen/main-screen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:social_media_buttons/social_media_buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Authentication/auth.dart';
import '../ResetPasswordPage/resetpassword-main.dart';


/*
    Description:
    - This is the Sign-in page of the app
    - User can sign in with Apple, Google, LinkedIn, or Email
    - User can also Sign up (show SignupPage)
    - User can select "Forgot Password" to reset password (shows ResetPasswordPage)
    - After sign-in successful, next page shows HomePage
 */

/*
    TODO:
    - UI Layout
    - 'Sign in with Apple' button
    - 'Sign in with Google' button
    - 'Sign in with LinkedIn' button
    - 'Sign in with Email' button
    - 'Sign up' button
    - 'Forgot Password' button

 */

class SigninMain extends StatefulWidget {
  const SigninMain({super.key});

  @override
  _SigninMainState createState() => _SigninMainState();
}

class _SigninMainState extends State<SigninMain>{
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

// Handle sign-in
  Future<void> _signInWithEmailPassword() async {
    try {
      // Get the email and password from the text controllers
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      // Sign in using Firebase Authentication
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Navigate to MainScreen after successful login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainScreen()),
      );
    } catch (e) {
      // Handle sign-in error
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error: ${e.toString()}'),
        backgroundColor: Colors.red,
      ));
    }
  }

  // TODO: Authenticating with Email/Password
  // final User? user = Auth().currentUser;
  //
  // Future<void> signOut() async {
  //   await Auth().signOut();
  // }
  //
  // Widget _userUid() {
  //   return Text(user?.email ?? 'User email', style: const TextStyle(color: Colors.white));
  // }
  //
  // Widget _signOutButton() {
  //   return ElevatedButton(
  //     onPressed: signOut,
  //     child: const Text('Sign Out'),
  //   );
  // }

  // Authenticating with Google
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  //Google sign-in
  Future<void> _handleGoogleSignIn() async {
    try {
      GoogleSignInAccount? currentUser = _googleSignIn.currentUser;
      if (currentUser == null) {
        GoogleSignInAccount? user = await _googleSignIn.signIn();
        if (user != null) {
          String userName = user.displayName ?? 'Unknown';
          String userEmail = user.email;
          print('Signed in as: $userName, $userEmail');

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const MainScreen()),
          );
        }
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainScreen()),
        );
      }
    } catch (error) {
      print("Error during Google Sign-In: $error");
    }
  }

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
        ),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // TITLE
                  const Text(
                    'Sign in',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Lato',
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Hi! Welcome back, you have been missed.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Lato',
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  // EMAIL
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Email',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.transparent,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Color(0xFFFFFFFF)), // light grey color
                      ),
                      hintText: 'apple.doe@gmail.com',
                      hintStyle: TextStyle(color: Colors.white),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                  // TODO: SIGN IN WITH EMAIL/PASSWORD
                  // const SizedBox(height: 10),
                  // _userUid(),
                  // _signOutButton(),
                  const SizedBox(height: 20),
                  // PASSWORD
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Password',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.transparent,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Color(0xFFFFFFFF)), // light grey color
                      ),
                      hintText: '*******',
                      hintStyle: TextStyle(color: Colors.white),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  // FORGOT PASSWORD
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ResetPasswordPage()),
                        );
                      },
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // TODO: Implement sign-in logic. For now, navigate to MainScreen
                  ElevatedButton(
                    onPressed: _signInWithEmailPassword,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(339, 44),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Sign in',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Lato',
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  const Divider(color: Colors.white),
                  const Text(
                    'Or sign in with',
                    style: TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 50),
                  // SIGNING WITH SOCIAL MEDIA
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                            // TODO: Implement Apple sign-in
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
                            // TODO: Implement Google sign-in
                            _handleGoogleSignIn();
                          },
                        ),
                      ),
                      const SizedBox(width: 15),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account?",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const SignupMain()),
                          );
                        },
                        child: const Text(
                          'Sign up',
                          style: TextStyle(
                            color: Colors.purple,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
