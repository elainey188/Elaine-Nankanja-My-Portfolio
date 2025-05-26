import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'LandingPage/landing-main.dart';
import 'HomePage/home-main.dart';
import '../Authentication/widget-tree.dart';
import '../Classes/overall.dart';
import 'ProfilePage/profile-main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:permission_handler/permission_handler.dart';
import 'Notifications/noti_perms.dart';

/*
    Description:
    - This is the main file of the app
    - This file will be the first file that is run when the app is opened
    - This file will determine which page to show the user:
        - If the user is not logged in, show the LandingPage
        - If the user is logged in, show the HomePage
 */

/*
    TODO:
    - Change color scheme
    - If user not logged in, show LandingPage, else show HomePage. For now just show LandingPage
 */

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await requestNotificationPermission();
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Overall>(
      create: (context) => Overall(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Instant+',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return const Center(child: Text('Something went wrong!'));
            }

            // if (snapshot.hasData) {
            //   return const HomeMain();
            // }

            return const LandingMain();
          },
        ),
      ),
    );
  }
}