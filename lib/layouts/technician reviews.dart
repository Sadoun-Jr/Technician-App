import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:technicians/utils/hex%20colors.dart';
import 'package:technicians/utils/strings%20enum.dart';

class TechnicianReviews extends StatefulWidget {
  const TechnicianReviews({Key? key}) : super(key: key);

  @override
  State<TechnicianReviews> createState() => _TechnicianReviewsState();
}

class _TechnicianReviewsState extends State<TechnicianReviews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: reviewsListView(),
    );
  }

  Widget reviewsListView() {
    return Container(
      margin: EdgeInsets.fromLTRB(5, 5, 5, 80),
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          SafeArea(
            child: Padding(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Reviews of widgets.name",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
            child: ListView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: AppStrings.techniciansList.length,
                itemBuilder: (context, index) {
                  return Container(
                      height: 150,
                      padding: const EdgeInsets.symmetric(
                          vertical: 1, horizontal: 4),
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          splashColor: Colors.redAccent,
                          onTap: () =>{},
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 200),
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                            child: Row(children: <Widget>[
                              Expanded(
                                child: Row(
                                  children: <Widget>[
                                    SizedBox(
                                      width: 16,
                                    ),
                                    Expanded(
                                      child: Container(
                                        margin:
                                        EdgeInsets.fromLTRB(0, 23, 16, 16),
                                        color: Colors.transparent,
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Row(
                                              children: [
                                                Text(
                                                  AppStrings.techniciansList[index].rating,
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: AppStrings
                                                          .techniciansList[index]
                                                          .availability ==
                                                          "Available"
                                                          ? FontWeight.bold
                                                          : FontWeight.normal),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.fromLTRB(5, 0, 16, 0),
                                                  child: Icon(
                                                    Icons.star,
                                                    size: 16,
                                                    color: HexColor("FFD700"),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 5,),
                                            Text(
                                              AppStrings
                                                  .techniciansList[index].name,
                                              style: TextStyle(fontSize: 16),
                                            ),
                                            SizedBox(
                                              height: 6,
                                            ),
                                            Text(
                                              AppStrings
                                                  .techniciansList[index].desc,
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.grey.shade600,
                                                  fontWeight: FontWeight.bold),
                                              maxLines: 1,
                                            ),

                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ]),
                          ),
                        ),
                      ));
                }),
          )
        ],
      ),
    );
  }

}
