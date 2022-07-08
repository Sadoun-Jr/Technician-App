import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:technicians/models/consumer%20object.dart';
import 'package:technicians/utils/strings%20enum.dart';
import 'dart:async';
import 'dart:io';

import '../utils/egypt cities.dart';
import '../utils/hex colors.dart';
import '../widgets/navigation drawer.dart';

class SetPersonalDetails extends StatefulWidget {
  final bool isEditMode;
  final String? firstName;
  final String? familyName;
  final String? gender;
  final int? age;
  final String? province;
  final String? city;
  final String? profilePicLink;
  final int? phoneNumber;
  final bool isFirstTimeUser;

  const SetPersonalDetails(
      this.isEditMode,
      this.isFirstTimeUser,
      {Key? key,
      required this.firstName,
      required this.familyName,
      required this.gender,
      required this.age,
      required this.province,
      required this.city,
      required this.profilePicLink,
      required this.phoneNumber})
      : super(key: key);

  @override
  State<SetPersonalDetails> createState() => _SetPersonalDetailsState();
}

class Tag {
  List<String> citiesNotNull = [];

  @override
  bool operator ==(Object other) =>
      other is Tag && other.citiesNotNull == citiesNotNull;

  @override
  int get hashCode => citiesNotNull.hashCode;
}

class _SetPersonalDetailsState extends State<SetPersonalDetails> {
  Map<String, Map<String, String>> allCitiesEngAndArabic =
      EgyptCities.citiesInEnglishAndArabic;
  Map<String, List<String>?> citiesArabic = {
    "Alexandria": null, //done
    "Aswan": null, //done
    "Asyut": null, //done
    "Beheira": null, //done
    "Beni Suef": null,
    "Cairo": null, //done
    "Dakahlia": null, //done
    "Damietta": null, //done
    "Fayoum": null, //done
    "Gharbia": null, //done
    "Giza": null, //done
    "Ismailia": null, //done
    "Kafr El Sheikh": null, //done
    "Luxor": null, //done
    "Matruh": null, //done
    "Minya": null, //done
    "Monufia": null, //done
    "New Valley": null, //done
    "North Sinai": null, //done
    "Port Said": null, //done
    "Qalyubia": null, //done
    "Qena": null, //done
    "Red Sea": null, //done
    "Sharqia": null, //done
    "Sohag": null, //done
    "South Sinai": null, //done
    "Suez": null, //done
  };

  final _formKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController familyNameController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController provinceController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  late Future<void> userInfo;

  late var prefs;

  List<int> spinnerItemsAge = [for (var i = 18; i < 100; i += 1) i];
  List<String> spinnerItemsGender = ['Male', 'Female'];
  List<String> spinnerItemsProvinces = AppStrings.locationsList;
  List<String> spinnerCities = ['Select a province first'];
  Map cities = AppStrings.citiesMap;
  final Color _midblack = Colors.black54;
  final Color _midBlue = Colors.blueAccent;
  final Color _blackText = Colors.black;
  String? profilePicLink;
  File? file;
  String? gender;
  int? age;
  String? province;
  String? city;
  String? address;
  bool _deletedProfilePic = false;
  bool _isSaving = false;
  bool hasSetProfileInfo = false;

  ///used because dropdown button bugs out after selecting a different province, so allow user to select just once
  bool _selectedCity = false;

  // final Color _btnColor = HexColor("#d4c4ca");
  final Color _splashClr = Colors.white;

  ///color for text and buttons
  final Color _darkTxtClr = HexColor("#96878D");
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    userInfo = getCurrentUserInfo();

    ///cities resulting from looping through each province in the map

    ///value map for the loop
    Map<String, String> valueMap = {};

    allCitiesEngAndArabic.forEach((keyMain, value) {
      List<String> citiesInOneProvince = [];
      valueMap = value;

      valueMap.forEach((keySmall, value) {
        citiesInOneProvince.add(value);
      });

      citiesArabic[keyMain] = citiesInOneProvince;

      // debugPrint('cities arabic being created: ${citiesArabic[keyMain]}');
      // citiesInOneProvince.clear();
    });

