import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:technicians/utils/hex%20colors.dart';

class MarkOrderFinished extends StatefulWidget {
  const MarkOrderFinished({Key? key}) : super(key: key);

  @override
  State<MarkOrderFinished> createState() => _MarkOrderFinishedState();
}

class _MarkOrderFinishedState extends State<MarkOrderFinished> {

  var ratingGlobal = 0.0;
  TextEditingController reviewController = TextEditingController();
  Color borderColor = Colors.black26;
  bool isPaidAsPromised = false;
  bool isArrivedOnTime = false;
  bool isWillingToRecommend = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: finishOrderForm(),
      ),
    );
  }

  Widget finishOrderForm() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: ListView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: borderColor),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Wrap(
              runSpacing: 10,
              children: [
                Align(
                    alignment: Alignment.center,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide( color: borderColor),
                        ),
                      ),
                      child: Text("Issue details", style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                      ),),
                    )
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: RichText(
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    text: TextSpan(
                      children: const [
                        TextSpan(
                          //todo: change to issuedTo
                            text: "Issue category: ",
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black38)
                        ),
                        TextSpan(
                            text: "Plumber",
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: RichText(
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    text: TextSpan(
                      children: const [
                        TextSpan(
                          //todo: change to issuedTo
                            text: "Issue descreption: ",
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black38)
                        ),
                        TextSpan(
                            text: "Plumber common issue #3",
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: RichText(
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    text: TextSpan(
                      children: const [
                        TextSpan(
                          //todo: change to issuedTo
                            text: "Issue ID: ",
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black38)
                        ),
                        TextSpan(
                            text: "G234JHPPD26YLS234",
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: RichText(
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    text: TextSpan(
                      children: const [
                        TextSpan(
                          //todo: change to issuedTo
                            text: "Issued to: ",
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black38)
                        ),
                        TextSpan(
                            text: "Kamil",
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.lightBlue)
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: RichText(
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    text: TextSpan(
                      children: const [
                        TextSpan(
                          //todo: change to issuedTo
                            text: "Payment: ",
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black38)
                        ),
                        TextSpan(
                            text: "In App",
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 15,),
          Center(
            child: Text(
              ratingGlobal.toString(),
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 5,),
          Center(
            child: RatingBar.builder(
              initialRating: 3,
              glowColor: Colors.yellowAccent,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                setState(() => ratingGlobal = rating);
              },
            )
          ),
          SizedBox(height: 15,),
          TextFormField(
            controller: reviewController,
            maxLines: 3,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: BorderSide(
                  color: borderColor,
                  width: 1.25,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              labelText: "Write your review...",
              labelStyle: TextStyle(color: borderColor,),
              alignLabelWithHint: true,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: borderColor, width: 2.5),
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 30, 0, 10),
            height: 1,
            decoration: BoxDecoration(
              border: Border.all(color: borderColor, )
          ),),
          CheckboxListTile(
            title: Text("You paid as promised?"),
            value: isPaidAsPromised,
            checkboxShape: CircleBorder(),
            onChanged: (value) {
              setState(() {
                isPaidAsPromised = value!;
              });
            },
          ),
          CheckboxListTile(
            title: Text("The technician arrived on time?"),
            value: isArrivedOnTime,
            checkboxShape: CircleBorder(),
            onChanged: (value) {
              setState(() {
                isArrivedOnTime = value!;
              });
            },
          ),
          CheckboxListTile(
            title: Text("Do you recommend this technician?"),
            value: isWillingToRecommend,
            checkboxShape: CircleBorder(),
            onChanged: (value) {
              setState(() {
                isWillingToRecommend = value!;
              });
            },
          ),
          CheckboxListTile(
            title: Text("Do you recommend this technician?"),
            value: isWillingToRecommend,
            checkboxShape: CircleBorder(),
            onChanged: (value) {
              setState(() {
                isWillingToRecommend = value!;
              });
            },
          ),


        ],
      ),
    );
  }
}
