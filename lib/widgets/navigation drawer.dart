import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:technicians/layouts/global%20search.dart';
import 'package:technicians/layouts/login.dart';
import 'package:technicians/layouts/payment%20options.dart';
import 'package:technicians/layouts/set%20personal%20details.dart';
import 'package:technicians/layouts/stepper.dart';
import 'package:technicians/layouts/technician%20reviews.dart';
import 'package:technicians/layouts/test%20dashboard.dart';
import 'package:technicians/layouts/user%20favourites.dart';
import 'package:technicians/main.dart';
import 'package:technicians/widgets/slider.dart';

import '../utils/strings enum.dart';

class NavDrawer extends StatefulWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  SharedPreferences? prefs;

  String _currentUserFirstName = "";
  String _currentUserFamilyName = "";
  String? _currentUserProfilePicLink;
  String _currentUserGender = "";
  int _currentUserAge = 0;
  String _currentUserProvince = "";
  String _currentUserCity = "";
  int _currentUserPhoneNumber = 0;
  bool _hasProfilePic = false;

  Future<void> getPrefs() async {
    prefs = await SharedPreferences.getInstance();

    _currentUserFirstName = prefs!.getString(AppStrings.currentUserFirstName)!;
    _currentUserFamilyName =
        prefs!.getString(AppStrings.currentUserFamilyName)!;
    _currentUserProfilePicLink =
        prefs!.getString(AppStrings.currentUserProfilePicLink)!;
    _currentUserGender = prefs!.getString(AppStrings.currentUserGender)!;
    _currentUserAge = prefs!.getInt(AppStrings.currentUserAge)!;
    _currentUserProvince = prefs!.getString(AppStrings.currentUserProvince)!;
    _currentUserPhoneNumber = prefs!.getInt(AppStrings.currentUserPhoneNumber)!;
    _currentUserCity = prefs!.getString(AppStrings.currentUserCity)!;
    _hasProfilePic =
        prefs!.getString(AppStrings.currentUserProfilePicLink) != 'na' &&
            prefs!.getString(AppStrings.currentUserProfilePicLink) != null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getPrefs(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return SafeArea(
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(30.0),
                bottomRight: Radius.circular(30.0),
              ),
              child: Container(
                width: 250,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Color.fromARGB(180, 250, 250, 250),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(31, 38, 135, 0.4),
                      blurRadius: 8.0,
                    )
                  ],
                ),
                child: Stack(
                  children: [
                    SizedBox(
                      child: ClipRRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: 4.0,
                            sigmaY: 4.0,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Colors.grey.withOpacity(0.0),
                                Colors.white.withOpacity(0.2),
                              ]),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        DrawerHeader(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: _currentUserProfilePicLink == 'na'
                                    ? Container(
                                        margin: EdgeInsets.all(5),
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white),
                                        child: Icon(
                                          Icons.person,
                                          size: 45,
                                          color: Colors.black12,
                                        ))
                                    : CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            _currentUserProfilePicLink!),
                                        radius: 30.0,
                                      ),
                              ),
                              SizedBox(
                                width: 20.0,
                              ),
                              Expanded(
                                  flex: 2,
                                  child: Text(_currentUserFirstName +
                                      " " +
                                      _currentUserFamilyName))
                            ],
                          ),
                        ),
                        Expanded(
                          child: ListView(
                            children: [
                              Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () => {
                                    Navigator.pop(context),
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SetPersonalDetails(
                                                true,
                                                false,
                                                age: _currentUserAge,
                                                city: _currentUserCity,
                                                familyName:
                                                    _currentUserFamilyName,
                                                firstName:
                                                    _currentUserFirstName,
                                                gender: _currentUserGender,
                                                phoneNumber:
                                                    _currentUserPhoneNumber,
                                                profilePicLink:
                                                    _currentUserProfilePicLink,
                                                province: _currentUserProvince,
                                              )),
                                    ),
                                  },
                                  child: ListTile(
                                    leading: Icon(
                                      Icons.person,
                                      color: Colors.black,
                                    ),
                                    title: Text("My Profile"),
                                  ),
                                ),
                              ),
                              Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () => {
                                    Navigator.of(context)
                                        .pushNamedAndRemoveUntil(
                                            '/dashboard or login',
                                            (Route<dynamic> route) => false)
                                    // Navigator.pop(context),
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //       builder: (context) => LoginLayout()),
                                    // ),
                                  },
                                  child: ListTile(
                                    leading: Icon(
                                      Icons.dashboard,
                                      color: Colors.black,
                                    ),
                                    title: Text("My Dashboard"),
                                  ),
                                ),
                              ),
                              Material(
                                //todo: add confirm logout
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: ()=>{ Navigator.pop(context),
                                    Navigator.push(context,
                                      MaterialPageRoute(
                                          builder: (context) => PaymentOptions()))},
                                  child: ListTile(
                                    leading: Icon(
                                      Icons.credit_card_outlined,
                                      color: Colors.black,
                                    ),
                                    title: Text("Payment"),
                                  ),
                                ),
                              ),
                              Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    // Navigator.of(context)
                                    //     .pushNamedAndRemoveUntil('/dashboard or login',
                                    //         (Route<dynamic> route) => false);
                                    Navigator.pop(context);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              UserFavourites()), //TODO: pass user uid here
                                    );
                                  },
                                  child: ListTile(
                                    leading: Icon(
                                      Icons.favorite,
                                      color: Colors.black,
                                    ),
                                    title: Text("My Favourites"),
                                  ),
                                ),
                              ),
                              // Material(
                              //   color: Colors.transparent,
                              //   child: InkWell(
                              //     onTap: () {
                              //       Navigator.pop(context);
                              //       Navigator.push(
                              //         context,
                              //         MaterialPageRoute(
                              //             builder: (context) =>
                              //                 TechnicianReviews(true, null)),
                              //       );
                              //     },
                              //     child: ListTile(
                              //       leading: Icon(
                              //         Icons.reviews,
                              //         color: Colors.black,
                              //       ),
                              //       title: Text("My Reviews"),
                              //     ),
                              //   ),
                              // ),
                              Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => GlobalSearch()),
                                    );
                                  },
                                  child: ListTile(
                                    leading: Icon(
                                      Icons.search,
                                      color: Colors.black,
                                    ),
                                    title: Text("Search"),
                                  ),
                                ),
                              ),
                              Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                TestDashboard()));
                                  },
                                  child: ListTile(
                                    leading: Icon(
                                      Icons.settings,
                                      color: Colors.black,
                                    ),
                                    title: Text("Settings"),
                                  ),
                                ),
                              ),
                              Material(
                                //todo: add confirm logout
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: confirmLogout,
                                  child: ListTile(
                                    leading: Icon(
                                      Icons.logout,
                                      color: Colors.black,
                                    ),
                                    title: Text("Log Out"),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return SizedBox(
            height: MediaQuery.of(context).size.height - 125,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Lottie.asset('assets/loading gear.json',
                        height: 75,
                        width: 75,
                        alignment: Alignment.center,
                        animate: true),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        "Loading...",
                        style: TextStyle(
                            color: Colors.black54, fontWeight: FontWeight.bold),
                      )),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Future<void> confirmLogout() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              // margin:
              // EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: Align(
                  alignment: Alignment.topCenter,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.5),
                      child: Container(
                        padding: EdgeInsets.all(25),
                        height: double.infinity,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            border: Border.all(width: 2, color: Colors.white),
                            color: Colors.grey.shade200.withOpacity(0.25)),
                        child: Column(
                          children: [
                            Align(
                                alignment: Alignment.topCenter,
                                child: Text(
                                  "Confirm Logout?",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                )),
                            SizedBox(
                              height: 12.5,
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceAround,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: CircleAvatar(
                                      maxRadius: 40,
                                      backgroundColor: Colors.red,
                                      child: Icon(
                                        Icons.close_rounded,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                      signOut();
                                    },
                                    child: CircleAvatar(
                                      maxRadius: 40,
                                      backgroundColor: Colors.green,
                                      child: Icon(
                                        Icons.done,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ))),
        );
      },
    );
  }


  void signOut() async {
    Fluttertoast.cancel();

    try {
      await FirebaseAuth.instance.signOut();
      Fluttertoast.showToast(
          backgroundColor: Colors.green,
          msg: "Logout successful",
          toastLength: Toast.LENGTH_LONG);

      //successfully logged out
      if(FirebaseAuth.instance.currentUser==null){
        await prefs?.setString(AppStrings.currentUserFirstName, '');
        await prefs?.setString(AppStrings.currentUserFamilyName, '');
        await prefs?.setInt(AppStrings.currentUserPhoneNumber, 0);
        await prefs?.setString(AppStrings.currentUserProvince, '');
        await prefs?.setString(AppStrings.currentUserCity, '');
        await prefs?.setInt(AppStrings.currentUserAge, 0);
        await prefs?.setString(AppStrings.currentUserGender, '');
        await prefs?.setString(AppStrings.currentUserAddress, '');
        await prefs?.setString(AppStrings.currentUserProfilePicLink, 'na');
      }
    } catch (e) {
      debugPrint(e.toString());
      Fluttertoast.showToast(
          backgroundColor: Colors.red,
          msg: e.toString(),
          toastLength: Toast.LENGTH_LONG);
    }

  }
}
