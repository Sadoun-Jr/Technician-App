import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:technicians/layouts/technician%20profile%20page.dart';
import 'package:technicians/models/technician%20object.dart';
import 'package:technicians/utils/hex%20colors.dart';
import 'package:technicians/utils/strings%20common%20issues.dart';
import 'package:technicians/utils/strings%20enum.dart';
import 'package:technicians/widgets/slider.dart';

import '../widgets/navigation drawer.dart';

class GlobalSearch extends StatefulWidget {
  const GlobalSearch({Key? key}) : super(key: key);

  @override
  State<GlobalSearch> createState() => _GlobalSearchState();
}
//TODO: circular progress bar when searching, and display "no result" when nothing found

class _GlobalSearchState extends State<GlobalSearch> {
  ///check if finished searching to adjust layout
  bool isNotSearchedYet = true;

  final Color _midblack = Colors.black54;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController familyNameController = TextEditingController();
  TextEditingController jobTitleController = TextEditingController();
  List<String> spinnerItems = CommonIssues.listOfTechnicianCategories;
  String? dropdownValue;
  List<Technician> listOfSearchedTechnicians = [];
  final Color _darkTxtClr = HexColor("#96878D");
  final Color _splashClr = Colors.white;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  ///used to display searching animation
  bool _isSearching = false;


