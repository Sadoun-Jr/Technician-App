import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:technicians/layouts/login.dart';
import 'package:technicians/main.dart';
import 'package:technicians/utils/hex%20colors.dart';
import 'package:technicians/widgets/glass%20box.dart';
import 'package:technicians/widgets/slider.dart';
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
  final formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController emailController = TextEditingController();


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
          child: Form(
            key: formKey,
            child: TextFormField(
              textInputAction: TextInputAction.next,
              controller: emailController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (email) =>
              email != null && !EmailValidator.validate(email)
                  ? "Enter a valid Email"
                  : null,
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
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          padding: const EdgeInsets.all(10),
          child: TextFormField(
            controller: passwordController,
            maxLines: 1,
            obscureText: true,
            textInputAction: TextInputAction.next,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) => value != null && value.length < 6
                ? "Password can't be less than 6 characters"
                : null,
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
            obscureText: true,
            textInputAction: TextInputAction.next,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) => value != passwordController.text.trim()
                ? "Type the same password in the confirm field"
                : null,
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
            onPressed: () => {
            signUp()
            },
            // onPressed: signIn,
          ),
        ),
      ]),
    );
  }

  Future signUp() async {
    Fluttertoast.cancel();
    final isValid = formKey.currentState!.validate();

    if (!isValid) {
      Fluttertoast.showToast(msg: "Fill the form correctly",
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.red
      );

      return;
    }

    // showDialog(
    //   context: context,
    //   barrierDismissible: false,
    //   builder: (context) => Center(child: slider()),
    // );

    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      ).then((value) async {
          User? user = FirebaseAuth.instance.currentUser;
          await FirebaseFirestore.instance
              .collection("users")
              .doc(user?.uid)
              .set({
            "uid": user?.uid,
            "email": emailController.text.trim(),
            "role": "user"
          });
      });
      Fluttertoast.showToast(msg: AppStrings.userRegistered,
      backgroundColor: Colors.green, toastLength: Toast.LENGTH_SHORT);
      // navigatorKey.currentState!.popUntil((route) => route.isFirst);
      // navigatorKey.currentState!.popUntil((route) => route.isFirst);

      Navigator.of(context).pushNamedAndRemoveUntil(
          '/dashboard or login', (Route<dynamic> route) => false);

    } catch (e) {
      debugPrint("Sign up error: " + e.toString());
      Fluttertoast.showToast(msg: AppStrings.userRegistered,
          backgroundColor: Colors.red, toastLength: Toast.LENGTH_LONG);
    }
  }



}
