import 'package:flutter/material.dart';
import 'package:technicians/utils/hex%20colors.dart';
import 'package:technicians/widgets/glass%20box.dart';

import '../utils/strings enum.dart';
import '../widgets/logo.dart';

class RegisterWithMailLayout extends StatefulWidget {
  const RegisterWithMailLayout({Key? key}) : super(key: key);

  @override
  State<RegisterWithMailLayout> createState() => _RegisterWithMailLayoutState();
}

class _RegisterWithMailLayoutState extends State<RegisterWithMailLayout> {
  Color _primaryColor = HexColor("#1D4EAB");
  Color _whiteText = Colors.white;
  Color _midWhite = Colors.white54;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: (loginLayout()),
      ),
    );
  }

  Widget loginLayout() {
    return Stack(
      children: [
        loginLayoutBackGroundImage(),
        Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Logo(75, 75),
              ],
            )),
        Align(
          child: glassyLoginBox(),
          alignment: Alignment.bottomCenter,
        ),
        // loginBoxContents(),
      ],
    );
  }

  Widget loginLayoutBackGroundImage() {
    return Image.asset(
      "assets/Login.png",
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
    );
  }

  Widget glassyLoginBox() {
    return Container(
      margin: const EdgeInsets.fromLTRB(30, 0, 30, 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
      ),
      child: FrostedGlassBox(
        470,
        double.infinity,
        Center(child: loginBoxContents()),
      ),
    );
  }

  Widget loginBoxContents() {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();

    return SingleChildScrollView(
      child: Column(children: [
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.fromLTRB(10, 10, 10, 30),
          child: Text(
            AppStrings.registerNewAccountString,
            style: TextStyle(
                fontSize: 24, color: _midWhite, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: TextFormField(
            controller: emailController,
            maxLines: 1,
            style: TextStyle(color: _whiteText),
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: BorderSide(
                  color: _midWhite,
                  width: 1.25,
                ),
              ),
              prefixIcon: Icon(
                Icons.email,
                color: _midWhite,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              labelText: AppStrings.emailString,
              labelStyle: TextStyle(color: _whiteText),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: _midWhite, width: 2.5),
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          padding: const EdgeInsets.all(10),
          child: TextFormField(
            controller: passwordController,
            maxLines: 1,
            style: TextStyle(color: _whiteText),
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: BorderSide(
                  color: _midWhite,
                  width: 1.25,
                ),
              ),
              prefixIcon: Icon(
                Icons.lock,
                color: _midWhite,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              labelText: AppStrings.passwordString,
              labelStyle: TextStyle(color: _whiteText),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: _midWhite, width: 2.5),
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          padding: const EdgeInsets.all(10),
          child: TextFormField(
            controller: confirmPasswordController,
            maxLines: 1,
            style: TextStyle(color: _whiteText),
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: BorderSide(
                  color: _midWhite,
                  width: 1.25,
                ),
              ),
              prefixIcon: Icon(
                Icons.lock,
                color: _midWhite,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              labelText: AppStrings.confirmPasswordString,
              labelStyle: TextStyle(color: _whiteText),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: _midWhite, width: 2.5),
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(color: Colors.transparent),
            borderRadius: BorderRadius.circular(20),
          ),
          height: 50,
          margin: const EdgeInsets.fromLTRB(20, 30, 20, 10),
          child: FloatingActionButton.extended(
            heroTag: AppStrings.heroRegister,
            backgroundColor: _midWhite,
            label: Text(
              AppStrings.createAccountButton,
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            onPressed: () => {},
            // onPressed: signIn,
          ),
        ),
      ]),
    );
  }

  void navigateToPage(dynamic page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page()),
    );
  }
}
