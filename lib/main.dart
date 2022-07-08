import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:technicians/layouts/choose%20register%20method.dart';
import 'package:technicians/layouts/login.dart';
import 'package:technicians/layouts/mark%20order%20as%20complete.dart';
import 'package:technicians/layouts/portfolio%20summary.dart';
import 'package:technicians/layouts/stepper.dart';
import 'package:technicians/layouts/technician%20reviews.dart';
import 'package:technicians/layouts/user%20favourites.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_app_check/firebase_app_check.dart';


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate(
    webRecaptchaSiteKey: 'recaptcha-v3-site-key',
  );
  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        "/onboarding selection": (context) => const StepperProcess(),
        "/dashboard or login" : (context) => const LoginLayout(),
        "/user favourites" : (context) => const UserFavourites(),

      },
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return LoginLayout();
          } else {
            return WelcomeScreen();
          }
        },
      ),
    );
  }
}

//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key}) : super(key: key);
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//     );
//   }
// }
