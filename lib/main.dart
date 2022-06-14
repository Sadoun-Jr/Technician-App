import 'package:flutter/material.dart';
import 'package:technicians/layouts/choose%20register%20method.dart';
import 'package:technicians/layouts/dashboard.dart';
import 'package:technicians/layouts/technician%20reviews.dart';
import 'layouts/onboarding selection process.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  runApp(const MyApp(
  ));
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
        "/onboarding selection": (context) => const OnboardingSelection(),
        "/dashboard" : (context) => const UserDashboard(),
        "/technician reviews" : (context) => const TechnicianReviews(),
      },
      home:
      // OnboardingSelection(),
      SelectRegisterMethodLayout(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    );
  }
}
