import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:technicians/models/consumer%20object.dart';
import 'package:technicians/utils/strings%20enum.dart';
import 'dart:async';
import 'dart:io';

class SetPersonalDetails extends StatefulWidget {
  final bool isEditMode;
  const SetPersonalDetails(this.isEditMode, {Key? key}) : super(key: key);

  @override
  State<SetPersonalDetails> createState() => _SetPersonalDetailsState();
}

class _SetPersonalDetailsState extends State<SetPersonalDetails> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController familyNameController = TextEditingController();
  TextEditingController subLocationController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  late var prefs;

  List<int> spinnerItemsAge = [for(var i=18; i<100; i+=1) i];
  List<String> spinnerItemsLoc = AppStrings.locationsList;
  String? dropdownLocation;
  final Color _midblack = Colors.black54;
  final Color _midBlue = Colors.blueAccent;
  final Color _blackText = Colors.black;
  int? dropdownAge;
  File? file;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    //TODO: use a stepper here
    return Material(
      child: FutureBuilder(
        future: getCurrentUserInfo(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              body: Form(
                key: _formKey,
                child: ListView(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        controller: firstNameController,
                        maxLines: 1,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) => value!.length < 2
                            ? "Names have to be 2 letters at least"
                            : null,
                        style: TextStyle(color: _blackText),
                        decoration: InputDecoration(
                          hintText: firstNameFromDb ?? "",
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: _midBlue,
                              width: 1.25,
                            ),
                          ),
                          prefixIcon: Icon(
                            Icons.lock,
                            color: _midBlue,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          labelText: "first name",
                          labelStyle: TextStyle(color: _blackText),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: _midBlue, width: 2.5),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(

                        controller: familyNameController,
                        maxLines: 1,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) => value!.length < 2
                            ? "Names have to be 2 letters at least"
                            : null,
                        style: TextStyle(color: _blackText),
                        decoration: InputDecoration(
                          hintText: familyNameFromDb ?? "",
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: _midBlue,
                              width: 1.25,
                            ),
                          ),
                          prefixIcon: Icon(
                            Icons.lock,
                            color: _midBlue,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          labelText: "family name",
                          labelStyle: TextStyle(color: _blackText),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: _midBlue, width: 2.5),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                      ),
                    ),
                    DropdownButton<int>(
                      menuMaxHeight: 200,
                      isExpanded: true,
                      alignment: Alignment.center,
                      value: dropdownAge,
                      hint: Text(ageFromDb ?? "Age"),
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: Colors.black, fontSize: 18),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (data) {
                        setState(() {
                          dropdownAge = data!;
                        });
                      },
                      items:
                      spinnerItemsAge.map<DropdownMenuItem<int>>((int value) {
                        return DropdownMenuItem<int>(
                          value: value,
                          child: Text(value.toString()),
                        );
                      }).toList(),
                    ),
                    Text(
                      "Age: ${dropdownAge ?? "Select Age"}",
                      style: TextStyle(fontSize: 17),
                    ),
                    DropdownButton<String>(
                      menuMaxHeight: 200,
                      value: dropdownLocation,
                      icon: Icon(Icons.arrow_drop_down),
                      hint: Text(locationFromDb ?? "Location"),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: Colors.black, fontSize: 18),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (data) {
                        setState(() {
                          dropdownLocation = data!;
                        });
                      },
                      items:
                      spinnerItemsLoc.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    Text(
                      "Location: ${dropdownLocation ?? "Select Location"}",
                      style: TextStyle(fontSize: 17),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        controller: subLocationController,
                        maxLines: 1,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        style: TextStyle(color: _blackText),
                        decoration: InputDecoration(
                          hintText: subLocationFromDb ?? "",
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: _midBlue,
                              width: 1.25,
                            ),
                          ),
                          prefixIcon: Icon(
                            Icons.lock,
                            color: _midBlue,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          labelText: "sub location",
                          labelStyle: TextStyle(color: _blackText),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: _midBlue, width: 2.5),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        ElevatedButton(
                            onPressed: selectProfileImage,
                            child: Text("Select profile picture")),
                        Spacer(),
                        Visibility(
                          visible: profilePicFromDb != null,
                          child: FittedBox(
                            fit: BoxFit.fill,
                            child: profilePicFromDb == null ? CircleAvatar(
                              backgroundColor: Colors.green,
                              maxRadius: 75,
                            ) :
                            CircleAvatar(
                              radius: 75.0,
                              backgroundImage : NetworkImage(profilePicFromDb!),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: profilePicFromDb == null,
                          child: FittedBox(
                            fit: BoxFit.fill,
                            child: file == null ? CircleAvatar(
                              backgroundColor: Colors.grey,
                              maxRadius: 75,
                            ) :
                            CircleAvatar(
                              radius: 75.0,
                              backgroundImage : FileImage(file!),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        controller: phoneNumberController,
                        maxLines: 1,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        autovalidateMode: AutovalidateMode.onUserInteraction,

                        //TODO: some way to validate if the phone number is real or not
                        //TODO: someway to prevent same phone number from registering twice
                        validator: (value) => value!.length != 11
                            ? "Insert a valid phone number"
                            : null,

                        style: TextStyle(color: _blackText),
                        decoration: InputDecoration(
                          hintText: phoneNumberFromDb ?? "",
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: _midBlue,
                              width: 1.25,
                            ),
                          ),
                          prefixIcon: Icon(
                            Icons.lock,
                            color: _midBlue,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          labelText: "Phone number",
                          labelStyle: TextStyle(color: _blackText),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: _midBlue, width: 2.5),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(onPressed: saveIntoDb, child: Text("Save"))
                  ],
                ),
              ),
            );
          }
          else {
            return Center(child: CircularProgressIndicator.adaptive(),);
          }
        },

      ),
    );
  }

  String? firstNameFromDb;
  String? familyNameFromDb;
  String? phoneNumberFromDb;
  String? locationFromDb;
  String? subLocationFromDb;
  String? profilePicFromDb;
  String? ageFromDb; //todo: put this, removed atm cuz not all users have it


  Future<void> getCurrentUserInfo() async {
    var userCollections = FirebaseFirestore.instance.collection("users");
    var user = FirebaseAuth.instance.currentUser;

    await userCollections
        .where(AppStrings.userUidKey,
        isEqualTo:
        user!.uid)
        .get()
        .then((value) async {
      for (var element in value.docs) {
        firstNameFromDb = element.data()[AppStrings.firstNameKey];
        familyNameFromDb = element.data()[AppStrings.familyNameKey];
        phoneNumberFromDb = (element.data()[AppStrings.phoneNumberKey]).toString();
        locationFromDb = element.data()[AppStrings.locationKey];
        subLocationFromDb = element.data()[AppStrings.subLocationKey];
        ageFromDb = (element.data()[AppStrings.ageKey]).toString();
        profilePicFromDb = (element.data()[AppStrings.imageKey]).toString();

      }
    });

        }

  Future<void> saveIntoDb() async {
    bool formValid = _formKey.currentState!.validate(); //TODO: use an actual key/reqs

    if(formValid) {
      try{
        var userRef = FirebaseFirestore.instance.collection("users");
        var currentUser = FirebaseAuth.instance.currentUser;

        await uploadImageToFirebase(file!);

        userRef.doc(currentUser!.uid).set({ //<--- TODO: change to currentUser

          AppStrings.firstNameKey : firstNameController.text.trim().toString(),
          AppStrings.familyNameKey : familyNameController.text.trim().toString(),
          AppStrings.ageKey : dropdownAge,
          AppStrings.locationKey : dropdownLocation,
          AppStrings.subLocationKey : subLocationController.text.toLowerCase().trim().toString(),
          AppStrings.phoneNumberKey : phoneNumberController.text.trim().toString(),
          AppStrings.imageKey : profilePicUrl,

        }, SetOptions(merge: true));
        Fluttertoast.showToast(msg: "Saved", backgroundColor: Colors.greenAccent);

        await prefs.setBool(AppStrings.isSetBasicInfo, true);

        Navigator.of(context).pushNamedAndRemoveUntil(
            '/dashboard or login', (Route<dynamic> route) => false);

        await prefs?.setString(AppStrings.currentUserFirstName, firstNameController.text.trim().toString());
        await prefs?.setString(AppStrings.currentUserFamilyName, familyNameController.text.trim().toString());
        await prefs?.setString(AppStrings.currentUserProfilePicLink, profilePicUrl);

      }catch (e) {
        debugPrint(e.toString());
        Fluttertoast.showToast(msg: "Error saving data", backgroundColor: Colors.redAccent);
      }

    }

  }

  UploadTask? uploadTask;
  String? profilePicUrl;

  Future uploadImageToFirebase(
      dynamic image) async {

    try{
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
      debugPrint("Download link: $profilePicUrl");
    } catch (e) {
      debugPrint(e.toString());
      Fluttertoast.showToast(msg: "Error uploading profile pic",backgroundColor: Colors.redAccent);
    }

  }

  Future selectProfileImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png', 'svg']);

    if (result != null) {
      setState(() =>
      file = File(result.files.single.path!));
    }
    else {
      // User canceled the picker
    }
  }}

