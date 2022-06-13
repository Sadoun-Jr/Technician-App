import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:technicians/utils/hex%20colors.dart';
import 'package:technicians/utils/strings%20enum.dart';

class PendingAndCompletedOrders extends StatefulWidget {
  const PendingAndCompletedOrders({Key? key}) : super(key: key);

  @override
  State<PendingAndCompletedOrders> createState() =>
      _PendingAndCompletedOrdersState();
}

class _PendingAndCompletedOrdersState extends State<PendingAndCompletedOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: ordersList());
  }

  Widget ordersList() {
    return Container(
      margin: EdgeInsets.fromLTRB(5, 5, 5, 80),
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          SafeArea(
            child: Padding(
              padding: EdgeInsets.only(left: 24, right: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    AppStrings.listOfOrdersString,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 16, left: 16, right: 16),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search...",
                hintStyle: TextStyle(color: Colors.grey.shade600),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey.shade600,
                  size: 20,
                ),
                filled: true,
                fillColor: Colors.grey.shade100,
                contentPadding: EdgeInsets.all(8),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.grey.shade100)),
              ),
            ),
          ),
          orders(),
        ],
      ),
    );
  }

  Widget orders() {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
      child: ListView.builder(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          itemCount: AppStrings.listOfIssues.length,
          itemBuilder: (context, index) {
            return Container(
                height: AppStrings.listOfIssues[index].isCompleted ? 250 : 200,
                padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 4),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: AppStrings.listOfIssues[index].isCompleted ?
                        Colors.green[100] :Colors.yellow[100],
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Column(
                              children: [
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.circular(10.0), //or 15.0
                                    child: Container(
                                      height: 60.0,
                                      width: 60.0,
                                      color: Color(0xffFF0E58),
                                      child: Icon(Icons.gps_not_fixed_rounded,
                                          color: Colors.white, size: 50.0),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      AppStrings
                                          .listOfIssues[index].paymentMethod,
                                      style: TextStyle(
                                          color: AppStrings.listOfIssues[index]
                                                      .paymentMethod ==
                                                  "In App"
                                              ? Colors.green
                                              : Colors.red),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.71,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        padding:
                                            EdgeInsets.fromLTRB(16, 0, 16, 0),
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            AppStrings
                                                .listOfIssues[index].issueTitle,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      Container(
                                        padding:
                                            EdgeInsets.fromLTRB(16, 0, 16, 0),
                                        child: Align(
                                          alignment: Alignment.topRight,
                                          child: Text(
                                            "\$${AppStrings.listOfIssues[index].price}",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(fontSize: 25),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(16, 5, 16, 0),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        AppStrings
                                            .listOfIssues[index].issueDesc,
                                        maxLines: 1,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        margin:
                                            EdgeInsets.fromLTRB(16, 5, 5, 5),
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Text.rich(
                                            TextSpan(
                                              children: [
                                                TextSpan(
                                                    text: AppStrings
                                                            .listOfIssues[index]
                                                            .isCompleted
                                                        ? 'Completed by: '
                                                        : "Pending...  ",
                                                    style: TextStyle(
                                                        color: AppStrings
                                                                .listOfIssues[
                                                                    index]
                                                                .isCompleted
                                                            ? Colors.green
                                                            : HexColor(
                                                                "FFD700"))),
                                                TextSpan(
                                                  recognizer:
                                                      TapGestureRecognizer()
                                                        ..onTap = () => {},
                                                  text: AppStrings
                                                      .listOfIssues[index]
                                                      .completedBy,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.blue),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        AppStrings.listOfIssues[index]
                                            .technicianRating,
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
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
                                  Container(
                                    padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        AppStrings
                                                .listOfIssues[index].isCompleted
                                            ? AppStrings.listOfIssues[index]
                                                .timeCompleted
                                            : AppStrings.listOfIssues[index]
                                                .timeRequested,
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible: AppStrings
                                        .listOfIssues[index].isCompleted,
                                    child: Container(
                                      padding:
                                          EdgeInsets.fromLTRB(16, 5, 16, 0),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          AppStrings.listOfIssues[index]
                                              .technicianReview,
                                          maxLines: 4,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(fontSize: 19),
                                        ),
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            )
                          ],
                        ),
                        Spacer(),
                        Visibility(
                          visible: !AppStrings.listOfIssues[index].isCompleted,
                          child: Container(
                            padding: EdgeInsets.fromLTRB(16, 5, 16, 0),
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: FloatingActionButton.extended(
                                label: Text(
                                  "Mark As Complete",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white),
                                ),
                                onPressed: () => {},
                                backgroundColor: Colors.green,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ));
          }),
    );
  }
}
