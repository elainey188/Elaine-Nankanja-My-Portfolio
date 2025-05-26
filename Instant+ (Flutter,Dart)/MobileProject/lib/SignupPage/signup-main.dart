import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Authentication/auth.dart';
import '../SigninPage/signin-main.dart';
import '../MainScreen/main-screen.dart';

/*
    Description:
    - This is the Sign-up page of the app
    - User can sign up with Apple, Google, LinkedIn, or Email
    - User can also Sign in (show SigninPage)
    - After sign-up successful, next page brings user back to SigninPage

 */

/*
    TODO:
    - UI Layout
    - 'Sign up with Apple' button
    - 'Sign up with Google' button
    - 'Sign up with LinkedIn' button
    - 'Sign up with Email' button
    - 'Sign in' button

 */

class SignupMain extends StatefulWidget {
  const SignupMain({super.key});

  @override
  _SignupMainState createState() => _SignupMainState();
}

class _SignupMainState extends State<SignupMain> {
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> createUserWithEmailAndPassword() async {
    try {
      // Create user with Firebase Auth
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
      // Navigate to another screen upon success
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SigninMain()),
      );
    } on FirebaseAuthException catch (e) {
      // Handle errors
      String errorMessage = e.message ?? "An unknown error occurred.";
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text(errorMessage),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }


  // TODO: SIGNUP WITH EMAIL/PASSWORD
  // String? errorMessage = '';
  // bool isLogin = true;
  //
  // final TextEditingController _controllerEmail = TextEditingController();
  // final TextEditingController _controllerPassword = TextEditingController();
  //
  // Future<void> signInWithEmailAndPassword() async {
  //   try {
  //     await Auth().signInWithEmailAndPassword(
  //       email: _controllerEmail.text,
  //       password: _controllerPassword.text,
  //     );
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(builder: (context) => const MainScreen()),
  //     );
  //   } on FirebaseAuthException catch (e) {
  //     setState(() {
  //       errorMessage = e.message;
  //     });
  //   }
  // }
  //
  // Future<void> createUserWithEmailAndPassword() async {
  //   try {
  //     await Auth().createUserWithEmailAndPassword(
  //       email: _controllerEmail.text,
  //       password: _controllerPassword.text,
  //     );
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(builder: (context) => const SigninMain()),
  //     );
  //   } on FirebaseAuthException catch (e) {
  //     setState(() {
  //       errorMessage = e.message;
  //     });
  //   }
  // }
  //
  // Widget _entryField(String title, TextEditingController controller) {
  //   return TextField(
  //     controller: controller,
  //     decoration: InputDecoration(
  //       labelText: title,
  //       filled: true,
  //       fillColor: Colors.transparent,
  //       border: const OutlineInputBorder(
  //         borderRadius: BorderRadius.all(Radius.circular(8)),
  //         borderSide: BorderSide(color: Color(0xFFFFFFFF)), // light grey color
  //       ),
  //       hintStyle: const TextStyle(color: Colors.white),
  //     ),
  //     style: const TextStyle(color: Colors.white),
  //   );
  // }
  //
  // Widget _errorMessage() {
  //   return Text(errorMessage == '' ? '' : 'Humm ? $errorMessage', style: const TextStyle(color: Colors.red));
  // }
  //
  // Widget _submitButton() {
  //   return ElevatedButton(
  //     onPressed: isLogin ? signInWithEmailAndPassword : createUserWithEmailAndPassword,
  //     style: ElevatedButton.styleFrom(
  //       minimumSize: const Size(339, 44),
  //       backgroundColor: Colors.white,
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(8),
  //       ),
  //     ),
  //     child: Text(
  //       isLogin ? 'Login' : 'Register',
  //       style: const TextStyle(
  //         color: Colors.black,
  //         fontSize: 14,
  //         fontWeight: FontWeight.w600,
  //         fontFamily: 'Lato',
  //       ),
  //     ),
  //   );
  // }
  //
  // Widget _loginOrRegisterButton() {
  //   return TextButton(
  //     onPressed: () {
  //       setState(() {
  //         isLogin = !isLogin;
  //       });
  //     },
  //     child: Text(
  //       isLogin ? 'Register instead' : 'Login instead',
  //       style: const TextStyle(
  //         color: Colors.purple,
  //         fontSize: 16,
  //       ),
  //     ),
  //   );
  // }

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
                  const Text(
                    'Sign up',
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
                    'Create your new account',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Lato',
                    ),
                    textAlign: TextAlign.center,
                  ),

                  // TODO: SIGNUP WITH EMAIL/PASSWORD
                  // const SizedBox(height: 20),
                  // _entryField('Email', _controllerEmail),
                  // const SizedBox(height: 20),
                  // _entryField('Password', _controllerPassword),
                  // const SizedBox(height: 20),
                  // _errorMessage(),
                  // const SizedBox(height: 20),
                  // _submitButton(),
                  // const SizedBox(height: 20),
                  // _loginOrRegisterButton(),


                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'First name',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            const TextField(
                              obscureText: true,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.transparent,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(8)),
                                  borderSide: BorderSide(color: Color(0xFFFFFFFF)), // light grey color
                                ),
                                hintText: 'Apple',
                                hintStyle: TextStyle(color: Colors.white),
                              ),
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Last name',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            const TextField(
                              obscureText: true,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.transparent,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(8)),
                                  borderSide: BorderSide(color: Color(0xFFFFFFFF)), // light grey color
                                ),
                                hintText: 'Doe',
                                hintStyle: TextStyle(color: Colors.white),
                              ),
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
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
                    controller: _controllerEmail,
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
                  const SizedBox(height: 20),
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
                    controller: _controllerPassword,
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
                  const SizedBox(height: 20),
                  // TODO: Implement sign-up logic. For now, navigate to SigninMain
                  ElevatedButton(
                    onPressed: createUserWithEmailAndPassword,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(339, 44),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Sign up',
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
                    'Or sign up with',
                    style: TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Apple "Sign in" button
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
                            // TODO: Implement Apple sign-up
                          },
                        ),
                      ),
                      const SizedBox(width: 15),
                      // Google "Sign in" button
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
                            // TODO: Implement Google sign-up
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
                        "If you have an account?",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
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