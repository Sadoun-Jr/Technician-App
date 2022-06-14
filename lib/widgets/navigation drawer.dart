import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:technicians/layouts/dashboard.dart';

class NavDrawer extends StatefulWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30.0),
          bottomRight: Radius.circular(30.0),
        ),
        child: Container(
          width: 250,
          height: double.infinity,
          decoration: BoxDecoration(
            color: Color.fromARGB(180, 250, 250, 250),
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(31, 38, 135, 0.4),
                blurRadius: 8.0,
              )
            ],
          ),
          child: Stack(
            children: [
              SizedBox(
                child: ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 4.0,
                      sigmaY: 4.0,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          Colors.grey.withOpacity(0.0),
                          Colors.white.withOpacity(0.2),
                        ]),
                      ),
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  DrawerHeader(
                    child: Row(
                      children: const [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                              "https://randomuser.me/api/portraits/men/46.jpg"),
                          radius: 30.0,
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        Text("User Name")
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      children: [
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () => {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UserDashboard()),
                              ),
                            },
                            child: ListTile(
                              leading: Icon(
                                Icons.dashboard,
                                color: Colors.black,
                              ),
                              title: Text("My Dashboard"),
                            ),
                          ),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {},
                            child: ListTile(
                              leading: Icon(
                                Icons.favorite,
                                color: Colors.black,
                              ),
                              title: Text("My Favourites"),
                            ),
                          ),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {},
                            child: ListTile(
                              leading: Icon(
                                Icons.reviews,
                                color: Colors.black,
                              ),
                              title: Text("My Reviews"),
                            ),
                          ),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {},
                            child: ListTile(
                              leading: Icon(
                                Icons.settings,
                                color: Colors.black,
                              ),
                              title: Text("Settings"),
                            ),
                          ),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {},
                            child: ListTile(
                              leading: Icon(
                                Icons.logout,
                                color: Colors.black,
                              ),
                              title: Text("Log Out"),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
