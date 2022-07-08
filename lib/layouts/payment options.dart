import 'package:flutter/material.dart';
import 'package:technicians/widgets/navigation%20drawer.dart';

import '../utils/hex colors.dart';

class PaymentOptions extends StatefulWidget {
  const PaymentOptions({Key? key}) : super(key: key);

  @override
  State<PaymentOptions> createState() => _PaymentOptionsState();
}

class _PaymentOptionsState extends State<PaymentOptions> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
          key: _scaffoldKey,
          extendBodyBehindAppBar: true,
          drawer: NavDrawer(),
          appBar: AppBar(
            leading: Container(

              margin: EdgeInsets.symmetric(horizontal: 15),
              child: IconButton(
                icon: Icon(Icons.list),
                onPressed: () => _scaffoldKey.currentState?.openDrawer(),
              ),
            ),
            leadingWidth: 50,
            toolbarHeight: MediaQuery.of(context).size.height / 10,
            backgroundColor: HexColor("#96878D"),
            title: Text('Payment options'),
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
              Center(child: Text('hi'),),
            ],
          )),
    );
  }
}