    // debugPrint('[after looping] spinner has: ${citiesArabic.toString()}');
  }

  Widget dropDownSelection({
    required String hint,
    required String validatorError,
    required List<dynamic> spinnerItemsList,
    required String? dataFromDb,
    required TextEditingController controller,
  }) {
    bool isCity = hint == 'المدينة';
    // debugPrint("Starting, province from db is: $provinceFromDb");
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: DropdownButtonFormField2(
        decoration: InputDecoration(
            //Add isDense true and zero Padding.
            //Add Horizontal padding using buttonPadding and Vertical padding by
            // increasing buttonHeight instead of add Padding here so that the whole
            // TextField Button become clickable,
            // and also the dropdown menu open under The whole TextField Button.
            isDense: true,
            // contentPadding: EdgeInsets.symmetric(horizontal: 25),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            //Add more decoration as you want here
            //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: BorderSide(
                color: _darkTxtClr,
                width: 1.25,
              ),
            ),
            labelText: //dataFromDb == null ? "" :
                hint),

        isExpanded: true,
        dropdownMaxHeight: hint == 'المدينة' || hint == 'المحافظة' ? 500 : 250,
        scrollbarAlwaysShow: true,
        // hint: Text(
        //   dataFromDb ??
        //       hint,
        //   style: TextStyle(fontSize: 14),
        // ),
        icon: const Icon(
          Icons.arrow_drop_down,
          color: Colors.black45,
        ),
        buttonHeight: 30,
        // buttonPadding: const EdgeInsets.only(left: 20, right: 10),
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        items: spinnerItemsList
            .map((item) => DropdownMenuItem<dynamic>(
                  value: item,
                  child: Text(
                    '$item',
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ))
            .toList(),
        validator: (value) {
          if (value == null) {
            return validatorError;
          }
          return null;
        },
        // searchController: controller,
        onChanged: (value) {
          //Do something when changing the item if you want.
          switch (hint) {
            case 'Gender':
              gender = value.toString();
              break;

            case 'Age':
              age = value as int?;
              break;

            case 'المحافظة':
              setState(() {
                // debugPrint('spinner has: ${citiesArabic.toString()}');
                province = value.toString();
                spinnerCities = citiesArabic[province]!;
                // debugPrint('spinner length is ${spinnerCities.length} and has: ${spinnerCities.toString()}');
              });
              break;

            case 'المدينة':
              setState(() {
                city = value as String;
                _selectedCity = true;
              });
              break;
          }
          debugPrint("Changed $hint to $value");
        },
        onSaved: (value) {},
      ),
    );
  }

  Widget textWithUnderLine(String text, IconData iconData) {
    return //====title====
        Row(
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(20, 3, 0, 0),
          child: Icon(
            iconData,
            color: _darkTxtClr,
          ),
        ),
        Container(
            margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                shadows: [Shadow(color: _darkTxtClr, offset: Offset(0, -10))],
                color: Colors.transparent,
                decoration: TextDecoration.underline,
                decorationColor: Colors.white,
                decorationThickness: 3,
              ),
            )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(
        'has profile pic is ${_hasProfilePic}\nhas temp pic is $_tempProfilePicSet');

    //TODO: use a stepper here
    return WillPopScope(
      onWillPop: () async {
        await showDialog(
            context: context,
            builder: (_) => Dialog(
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
                              filter:
                                  ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.5),
                              child: Container(
                                padding: EdgeInsets.all(25),
                                height: double.infinity,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                    border: Border.all(
                                        width: 2, color: Colors.white),
                                    color:
                                        Colors.grey.shade200.withOpacity(0.25)),
                                child: Column(
                                  children: [
                                    Align(
                                        alignment: Alignment.topCenter,
                                        child: Text(
                                          "Leaving without saving will not save any info",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18),
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
                                            onTap: () async {
                                              _isSaving = false;
                                              _tempProfilePicSet = false;

                                              //first time user hasn't set info so don't go to main page
                                              if(widget.isFirstTimeUser){
                                                Fluttertoast.cancel();
                                                await prefs!.setBool(AppStrings.hasSetProfileInfo, false);
                                                Fluttertoast.showToast(msg: 'Please set profile info to use the app', backgroundColor: Colors.red);
                                                return;
                                              }

                                              Navigator.of(context).pushNamedAndRemoveUntil(
                                                  '/dashboard or login', (Route<dynamic> route) => false);
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
                ));
        return false;
      },
      child: Material(
        child: _isSaving
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset('assets/loading gear.json',
                      height: 75, width: 75),
                  Text(
                    'Saving',
                    style: TextStyle(fontSize: 17),
                  )
                ],
              )
            : FutureBuilder(
                future: userInfo,
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Scaffold(
                      floatingActionButton: FloatingActionButton(
                        backgroundColor: _darkTxtClr,
                        onPressed: () {
                          saveIntoDb();
                        },
                        child: Icon(Icons.save),
                      ),
                      key: _scaffoldKey,
                      // drawer: NavDrawer(),
                      // extendBodyBehindAppBar: true,
                      appBar: AppBar(
                        leadingWidth: 50,
                        toolbarHeight: MediaQuery.of(context).size.height / 10,
                        backgroundColor: HexColor("#96878D"),
                        title: Text("Profile details"),
                        leading: Container(
                          margin: EdgeInsets.symmetric(horizontal: 15),
                          child: IconButton(
                            icon: Icon(
                              Icons.person,
                              color: Colors.white,
                            ),
                            onPressed: null,
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(5)
                                // Radius.elliptical(MediaQuery.of(context).size.width, 32)
                                )),
                      ),
                      body: Stack(
                        children: [
                          Image.asset(
                            "assets/abstract bg.jpg",
                            fit: BoxFit.cover,
                            height: double.infinity,
                            width: double.infinity,
                            alignment: Alignment.center,
                          ),
                          Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16),
                              child: Align(
                                  alignment: Alignment.topCenter,
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                          sigmaX: 10.0, sigmaY: 10.0),
                                      child: Container(
                                        width: double.infinity,
                                        height: double.infinity,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30)),
                                            border: Border.all(
                                                width: 3, color: Colors.white),
                                            color: Colors.grey.shade200
                                                .withOpacity(0.25)),
                                        child: Center(
                                          child: Form(
                                            key: _formKey,
                                            child: ListView(
                                              shrinkWrap: true,
                                              physics: ScrollPhysics(),
                                              children: [
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                //======profile pic=======
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    //profile pic already set in db
                                                    Visibility(
                                                      visible: _hasProfilePic && !_tempProfilePicSet,
                                                      child: FittedBox(
                                                          fit: BoxFit.fill,
                                                          child: Container(
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .transparent,
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  ),
                                                              //profile pic exists in db
                                                              child:
                                                                  CircleAvatar(
                                                                backgroundColor:
                                                                    Colors
                                                                        .transparent,
                                                                radius: 45.0,
                                                                backgroundImage:
                                                                    NetworkImage(
                                                                        prefs?.getString(
                                                                            AppStrings.currentUserProfilePicLink)),
                                                              ))),
                                                    ),

                                                    //no profile pic in db
                                                    Visibility(
                                                        visible:
                                                            _tempProfilePicSet,
                                                        child: FittedBox(
                                                            fit: BoxFit.fill,
                                                            child: Container(
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .red,
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    ),
                                                                //profile pic exists in db
                                                                child: CircleAvatar(
                                                                        radius:
                                                                            45.0,
                                                                        backgroundImage: _tempProfilePicSet ?
                                                                            FileImage(File(file!.path)) : null,
                                                                      )
                                                                    ))),

                                                    //no profile pic set
                                                    Visibility(
                                                      visible: !_hasProfilePic &&
                                                          !_tempProfilePicSet,
                                                      child: FittedBox(
                                                          fit: BoxFit.fill,
                                                          child: Container(
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .transparent,
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  ),
                                                              //profile pic exists in db
                                                              child: Container(
                                                                padding: EdgeInsets.all(5),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                  child: Icon(
                                                                    Icons
                                                                        .person,
                                                                    size: 60,
                                                                    color: Colors
                                                                        .black12,
                                                                  )))),
                                                    )
                                                  ],
                                                ),

                                                //====profile pic actions=====
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Visibility(
                                                        visible: true,
                                                        // !_deletedProfilePic,
                                                        child: IconButton(
                                                            color: _darkTxtClr,
                                                            tooltip:
                                                                "Change profile image",
                                                            onPressed:
                                                                selectProfileImage,
                                                            icon: Icon(
                                                                Icons.edit))),
                                                    Container(
                                                      height: 20,
                                                      width: 2,
                                                      color: Colors.white,
                                                    ),
                                                    IconButton(
                                                        color: _darkTxtClr,
                                                        tooltip:
                                                            "Delete profile image",
                                                        onPressed:
                                                            _confirmDeleteProfilePic,
                                                        icon:
                                                            Icon(Icons.delete)),
                                                  ],
                                                ),

                                                SizedBox(
                                                  height: 5,
                                                ),
                                                textWithUnderLine(
                                                    'Personal Information',
                                                    Icons.person),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                //====first and family names====
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 1,
                                                      child: Container(
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 5,
                                                                vertical: 10),
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10),
                                                        child: TextFormField(
                                                          controller:
                                                              firstNameController,
                                                          maxLines: 1,
                                                          keyboardType:
                                                              TextInputType
                                                                  .name,
                                                          textInputAction:
                                                              TextInputAction
                                                                  .next,
                                                          autovalidateMode:
                                                              AutovalidateMode
                                                                  .onUserInteraction,
                                                          validator: (value) =>
                                                              value!.length < 2
                                                                  ? "Names have to be 2 letters at least"
                                                                  : null,
                                                          style: TextStyle(
                                                              color:
                                                                  _blackText),
                                                          decoration:
                                                              InputDecoration(
                                                            // contentPadding: EdgeInsets.symmetric(horizontal: 25),
                                                            // fillColor: Colors.white54,
                                                            // filled: true,
                                                            hintText:
                                                                firstNameFromDb ??
                                                                    "",
                                                            enabledBorder:
                                                                OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          25.0),
                                                              borderSide:
                                                                  BorderSide(
                                                                color:
                                                                    _darkTxtClr,
                                                                width: 1.25,
                                                              ),
                                                            ),
                                                            border:
                                                                OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20.0),
                                                            ),
                                                            labelText:
                                                                "First name",
                                                            labelStyle: TextStyle(
                                                                color:
                                                                    _darkTxtClr),
                                                            // focusedBorder: OutlineInputBorder(
                                                            //   borderSide: BorderSide(
                                                            //       color: _darkTxtClr, width: 2.5),
                                                            //   borderRadius: BorderRadius.circular(25.0),
                                                            // ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Container(
                                                        margin: const EdgeInsets
                                                                .symmetric(
                                                            horizontal: 5),
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10),
                                                        child: TextFormField(
                                                          controller:
                                                              familyNameController,
                                                          maxLines: 1,
                                                          keyboardType:
                                                              TextInputType
                                                                  .name,
                                                          textInputAction:
                                                              TextInputAction
                                                                  .next,
                                                          autovalidateMode:
                                                              AutovalidateMode
                                                                  .onUserInteraction,
                                                          validator: (value) =>
                                                              value!.length < 2
                                                                  ? "Names have to be 2 letters at least"
                                                                  : null,
                                                          style: TextStyle(
                                                              color:
                                                                  _blackText),
                                                          decoration:
                                                              InputDecoration(
                                                            // contentPadding: EdgeInsets.symmetric(horizontal: 25),
                                                            // fillColor: Colors.white54,
                                                            // filled: true,
                                                            hintText:
                                                                familyNameFromDb ??
                                                                    "",
                                                            enabledBorder:
                                                                OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          25.0),
                                                              borderSide:
                                                                  BorderSide(
                                                                color:
                                                                    _darkTxtClr,
                                                                width: 1.25,
                                                              ),
                                                            ),
                                                            border:
                                                                OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20.0),
                                                            ),
                                                            labelText:
                                                                "Family name",
                                                            labelStyle: TextStyle(
                                                                color:
                                                                    _darkTxtClr),
                                                            // focusedBorder: OutlineInputBorder(
                                                            //   borderSide: BorderSide(
                                                            //       color: _darkTxtClr, width: 2.5),
                                                            //   borderRadius: BorderRadius.circular(25.0),
                                                            // ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),

                                                //=====gender and age====
                                                Row(
                                                  children: [
                                                    Expanded(
                                                        flex: 1,
                                                        child:
                                                            dropDownSelection(
                                                                dataFromDb:
                                                                    gender, //todo: change to genderFromDb
                                                                hint: 'Gender',
                                                                validatorError:
                                                                    'Select gender',
                                                                controller:
                                                                    genderController,
                                                                spinnerItemsList:
                                                                    spinnerItemsGender)),
                                                    Expanded(
                                                        flex: 1,
                                                        child: dropDownSelection(
                                                            dataFromDb:
                                                                ageFromDb
                                                                    .toString(),
                                                            hint: 'Age',
                                                            validatorError:
                                                                'Select age',
                                                            spinnerItemsList:
                                                                spinnerItemsAge,
                                                            controller:
                                                                ageController))
                                                  ],
                                                ),

                                                SizedBox(
                                                  height: 15,
                                                ),
                                                textWithUnderLine('Location',
                                                    Icons.location_on_rounded),
                                                SizedBox(
                                                  height: 25,
                                                ),

                                                //=====location=====
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 1,
                                                      child: IgnorePointer(
                                                        ignoring: _selectedCity,
                                                        child: dropDownSelection(
                                                            hint: 'المحافظة',
                                                            dataFromDb:
                                                                provinceFromDb,
                                                            validatorError:
                                                                'Select a province',
                                                            spinnerItemsList:
                                                                spinnerItemsProvinces,
                                                            controller:
                                                                provinceController),
                                                      ),
                                                    ),
                                                    Expanded(
                                                        flex: 1,
                                                        child: dropDownSelection(
                                                            dataFromDb:
                                                                cityFromDb,
                                                            hint: 'المدينة',
                                                            validatorError:
                                                                'Select a city',
                                                            controller:
                                                                cityController,
                                                            spinnerItemsList:
                                                                spinnerCities))
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                textWithUnderLine(
                                                    'Contact', Icons.phone),
                                                SizedBox(
                                                  height: 15,
                                                ),

                                                //=====phone and address======
                                                Container(
                                                  margin:
                                                      const EdgeInsets.fromLTRB(
                                                          10, 0, 10, 0),
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child: TextFormField(
                                                    controller:
                                                        phoneNumberController,
                                                    maxLines: 1,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    autovalidateMode:
                                                        AutovalidateMode
                                                            .onUserInteraction,

                                                    //TODO: some way to validate if the phone number is real or not
                                                    //TODO: someway to prevent same phone number from registering twice
                                                    validator: (value) => value!
                                                                .length !=
                                                            11
                                                        ? "Insert a valid phone number"
                                                        : null,

                                                    style: TextStyle(
                                                        color: _blackText),
                                                    decoration: InputDecoration(
                                                      hintText:
                                                          phoneNumberFromDb ==
                                                                  null
                                                              ? phoneNumberFromDb
                                                                  .toString()
                                                              : "",
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(25.0),
                                                        borderSide: BorderSide(
                                                          color: _darkTxtClr,
                                                          width: 1.25,
                                                        ),
                                                      ),
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20.0),
                                                      ),
                                                      labelText: "Phone number",
                                                      labelStyle: TextStyle(
                                                          color: _darkTxtClr),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: _midBlue,
                                                            width: 2.5),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(25.0),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  margin:
                                                      const EdgeInsets.fromLTRB(
                                                          10, 0, 10, 0),
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child: TextFormField(
                                                    controller:
                                                        addressController,
                                                    maxLines: 1,
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    autovalidateMode:
                                                        AutovalidateMode
                                                            .onUserInteraction,
                                                    validator: (value) => value!
                                                                .length <
                                                            15
                                                        ? "Insert your address"
                                                        : null,
                                                    style: TextStyle(
                                                        color: _blackText),
                                                    decoration: InputDecoration(
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(25.0),
                                                        borderSide: BorderSide(
                                                          color: _darkTxtClr,
                                                          width: 1.25,
                                                        ),
                                                      ),
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20.0),
                                                      ),
                                                      labelText: "Address",
                                                      labelStyle: TextStyle(
                                                          color: _darkTxtClr),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: _midBlue,
                                                            width: 2.5),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(25.0),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 15,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ))),
                        ],
                      ),
                    );
                  } else {
                    return Stack(
                      children: [
                        Image.asset(
                          "assets/abstract bg.jpg",
                          fit: BoxFit.cover,
                          height: double.infinity,
                          width: double.infinity,
                          alignment: Alignment.center,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Lottie.asset(
                                      'assets/loading gear.json',
                                      height: 75,
                                      width: 75,
                                      alignment: Alignment.bottomCenter,
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
                                          color: Colors.black54,
                                          fontWeight: FontWeight.bold),
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
      ),
    );
  }

  String? firstNameFromDb;
  String? familyNameFromDb;
  int? phoneNumberFromDb;
  String? provinceFromDb;
  String? cityFromDb;
  String? profilePicFromDb;
  int? ageFromDb; //todo: put this, removed atm cuz not all users have it
  String? genderFromDb; //todo: put this, removed atm cuz not all users have it
  String? addressfromDb;
  bool _hasProfilePic = false;
  bool _tempProfilePicSet = false;

  Future<void> getCurrentUserInfo() async {
    try {
      prefs = await SharedPreferences.getInstance();

      firstNameFromDb = prefs?.getString(AppStrings.currentUserFirstName) ?? "";
      firstNameController.text = firstNameFromDb!;

      familyNameFromDb =
          prefs?.getString(AppStrings.currentUserFamilyName) ?? "";
      familyNameController.text = familyNameFromDb!;

      phoneNumberFromDb = prefs?.getInt(AppStrings.currentUserPhoneNumber) ?? 0;
      phoneNumberController.text = phoneNumberFromDb.toString();

      provinceFromDb = prefs!.getString(AppStrings.currentUserProvince)!;
      // provinceController.text = provinceFromDb.toString();

      cityFromDb = prefs!.getString(AppStrings.currentUserCity)!;
      // cityController.text = cityFromDb.toString();

      ageFromDb = prefs!.getInt(AppStrings.currentUserAge)!;
      // ageController.text = ageFromDb.toString();

      genderFromDb = prefs!.getString(AppStrings.currentUserGender)!;
      // genderController.text = genderFromDb!;

      addressfromDb = prefs!.getString(AppStrings.currentUserAddress);
      addressController.text = addressfromDb!;

      profilePicFromDb =
          prefs!.getString(AppStrings.currentUserProfilePicLink)!;

      debugPrint(
          '====prefs link${prefs!.getString(AppStrings.currentUserProfilePicLink)}====');
      _hasProfilePic =
          prefs!.getString(AppStrings.currentUserProfilePicLink) != 'na' &&
              prefs!.getString(AppStrings.currentUserProfilePicLink) != null;

      debugPrint("Received user info \n"
          "first name: $firstNameFromDb\n"
          "family name: $familyNameFromDb\n"
          "gender: $genderFromDb\n"
          "age: $ageFromDb\n"
          "province: $provinceFromDb\n"
          "city: $cityFromDb\n"
          "phone: $phoneNumberFromDb\n"
          "address: $addressfromDb\n"
          "profile pic ? : $_hasProfilePic\n"
          "profile pic: $profilePicFromDb\n");
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> saveIntoDb() async {
    bool _noImage = true;
    bool formValid = _formKey.currentState!.validate();

    if (formValid) {
      try {
        final result = await InternetAddress.lookup('example.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          debugPrint('connected');
        }
      } on SocketException catch (_) {
        Fluttertoast.showToast(
            msg: "No internet connection", backgroundColor: Colors.red);
        return;
      }
      setState(() => _isSaving = true);

      try {
        var userRef = FirebaseFirestore.instance.collection("users");
        var currentUser = FirebaseAuth.instance.currentUser;

        if (file != null) {
          _noImage = false;
          await uploadImageToFirebase(file!);
        }

        debugPrint('is profile pic null? ${file == null}');
        await userRef.doc(currentUser!.uid).set({
          AppStrings.firstNameKey: firstNameController.text.trim().toString(),
          AppStrings.familyNameKey: familyNameController.text.trim().toString(),
          AppStrings.genderKey: gender,
          AppStrings.ageKey: age,
          AppStrings.locationKey: province,
          AppStrings.subLocationKey: city,
          AppStrings.phoneNumberKey:
              int.parse(phoneNumberController.text.trim()),
          AppStrings.addressKey: addressController.text.toString().trim(),
          AppStrings.imageKey: _noImage
              ? prefs?.getString(AppStrings.currentUserProfilePicLink) ?? 'na'
              : profilePicUrl,
        }, SetOptions(merge: true)).then((value)  async {

        //save into shared prefs for quick easy access later on
        await prefs.setBool(AppStrings.isSetBasicInfo, true);

        await prefs?.setString(AppStrings.currentUserFirstName,
            firstNameController.text.trim().toString());

        await prefs?.setString(AppStrings.currentUserFamilyName,
            familyNameController.text.trim().toString());

        await prefs?.setString(AppStrings.currentUserGender, gender);

        await prefs?.setInt(AppStrings.currentUserAge, age);

        await prefs?.setString(AppStrings.currentUserProvince, province);

        await prefs?.setString(AppStrings.currentUserCity, city);

        await prefs?.setString(AppStrings.currentUserAddress,
            addressController.text.toString().trim());

        await prefs?.setInt(AppStrings.currentUserPhoneNumber,
            int.parse(phoneNumberController.text.toString().trim()));

        //profile pic choosen
        if (file != null) {
          await prefs!.setString(
              AppStrings.currentUserProfilePicLink, profilePicUrl);
          debugPrint('saving this link right now : ${profilePicUrl}');
          await prefs!.setBool(AppStrings.hasProfilePic, true);
        } else {
          await prefs!.setString(AppStrings.currentUserProfilePicLink, 'na');
          await prefs!.setBool(AppStrings.hasProfilePic, false);
        }

        debugPrint("Saved user info \n"
            "first name: ${firstNameController.text.trim().toString()}\n"
            "family name: ${familyNameController.text.trim().toString()}\n"
            "gender: $gender\n"
            "age: $age\n"
            "province: $province\n"
            "city: $city\n"
            "phone: ${phoneNumberController.text.toString().trim()}\n"
            "address: ${addressController.text.toString().trim()}\n"
            "has profile pic? : ${_hasProfilePic}\n"
            "profile pic: $profilePicUrl\n");

        //user not first time anymore since he set the profile details
        await prefs!.setBool(AppStrings.isFirstTimeUser, false);
        await prefs!.setBool(AppStrings.hasSetProfileInfo, true);

        Navigator.of(context).pushNamedAndRemoveUntil(
              '/dashboard or login', (Route<dynamic> route) => false);

        Fluttertoast.showToast(
            msg: "Saved", backgroundColor: Colors.greenAccent);
        setState(() => _isSaving = false);

        });

      } catch (e) {
        debugPrint(e.toString());
        Fluttertoast.showToast(
            msg: "Error saving data", backgroundColor: Colors.redAccent);
        setState(() => _isSaving = false);
      }
    }
  }

  Future<void> _confirmDeleteProfilePic() async {
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
                                  "Delete profile picture?",
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
                                      setState(() {
                                        _deletedProfilePic = true;
                                        _tempProfilePicSet = false;
                                        file = null;
                                        profilePicUrl = 'na';
                                        prefs!.setString(AppStrings.currentUserProfilePicLink, 'na');
                                        prefs!.setBool(AppStrings.hasProfilePic, false);
                                      });
                                      Navigator.pop(context);
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

  UploadTask? uploadTask;
  String? profilePicUrl;

  Future uploadImageToFirebase(dynamic image) async {
    try {
      // Create a Reference to the file
      Reference ref = FirebaseStorage.instance
          .ref()
          .child(FirebaseAuth.instance.currentUser!.uid)
          .child("/profile_pic")
          .child("/${file!.path}");
      setState(() {
        uploadTask = ref.putFile(image);
      });

      final snapShot = await uploadTask!.whenComplete(() => {});
      profilePicUrl = await snapShot.ref.getDownloadURL();
      setState(() {
        uploadTask = null;
      });

      await prefs!
          .setString(AppStrings.currentUserProfilePicLink, profilePicUrl);

      debugPrint("Download link: $profilePicUrl");
    } catch (e) {
      debugPrint(e.toString());
      Fluttertoast.showToast(
          msg: "Error uploading profile pic",
          backgroundColor: Colors.redAccent);
    }
  }

  Future selectProfileImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png', 'svg']);

    if (result != null) {
      setState(() {
        file = File(result.files.single.path!);
        _deletedProfilePic = false;
        _tempProfilePicSet = true;
      });
    } else {
      // User canceled the picker
    }
  }

  @override
  void dispose() {
    super.dispose();
    addressController.dispose();
    phoneNumberController.dispose();
    firstNameController.dispose();
    familyNameController.dispose();
    genderController.dispose();
    ageController.dispose();
    provinceController.dispose();
    cityController.dispose();

  }
}
