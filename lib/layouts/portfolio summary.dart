import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:technicians/layouts/create%20portfolio%20item.dart';
import 'package:technicians/layouts/single%20portfolio%20item.dart';
import 'package:technicians/layouts/view%20detailed%20portfolio%20item.dart';
import 'package:technicians/models/portfolio%20object.dart';
import 'package:technicians/utils/strings%20enum.dart';
import 'package:technicians/widgets/slider.dart';

import '../utils/hex colors.dart';

class PortfolioSummary extends StatefulWidget {
  final String technicianUid;
  const PortfolioSummary(this.technicianUid, {Key? key}) : super(key: key);

  @override
  State<PortfolioSummary> createState() => _PortfolioSummaryState();
}

class _PortfolioSummaryState extends State<PortfolioSummary> {
  late String techNameFromUid;
  late List<Portfolio> listOfPortfolioItems;
  late String thumbnailImage;
  String fullName = '';
  late Future<void> getPortfolioData;

  @override
  void initState() {
    super.initState();
    getPortfolioData = getPortfolioItems();
  }

  Future<String> changeUidToName(String uid, bool isUser) async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        // debugPrint('connected');
      }
    } on SocketException catch (_) {
      Fluttertoast.showToast(
          msg: "No internet connection", backgroundColor: Colors.red);
      return 'null';
    }

    String? firstName;
    String? familyName;

    var myRef = isUser
        ? FirebaseFirestore.instance.collection("users")
        : FirebaseFirestore.instance.collection("technicians");
    await myRef
        .where(isUser ? AppStrings.userUidKey : AppStrings.technicianUidKey,
            isEqualTo: uid)
        .get()
        .then((value) => {
              for (var element in value.docs)
                {
                  firstName = element.data()[AppStrings.firstNameKey],
                  familyName = element.data()[AppStrings.familyNameKey],
                }
            });
    fullName = '$firstName $familyName';
    return "$firstName $familyName";
  }

  Future<void> getPortfolioItems() async {
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

    listOfPortfolioItems = [];
    debugPrint(
        "Started fetching portfolio items for: " "${widget.technicianUid}");
    var issueCollection = FirebaseFirestore.instance.collection("portfolios");
    var user = FirebaseAuth.instance.currentUser;
    techNameFromUid = (await changeUidToName(widget.technicianUid, false));

    try {
      await issueCollection
          .where(AppStrings.issuedByKey,
              isEqualTo: widget.technicianUid) //TODO: change this to dynamic
          .get()
          .then((value) async {
        for (var element in value.docs) {
          Portfolio portfolio = Portfolio(
            portfolioUid: element.data()[AppStrings.portfolioUidkey],
            title: element.data()[AppStrings.titlekey] ?? "No Title",
            desc: element.data()[AppStrings.portfolioDesckey] ?? "No desc",
            issuedBy: element.data()[AppStrings.issuedByKey],
            dateAdded: element.data()[AppStrings.dateAddedkey],
            numberOfViews: element.data()[AppStrings.numberOfViewskey],
            numberOfPictures: element.data()[AppStrings.numberOfPictureskey],
            numberOfFavourites:
                element.data()[AppStrings.numberOfFavouritesKey],
            listOfImagePaths: element.data()[AppStrings.listOfImagePathskey],
          );

          listOfPortfolioItems.add(portfolio);
        }
      });
    } catch (e) {
      e.toString();
    }
    debugPrint("# of portfolio items: ${listOfPortfolioItems.length}");
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: FutureBuilder(
        future: getPortfolioData,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              key: _scaffoldKey,
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                leadingWidth: 50,
                toolbarHeight: MediaQuery.of(context).size.height / 10,
                backgroundColor: HexColor("#96878D"),
                title: Text('${fullName}\'s Portfolio'),
              ),
              floatingActionButton: addNewPortfolioItem(),
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
                    color: Colors.transparent,
                    padding: EdgeInsets.all(16),
                    child: ListView(
                      physics: ScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      children: [
                        GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemCount: listOfPortfolioItems.length,
                          itemBuilder: (BuildContext context, int index) {
                            return portFolioGridItem(index);
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return SizedBox(
              height: MediaQuery.of(context).size.height - 125,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Image.asset(
                    "assets/abstract bg.jpg",
                    fit: BoxFit.cover,
                    height: double.infinity,
                    width: double.infinity,
                    alignment: Alignment.center,
                  ),
                  Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Lottie.asset('assets/loading gear.json',
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
                ],
              ),
            );
          }
        },
      ),
    );
  }
  final Color _darkTxtClr = HexColor("#96878D");

  Widget portFolioGridItem(int index) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(25.0),
        splashColor: _darkTxtClr,
        onTap: () {
          final urlImages = listOfPortfolioItems[index].listOfImagePaths;
          final desc = listOfPortfolioItems[index].desc;
          if (urlImages!.isNotEmpty) {
            Navigator.push(
                this.context,
                MaterialPageRoute(
                    builder: (context) => ViewDetailedPortfolioItem(
                        urlImages, index, desc!, false)));
          } else {
            Fluttertoast.cancel();
            Fluttertoast.showToast(
                msg: "No images in this portfolio item",
                backgroundColor: Colors.red);
          }
        },
        child: Hero(
          tag: index,
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0)),
            margin: EdgeInsets.all(5),
            elevation: 4,
            child: Stack(children: [
              listOfPortfolioItems[index].listOfImagePaths!.isEmpty
                  ? Container(
                      decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.all(Radius.circular(25))))
                  : ClipRRect(
                borderRadius: BorderRadius.circular(25.0),

                child: Image(
                      height: double.infinity,
                      width: double.infinity,
                      fit: BoxFit.fill,
                      image: NetworkImage(Uri.parse(
                              listOfPortfolioItems[index]
                                  .listOfImagePaths!
                                  .first)
                          .toString()),
                    ),
                  ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.all(Radius.circular(25))),
              ),
              Center(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "${listOfPortfolioItems[index].title}",
                    style: TextStyle(color: Colors.white),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  bool isTapped = false;

  Widget addNewPortfolioItem() {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(this.context,
            MaterialPageRoute(builder: (context) => CreatePortfolioItem()));
      },
      backgroundColor: _darkTxtClr,
      heroTag: 100,
      child: Icon(Icons.add),
    );
  }
}