  final Color _lightPrimary = HexColor("#d4c4ca");

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        key: _scaffoldKey,
        drawer: NavDrawer(),
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leadingWidth: 50,
          toolbarHeight: MediaQuery.of(context).size.height / 10,
          backgroundColor: HexColor("#96878D"),
          title: Text("Search"),
          leading: Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: IconButton(
              icon: Icon(Icons.list),
              onPressed: () => _scaffoldKey.currentState?.openDrawer(),
            ),
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                  bottom:
                  Radius.circular(5)
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
            Visibility(
              visible: _isSearching,
                child: Column(
                  children: [
                    Expanded(
                      flex:4,
                      child: Align(alignment: Alignment.bottomCenter,
                          child: Lottie.asset("assets/searching.json")),
                    ),
                    Expanded(flex:1,child: Align(
                      alignment: Alignment.topCenter,
                      child: Text("Searching...",style: TextStyle(fontSize: 18),),
                    ))
                  ],
                )
            ),
            Visibility(
              visible: !_isSearching,
              child: Container(
                padding: isNotSearchedYet ? EdgeInsets.all(16) : null,
                child: isNotSearchedYet ? ListView(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  children: [
                    Container(
                      margin: EdgeInsets.all(16),
                      child: Text("Type the inputs that you want", style: TextStyle(fontSize: 18),),
                    ),
                    customTextEditor(firstNameController, 1, "First name"),
                    customTextEditor(familyNameController, 1, "Family name"),

                    //=========search by job============
                    // DropdownButton<String>(
                    //   value: dropdownValue,
                    //   icon: Icon(Icons.arrow_drop_down),
                    //   iconSize: 24,
                    //   elevation: 16,
                    //   style: TextStyle(color: Colors.black, fontSize: 18),
                    //   underline: Container(
                    //     height: 2,
                    //     color: Colors.deepPurpleAccent,
                    //   ),
                    //   onChanged: (data) {
                    //     setState(() {
                    //       dropdownValue = data!;
                    //     });
                    //   },
                    //   items:
                    //       spinnerItems.map<DropdownMenuItem<String>>((String value) {
                    //     return DropdownMenuItem<String>(
                    //       value: value,
                    //       child: Text(value),
                    //     );
                    //   }).toList(),
                    // ),

                    // Text(
                    //   "Job: ${dropdownValue ?? "Select"}",
                    //   style: TextStyle(fontSize: 17),
                    // ),

                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      margin: EdgeInsets.all(8),
                      child: FloatingActionButton.extended(
                        backgroundColor: _darkTxtClr,
                        onPressed: () {
                          String firstName = firstNameController.text.trim().toString();
                          String familyName =
                              familyNameController.text.trim().toString();
                          if (
                          // dropdownValue != null &&
                              firstName.isNotEmpty &&
                              familyName.isNotEmpty) {
                            setState(() => _isSearching = true);
                            globalSearchByFirstAndFamilyName(firstName, familyName,);// dropdownValue!);
                          }
                          else if(firstName.isNotEmpty && familyName.isEmpty){
                            setState(() => _isSearching = true);
                            globalSearchByFirstName(firstName);// dropdownValue!);

                          }
                          else {
                            Fluttertoast.showToast(
                                msg: "Fill at least first name",
                                backgroundColor: Colors.red);
                          }
                        },
                        label: Text("GO"),
                        icon: Icon(Icons.search),
                      ),
                    )
                  ],
                ) :
                ListView.builder(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemCount: listOfSearchedTechnicians.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.fromLTRB(5, 10, 5, 80),
                        child: ListView(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          children: <Widget>[
                            Container(
                              height: MediaQuery.of(context).size.height - 190,
                              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: listOfSearchedTechnicians.isNotEmpty
                                  ? ListView.builder(
                                  shrinkWrap: true,
                                  physics: ScrollPhysics(),
                                  itemCount: listOfSearchedTechnicians.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      height: 100,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 1, horizontal: 4),
                                      child: Align(
                                        alignment: Alignment.topCenter,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30)),
                                          child: BackdropFilter(
                                            filter: ImageFilter.blur(
                                                sigmaX: 10.0, sigmaY: 10.0),
                                            child: Material(
                                              color: Colors.white54,
                                              child: Container(
                                                width: double.infinity,
                                                height: 90,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(30)),
                                                    border: Border.all(
                                                        width: 2,
                                                        color: Colors.white),
                                                    color: Colors.grey.shade200
                                                        .withOpacity(0.25)),
                                                child: InkWell(
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(30)),
                                                  splashColor: _splashClr,
                                                    onTap: () => Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) => TechnicianMainProfilePage(
                                                                listOfSearchedTechnicians[index].technicianUid!))),
                                                  child: AnimatedContainer(
                                                    duration:
                                                    Duration(milliseconds: 200),
                                                    decoration: BoxDecoration(
                                                        color:Colors
                                                            .transparent,
                                                        borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                30))),
                                                    child: Row(children: <Widget>[
                                                      Expanded(
                                                        child: Row(
                                                          children: <Widget>[
                                                            SizedBox(
                                                              width: 16,
                                                            ),
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .fromLTRB(
                                                                  0, 16, 0, 16),
                                                              child: Stack(
                                                                  children: [
                                                                    listOfSearchedTechnicians[index]
                                                                        .image ==
                                                                        null
                                                                        ? Container(
                                                                        decoration: BoxDecoration(
                                                                            shape: BoxShape
                                                                                .circle,
                                                                            color: Colors
                                                                                .white),
                                                                        child:
                                                                        Icon(
                                                                          Icons
                                                                              .person,
                                                                          size:
                                                                          57.5,
                                                                          color:
                                                                          Colors.black12,
                                                                        ))
                                                                        : Container(
                                                                      decoration: BoxDecoration(
                                                                          shape:
                                                                          BoxShape.circle,
                                                                          border: Border.all(width: 2, color: Colors.white)),
                                                                      child:
                                                                      CircleAvatar(
                                                                        backgroundColor:
                                                                        Colors.white70,
                                                                        maxRadius:
                                                                        28.5,
                                                                        backgroundImage:
                                                                        NetworkImage(listOfSearchedTechnicians[index].image!),
                                                                        // child: Image.network(
                                                                        //   myAssignedTech!.image!, height: 125, width: 125,),
                                                                      ),
                                                                    ),
                                                                    Align(
                                                                      alignment:
                                                                      Alignment
                                                                          .bottomCenter,
                                                                      child:
                                                                      Visibility(
                                                                        visible: listOfSearchedTechnicians[
                                                                        index]
                                                                            .isAvailable!,
                                                                        child: CircleAvatar(
                                                                            maxRadius:
                                                                            7,
                                                                            backgroundColor:
                                                                            Colors.green),
                                                                      ),
                                                                    )
                                                                  ]),
                                                            ),
                                                            SizedBox(
                                                              width: 16,
                                                            ),
                                                            Expanded(
                                                              child: Container(
                                                                margin: EdgeInsets
                                                                    .fromLTRB(0, 23,
                                                                    16, 16),
                                                                color: Colors
                                                                    .transparent,
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                                  children: <
                                                                      Widget>[
                                                                    Row(
                                                                      children: [
                                                                        Text(
                                                                          listOfSearchedTechnicians[index]
                                                                              .firstName ??
                                                                              "null",
                                                                          style: TextStyle(
                                                                              fontSize:
                                                                              18),
                                                                        ),
                                                                        SizedBox(
                                                                          width: 5,
                                                                        ),
                                                                        Text(
                                                                          listOfSearchedTechnicians[index]
                                                                              .familyName ??
                                                                              "null",
                                                                          style: TextStyle(
                                                                              fontSize:
                                                                              18),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                      height: 6,
                                                                    ),
                                                                    Expanded(
                                                                      child: Text(
                                                                        listOfSearchedTechnicians[index]
                                                                            .jobTitle ??
                                                                            "null",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                            13,
                                                                            color: Colors
                                                                                .grey
                                                                                .shade600,
                                                                            fontWeight:
                                                                            FontWeight.bold),
                                                                        maxLines: 1,
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              padding: EdgeInsets
                                                                  .fromLTRB(16, 16,
                                                                  0, 16),
                                                              child: Column(
                                                                children: [
                                                                  Expanded(
                                                                    child:
                                                                    Container(
                                                                      margin: EdgeInsets
                                                                          .fromLTRB(
                                                                          0,
                                                                          5,
                                                                          10,
                                                                          0),
                                                                      child: Column(
                                                                        children: [
                                                                          Row(
                                                                            children: [
                                                                              Text(
                                                                                listOfSearchedTechnicians[index].rating.toString(),
                                                                                style:
                                                                                TextStyle(fontSize: 16, fontWeight: listOfSearchedTechnicians[index].isAvailable! ? FontWeight.bold : FontWeight.normal),
                                                                              ),
                                                                              Container(
                                                                                margin: EdgeInsets.fromLTRB(
                                                                                    5,
                                                                                    0,
                                                                                    16,
                                                                                    0),
                                                                                child: Icon(Icons.star,
                                                                                    size: 16,
                                                                                    color: Colors.orangeAccent
                                                                                  // HexColor(
                                                                                  //     "FFD700"),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          SizedBox(
                                                                              height:
                                                                              7),
                                                                          Align(
                                                                              alignment: Alignment
                                                                                  .bottomCenter,
                                                                              child:
                                                                              Text(listOfSearchedTechnicians[index].location ?? "")),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ]),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  })
                                  : Center(
                                child: Column(
                                  children: [
                                    Expanded(
                                      flex: 6,
                                      child: Lottie.asset(
                                        "assets/searching.json",
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        "No technicians, please try another issue.",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    })
                ,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> globalSearchByFirstAndFamilyName(
      String firstName, String familyName,
      // String jobTitle
      ) async {
    try {
      String capitalizedFirstName = firstName.capitalize();
      String capitalizedFamilyName = familyName.capitalize();

      var ref = FirebaseFirestore.instance.collection("technicians");
      await ref
          .where(AppStrings.firstNameKey, isEqualTo: capitalizedFirstName)
          .where(AppStrings.familyNameKey, isEqualTo: capitalizedFamilyName)
          // .where(AppStrings.jobTitleKey, isEqualTo: jobTitle)
          .get()
          .then((value) {
        value.docs.forEach((element) {
          Technician technician = Technician.mini(
            technicianUid: element.data()[AppStrings.technicianUidKey],
            familyName: element.data()[AppStrings.familyNameKey],
            image: element.data()[AppStrings.imageKey],
            isAvailable: element.data()[AppStrings.isAvailableKey],
            //CHECK THIS
            location: element.data()[AppStrings.locationKey],
            jobTitle: element.data()[AppStrings.jobTitleKey],
            //NULL, ADD IT IN DB
            rating: double.parse(
                element.data()[AppStrings.overallRatingKey].toString()),
            firstName: element.data()[AppStrings.firstNameKey],
            techDesc: element.data()[AppStrings.issueDescKey],
          );

          listOfSearchedTechnicians.add(technician);

          debugPrint("search has ${listOfSearchedTechnicians
              .length} results");
        });
      });

      if(listOfSearchedTechnicians.isNotEmpty) {
        setState(() {
          _isSearching = false;
          isNotSearchedYet = false;
        });
      } else {
        Fluttertoast.showToast(msg: "No results found", backgroundColor: Colors.red);
        setState(() => _isSearching = false);
      }

    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> globalSearchByFirstName(
      String firstName
      // String jobTitle
      ) async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        // debugPrint('connected');
      }
    } on SocketException catch (_) {
      Fluttertoast.showToast(
          msg: "No internet connection", backgroundColor: Colors.red);
      return;
    }
    try {
      String capitalizedFirstName = firstName.capitalize();

      var ref = FirebaseFirestore.instance.collection("technicians");
      await ref
          .where(AppStrings.firstNameKey, isEqualTo: capitalizedFirstName)
      // .where(AppStrings.jobTitleKey, isEqualTo: jobTitle)
          .get()
          .then((value) {
        value.docs.forEach((element) {
          Technician technician = Technician.mini(
            technicianUid: element.data()[AppStrings.technicianUidKey],
            familyName: element.data()[AppStrings.familyNameKey],
            image: element.data()[AppStrings.imageKey],
            isAvailable: element.data()[AppStrings.isAvailableKey],
            //CHECK THIS
            location: element.data()[AppStrings.locationKey],
            jobTitle: element.data()[AppStrings.jobTitleKey],
            //NULL, ADD IT IN DB
            rating: double.parse(
                element.data()[AppStrings.overallRatingKey].toString()),
            firstName: element.data()[AppStrings.firstNameKey],
            techDesc: element.data()[AppStrings.issueDescKey],
          );

          listOfSearchedTechnicians.add(technician);

          debugPrint("search has ${listOfSearchedTechnicians
              .length} results");
        });
      });

      if(listOfSearchedTechnicians.isNotEmpty) {
        setState(() {
          _isSearching = false;
          isNotSearchedYet = false;
        });
      } else {
        Fluttertoast.showToast(msg: "No results found", backgroundColor: Colors.red);
        setState(() => _isSearching = false);
      }

    } catch (e) {
      debugPrint(e.toString());
    }
  }


  Widget customTextEditor(
      TextEditingController controller, int maxLines, String labelText) {
    return Container(
      // margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        textAlignVertical: TextAlignVertical.top,
        controller: controller,
        maxLines: maxLines,
                cursorColor: _darkTxtClr,
                textInputAction: TextInputAction.next,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        // validator: (value) => value != null && value.length < 6
        //     ? "Password can't be less than 6 characters"
        //     : null,
        decoration: InputDecoration(
                    fillColor: Colors.white54,
          filled: true,
          alignLabelWithHint: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide(
              color: _darkTxtClr,
              width: 1.25,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          labelText: labelText,
          labelStyle: TextStyle(color: _darkTxtClr),
          hintStyle: TextStyle(color: _darkTxtClr),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: _darkTxtClr, width: 2.5),
            borderRadius: BorderRadius.circular(25.0),
          ),
        ),
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
