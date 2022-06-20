import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
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

class PortfolioSummary extends StatefulWidget {
  final String technicianUid;
  const PortfolioSummary(this.technicianUid,{Key? key}) : super(key: key);

  @override
  State<PortfolioSummary> createState() => _PortfolioSummaryState();
}

class _PortfolioSummaryState extends State<PortfolioSummary> {

  late String techNameFromUid;
  late List<Portfolio> listOfPortfolioItems;
  late String thumbnailImage;

  Future<String> changeUidToName(String uid, bool isUser) async {
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

    return "$firstName $familyName";
  }

  Future<void> getPortfolioItems() async {
    listOfPortfolioItems = [];
    debugPrint("Started fetching portfolio items for: " "${widget.technicianUid}");
    var issueCollection = FirebaseFirestore.instance.collection("portfolios");
    var user = FirebaseAuth.instance.currentUser;
    techNameFromUid = (await changeUidToName(widget.technicianUid, false));

    try{
      await issueCollection
          .where(AppStrings.issuedByKey,
          isEqualTo:
          widget.technicianUid) //TODO: change this to dynamic
          .get()
          .then((value) async {
        for (var element in value.docs) {

          Portfolio portfolio = Portfolio(
            portfolioUid: element.data()[AppStrings.portfolioUidkey],
            title:element.data()[AppStrings.titlekey] ?? "No Title",
            desc:element.data()[AppStrings.portfolioDesckey] ?? "No desc",
            issuedBy:element.data()[AppStrings.issuedByKey],
            dateAdded:element.data()[AppStrings.dateAddedkey],
            numberOfViews:element.data()[AppStrings.numberOfViewskey],
            numberOfPictures: element.data()[AppStrings.numberOfPictureskey],
            numberOfFavourites:element.data()[AppStrings.numberOfFavouritesKey],
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


  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        floatingActionButton: addNewPortfolioItem(),
        body: FutureBuilder(
          future: getPortfolioItems(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Container(
                color: Colors.transparent,
                padding: EdgeInsets.all(16),
                child: ListView(
                  physics: ScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        shape: BoxShape.circle,
                      ),
                      child: InkWell(
                        onTap: () {},
                        child: Stack(children: const [
                          Align(
                            alignment: Alignment.topCenter,
                            child: CircleAvatar(
                              maxRadius: 100,
                              backgroundColor: Colors.grey,
                            ),
                          ),
                          Positioned(
                            bottom: 15,
                            left: 250,
                            child: CircleAvatar(
                              backgroundColor: Colors.green,
                              maxRadius: 10,
                            ),
                          ),
                        ]),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0,20,0,20),
                      child: Text(
                        "$techNameFromUid's Portfolio", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                    GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3),
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount: listOfPortfolioItems.length,
                      itemBuilder: (BuildContext context, int index) {
                        return portFolioGridItem(index);
                      },
                    )
                  ],
                ),
              );
            } else {
              return Center(

                   child: slider(),

              );
            }},
        ),
      ),
    );
  }

  Widget portFolioGridItem(int index) {
    return Material(
      child: InkWell(
        borderRadius: BorderRadius.circular(5.0),
        splashColor: Colors.green,
        onTap: () {
          final urlImages = listOfPortfolioItems[index].listOfImagePaths;
          final desc = listOfPortfolioItems[index].desc;
          if(urlImages!.isNotEmpty){
            Navigator.push(this.context, MaterialPageRoute(builder: (context) =>
                ViewDetailedPortfolioItem(urlImages, index, desc!)));
          } else {
            Fluttertoast.cancel();
            Fluttertoast.showToast(msg: "No images in this portfolio item", backgroundColor: Colors.red);
          }
        },
        child: Hero(
          tag: index,
          child: Card(
            elevation: 4,
            child: Stack(
                children: [
                  listOfPortfolioItems[index].listOfImagePaths!.isEmpty ?
                  Container(color: Colors.black12,) :
                  Image(image:
                  NetworkImage(Uri.parse(listOfPortfolioItems[index]
                      .listOfImagePaths!.first).toString()),
                  ),
                  Center(
                    child: Text("${listOfPortfolioItems[index].title}"),
                  ),
                  Container(color: Colors.black38,),

                ]
            ),
          ),
        ),
      ),
    );
  }

  bool isTapped = false;


  Widget addNewPortfolioItem() {
    return FloatingActionButton(onPressed:
        () {
      Navigator.push(this.context, MaterialPageRoute(
          builder: (context) => CreatePortfolioItem())
      );
    },
      heroTag: 100,
      child: Icon(Icons.add),);
  }



}
