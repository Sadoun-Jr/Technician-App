import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:technicians/widgets/simple%20glass%20box.dart';

class Stats extends StatefulWidget {
  const Stats({Key? key}) : super(key: key);

  @override
  State<Stats> createState() => _StatsState();
}

class _StatsState extends State<Stats> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: Stack(
          children: [
            Hero(
              tag: "bg",
              child: Image.asset(
                "assets/abstract bg.jpg",
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
                alignment: Alignment.center,
              ),
            ),
            Hero(
                tag: "1",
                child: Material(
                    color: Colors.transparent,
                    child: SimpleGlassBox(
                      height: 100,
                      width: 200,
                      child: Text(
                        "Statistics",
                        style: TextStyle(fontSize: 30),
                      ),
                    ))),
            Align(
              alignment: Alignment.center,
              child: Container(
                margin: EdgeInsets.fromLTRB(5, 16, 5, 16),
                child: ListView(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  children: [
                    SimpleGlassBox(
                        height: 150,
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.all(16),
                              width: 150,
                              child: Column(
                                children: const [
                                  Icon(Icons.favorite),
                                  SizedBox(height: 5,),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text("45", style: TextStyle(fontSize: 40),),
                                  ),
                                  SizedBox(height: 5,),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text("Favourites", style: TextStyle(fontSize: 20),),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              width: 1,
                              height: double.infinity,
                              color: Colors.white,
                            ),
                            Container(
                              padding: EdgeInsets.all(16),
                              width: 150,
                              child: Column(
                                children: const [
                                  Icon(Icons.star),
                                  SizedBox(height: 5,),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text("21", style: TextStyle(fontSize: 40),),
                                  ),
                                  SizedBox(height: 5,),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text("Reviews", style: TextStyle(fontSize: 20),),
                                  )
                                ],
                              ),
                            ),
                          ],
                        )),
                    SimpleGlassBox(
                        height: 150,
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.all(16),
                              width: 150,
                              child: Column(
                                children: const [
                                  Icon(Icons.shopping_bag),
                                  SizedBox(height: 5,),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text("143", style: TextStyle(fontSize: 40),),
                                  ),
                                  SizedBox(height: 5,),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text("Jobs", style: TextStyle(fontSize: 20),),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              width: 1,
                              height: double.infinity,
                              color: Colors.white,
                            ),
                            Container(
                              padding: EdgeInsets.all(16),
                              width: 150,
                              child: Column(
                                children: const [
                                  Icon(Icons.paid),
                                  SizedBox(height: 5,),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text("2143", style: TextStyle(fontSize: 40),),
                                  ),
                                  SizedBox(height: 5,),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text("Paid", style: TextStyle(fontSize: 20),),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
