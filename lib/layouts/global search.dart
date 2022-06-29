import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:technicians/layouts/technician%20profile%20page.dart';
import 'package:technicians/models/technician%20object.dart';
import 'package:technicians/utils/hex%20colors.dart';
import 'package:technicians/utils/strings%20common%20issues.dart';
import 'package:technicians/utils/strings%20enum.dart';
import 'package:technicians/widgets/slider.dart';

class GlobalSearch extends StatefulWidget {
  const GlobalSearch({Key? key}) : super(key: key);

  @override
  State<GlobalSearch> createState() => _GlobalSearchState();
}
//TODO: circular progress bar when searching, and display "no result" when nothing found

class _GlobalSearchState extends State<GlobalSearch> {
  bool isNotSearchedYet = true;

  final Color _midblack = Colors.black54;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController familyNameController = TextEditingController();
  TextEditingController jobTitleController = TextEditingController();
  List<String> spinnerItems = CommonIssues.listOfTechnicianCategories;
  String? dropdownValue;
  List<Technician> listOfSearchedTechnicians = [];

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Search"),
        ),
        body: Container(
          padding: EdgeInsets.all(16),
          child: isNotSearchedYet ? ListView(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            children: [
              myController(firstNameController, 1, "first name..."),
              myController(familyNameController, 1, "family name..."),
              DropdownButton<String>(
                value: dropdownValue,
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
                    dropdownValue = data!;
                  });
                },
                items:
                    spinnerItems.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              Text(
                "Job: ${dropdownValue ?? "Select"}",
                style: TextStyle(fontSize: 17),
              ),
              SizedBox(
                height: 15,
              ),
              FloatingActionButton.extended(
                onPressed: () {
                  String firstName = firstNameController.text.trim().toString();
                  String familyName =
                      familyNameController.text.trim().toString();
                  if (dropdownValue != null &&
                      firstName.isNotEmpty &&
                      familyName.isNotEmpty) {
                    globalSearch(firstName, familyName, dropdownValue!);
                  } else {
                    Fluttertoast.showToast(
                        msg: "Fill all fields first",
                        backgroundColor: Colors.red);
                  }
                },
                label: Text("GO"),
                icon: Icon(Icons.search),
              )
            ],
          ) :
          ListView.builder(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemCount: listOfSearchedTechnicians.length,
              itemBuilder: (context, index) {
                return Container(
                    height: 100,
                    padding: const EdgeInsets.symmetric(
                        vertical: 1, horizontal: 4),
                    child: listOfSearchedTechnicians.isNotEmpty ?
                    Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.all(
                            Radius.circular(15)),
                        splashColor: Colors.redAccent,
                        onTap: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    TechnicianMainProfilePage(
                                        listOfSearchedTechnicians[index].technicianUid!)
                            ),
                          )
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius:
                              BorderRadius.all(Radius.circular(15))),
                          child: Row(children: <Widget>[
                            Expanded(
                              child: Row(
                                children: <Widget>[
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(0, 16, 0, 16),
                                    child: Stack(
                                        children:[
                                          CircleAvatar(
                                            // backgroundImage:
                                            // AppStrings.techniciansList[index].image,
                                            backgroundColor: Colors.grey,
                                            maxRadius: 30,
                                          ),
                                          Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Visibility(
                                              visible: listOfSearchedTechnicians[index]
                                                  .isAvailable!,
                                              child: CircleAvatar(
                                                  maxRadius: 7,
                                                  backgroundColor: Colors.green
                                              ),
                                            ),
                                          )
                                        ]
                                    ),
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.fromLTRB(
                                          0, 23, 16, 16),
                                      color: Colors.transparent,
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            listOfSearchedTechnicians[index]
                                                .firstName ?? "null",
                                            style: TextStyle(
                                                fontSize: 16),
                                          ),
                                          SizedBox(
                                            height: 6,
                                          ),
                                          Text(
                                            listOfSearchedTechnicians[index]
                                                .jobTitle ?? "null",
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.grey
                                                    .shade600,
                                                fontWeight:
                                                FontWeight.bold),
                                            maxLines: 1,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(16,16,0,16),
                                    child: Column(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                          child: Row(
                                            children: [
                                              Text(
                                                listOfSearchedTechnicians[index]
                                                    .rating.toString(),
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: listOfSearchedTechnicians[index]
                                                        .isAvailable!
                                                        ? FontWeight.bold
                                                        : FontWeight.normal),
                                              ),
                                              Container(
                                                margin:
                                                EdgeInsets.fromLTRB(5, 0, 16, 0),
                                                child: Icon(
                                                  Icons.star,
                                                  size: 16,
                                                  color: HexColor("FFD700"),
                                                ),
                                              ),
                                            ],
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
                    ) : slider());
              })
          ,
        ),
      ),
    );
  }

  Future<void> globalSearch(
      String firstName, String familyName, String jobTitle) async {
    try {
      String capitalizedFirstName = firstName.capitalize();
      String capitalizedFamilyName = familyName.capitalize();

      var ref = FirebaseFirestore.instance.collection("technicians");
      await ref
          .where(AppStrings.firstNameKey, isEqualTo: capitalizedFirstName)
          .where(AppStrings.familyNameKey, isEqualTo: capitalizedFamilyName)
          .where(AppStrings.jobTitleKey, isEqualTo: jobTitle)
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
          isNotSearchedYet = false;
        });
      } else {
        Fluttertoast.showToast(msg: "No results found", backgroundColor: Colors.red);
      }

    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Widget myController(
      TextEditingController controller, int maxLines, String labelText) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        textAlignVertical: TextAlignVertical.top,
        controller: controller,
        maxLines: maxLines,
        textInputAction: TextInputAction.next,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        // validator: (value) => value != null && value.length < 6
        //     ? "Password can't be less than 6 characters"
        //     : null,
        decoration: InputDecoration(
          alignLabelWithHint: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide(
              color: _midblack,
              width: 1.25,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          labelText: labelText,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: _midblack, width: 2.5),
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
