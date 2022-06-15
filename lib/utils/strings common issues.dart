import 'package:flutter/material.dart';

class CommonIssues{

  //static strings for technician categories
  static String technicianCategory0 = "Plumber";
  static String technicianCategory1 = "Electrician";
  static String technicianCategory2 = "Carpenter";
  static String technicianCategory3 = "Painter";
  static String technicianCategory4 = "Builder";
  static String technicianCategory5 = "Cleaner";
  static String technicianCategory6 = "Butcher";
  static String technicianCategory7 = "Mechanic";
  static String technicianCategory8 = "...";
  static String technicianCategory9 = "...";

  //static strings for appliance categories
  static String applianceCategory0 = "AC";
  static String applianceCategory1 = "Refrigirator";
  static String applianceCategory2 = "Computer";
  static String applianceCategory3 = "Dry cleaner";
  static String applianceCategory4 = "Drier";
  static String applianceCategory5 = "Mobile phone";
  static String applianceCategory6 = "Drier";
  static String applianceCategory7 = "Other";
  static String applianceCategory8 = "///";
  static String applianceCategory9 = "///";

  //strings for the category page
  //IMPORTANT: NEVER CHANGE THE ARRANGEMENT OF THE CATEGORIES LISTS, JUST ADD IF NEEDED
  static List<String> listOfTechnicianCategories = [
    technicianCategory0,
    technicianCategory1,
    technicianCategory2,
    technicianCategory3,
    technicianCategory4,
    technicianCategory5,
    technicianCategory6,
    technicianCategory7,
    technicianCategory8,
    technicianCategory9,
  ];

  static List<String> listOfAppliancesCategories = [
    applianceCategory0,
    applianceCategory1,
    applianceCategory2,
    applianceCategory3,
    applianceCategory4,
    applianceCategory5,
    applianceCategory6,
    applianceCategory7,
    applianceCategory8,
    applianceCategory9,
  ];

  static List<String> plumberIssues = [
    "plumber issue 1",
    "plumber issue 2",
    "plumber issue 3",
    "plumber issue 4",
    "plumber issue 5",
    "plumber issue 6",
    "plumber issue 7",
    "plumber issue 8",
    "plumber issue 9",
    "plumber issue 10",
    "plumber issue 11",
    "plumber issue 12",
    "plumber issue 13",
    "plumber issue 14",
    "plumber issue 15",
  ];

  static List<String> carpenterIssues = [
    "carpenter issue 1",
    "carpenter issue 2",
    "carpenter issue 3",
    "carpenter issue 4",
    "carpenter issue 5",
    "carpenter issue 6",
    "carpenter issue 7",
    "carpenter issue 8",
    "carpenter issue 9",
    "carpenter issue 10",
    "carpenter issue 11",
    "carpenter issue 12",
    "carpenter issue 13",
    "carpenter issue 14",
    "carpenter issue 15",
  ];

  static Map<String, List> listOfAllApplianceIssues = {
    listOfAppliancesCategories[0]: [
      "AC issue 1",
      "AC issue 2",
      "AC issue 3",
      "AC issue 4",
      "AC issue 5",
      "AC issue 6",
      "AC issue 7",
      "AC issue 8",
      "AC issue 9",
      "AC issue 10",
      "AC issue 11",
      "AC issue 12",
      "AC issue 13",
      "AC issue 14",
      "AC issue 15",
    ],
    listOfTechnicianCategories[2]: [
      "Computer issue 1",
      "Computer issue 2",
      "Computer issue 3",
      "Computer issue 4",
      "Computer issue 5",
      "Computer issue 6",
      "Computer issue 7",
      "Computer issue 8",
      "Computer issue 9",
      "Computer issue 10",
      "Computer issue 11",
      "Computer issue 12",
      "Computer issue 13",
      "Computer issue 14",
      "Computer issue 15",
    ]
  };

  //common technicianCategory [x] issues
  static String technicianCategory0CommonIssue0 = technicianCategory0 + " issue #0";
  static String technicianCategory0CommonIssue1 = technicianCategory0 + " issue #1";
  static String technicianCategory0CommonIssue2 = technicianCategory0 + " issue #2";
  static String technicianCategory0CommonIssue3 = technicianCategory0 + " issue #3";
  static String technicianCategory0CommonIssue4 = technicianCategory0 + " issue #4";
  static String technicianCategory0CommonIssue5 = technicianCategory0 + " issue #5";
  static String technicianCategory0CommonIssue6 = technicianCategory0 + " issue #6";
  static String technicianCategory0CommonIssue7 = technicianCategory0 + " issue #7";
  static String technicianCategory0CommonIssue8 = technicianCategory0 + " issue #8";
  static String technicianCategory0CommonIssue9 = technicianCategory0 + " issue #9";

  static String technicianCategory1CommonIssue0 = technicianCategory1 + " issue #0";
  static String technicianCategory1CommonIssue1 = technicianCategory1 + " issue #1";
  static String technicianCategory1CommonIssue2 = technicianCategory1 + " issue #2";
  static String technicianCategory1CommonIssue3 = technicianCategory1 + " issue #3";
  static String technicianCategory1CommonIssue4 = technicianCategory1 + " issue #4";
  static String technicianCategory1CommonIssue5 = technicianCategory1 + " issue #5";
  static String technicianCategory1CommonIssue6 = technicianCategory1 + " issue #6";
  static String technicianCategory1CommonIssue7 = technicianCategory1 + " issue #7";
  static String technicianCategory1CommonIssue8 = technicianCategory1 + " issue #8";
  static String technicianCategory1CommonIssue9 = technicianCategory1 + " issue #9";

  static String technicianCategory2CommonIssue0 = technicianCategory2 + " issue #0";
  static String technicianCategory2CommonIssue1 = technicianCategory2 + " issue #1";
  static String technicianCategory2CommonIssue2 = technicianCategory2 + " issue #2";
  static String technicianCategory2CommonIssue3 = technicianCategory2 + " issue #3";
  static String technicianCategory2CommonIssue4 = technicianCategory2 + " issue #4";
  static String technicianCategory2CommonIssue5 = technicianCategory2 + " issue #5";
  static String technicianCategory2CommonIssue6 = technicianCategory2 + " issue #6";
  static String technicianCategory2CommonIssue7 = technicianCategory2 + " issue #7";
  static String technicianCategory2CommonIssue8 = technicianCategory2 + " issue #8";
  static String technicianCategory2CommonIssue9 = technicianCategory2 + " issue #9";

  static String technicianCategory3CommonIssue0 = technicianCategory3 + " issue #0";
  static String technicianCategory3CommonIssue1 = technicianCategory3 + " issue #1";
  static String technicianCategory3CommonIssue2 = technicianCategory3 + " issue #2";
  static String technicianCategory3CommonIssue3 = technicianCategory3 + " issue #3";
  static String technicianCategory3CommonIssue4 = technicianCategory3 + " issue #4";
  static String technicianCategory3CommonIssue5 = technicianCategory3 + " issue #5";
  static String technicianCategory3CommonIssue6 = technicianCategory3 + " issue #6";
  static String technicianCategory3CommonIssue7 = technicianCategory3 + " issue #7";
  static String technicianCategory3CommonIssue8 = technicianCategory3 + " issue #8";
  static String technicianCategory3CommonIssue9 = technicianCategory3 + " issue #9";

  static String technicianCategory4CommonIssue0 = technicianCategory4 + " issue #0";
  static String technicianCategory4CommonIssue1 = technicianCategory4 + " issue #1";
  static String technicianCategory4CommonIssue2 = technicianCategory4 + " issue #2";
  static String technicianCategory4CommonIssue3 = technicianCategory4 + " issue #3";
  static String technicianCategory4CommonIssue4 = technicianCategory4 + " issue #4";
  static String technicianCategory4CommonIssue5 = technicianCategory4 + " issue #5";
  static String technicianCategory4CommonIssue6 = technicianCategory4 + " issue #6";
  static String technicianCategory4CommonIssue7 = technicianCategory4 + " issue #7";
  static String technicianCategory4CommonIssue8 = technicianCategory4 + " issue #8";
  static String technicianCategory4CommonIssue9 = technicianCategory4 + " issue #9";

  static String technicianCategory5CommonIssue0 = technicianCategory5 + " issue #0";
  static String technicianCategory5CommonIssue1 = technicianCategory5 + " issue #1";
  static String technicianCategory5CommonIssue2 = technicianCategory5 + " issue #2";
  static String technicianCategory5CommonIssue3 = technicianCategory5 + " issue #3";
  static String technicianCategory5CommonIssue4 = technicianCategory5 + " issue #4";
  static String technicianCategory5CommonIssue5 = technicianCategory5 + " issue #5";
  static String technicianCategory5CommonIssue6 = technicianCategory5 + " issue #6";
  static String technicianCategory5CommonIssue7 = technicianCategory5 + " issue #7";
  static String technicianCategory5CommonIssue8 = technicianCategory5 + " issue #8";
  static String technicianCategory5CommonIssue9 = technicianCategory5 + " issue #9";

  static String technicianCategory6CommonIssue0 = technicianCategory6 + " issue #0";
  static String technicianCategory6CommonIssue1 = technicianCategory6 + " issue #1";
  static String technicianCategory6CommonIssue2 = technicianCategory6 + " issue #2";
  static String technicianCategory6CommonIssue3 = technicianCategory6 + " issue #3";
  static String technicianCategory6CommonIssue4 = technicianCategory6 + " issue #4";
  static String technicianCategory6CommonIssue5 = technicianCategory6 + " issue #5";
  static String technicianCategory6CommonIssue6 = technicianCategory6 + " issue #6";
  static String technicianCategory6CommonIssue7 = technicianCategory6 + " issue #7";
  static String technicianCategory6CommonIssue8 = technicianCategory6 + " issue #8";
  static String technicianCategory6CommonIssue9 = technicianCategory6 + " issue #9";

  static String technicianCategory7CommonIssue0 = technicianCategory7 + " issue #0";
  static String technicianCategory7CommonIssue1 = technicianCategory7 + " issue #1";
  static String technicianCategory7CommonIssue2 = technicianCategory7 + " issue #2";
  static String technicianCategory7CommonIssue3 = technicianCategory7 + " issue #3";
  static String technicianCategory7CommonIssue4 = technicianCategory7 + " issue #4";
  static String technicianCategory7CommonIssue5 = technicianCategory7 + " issue #5";
  static String technicianCategory7CommonIssue6 = technicianCategory7 + " issue #6";
  static String technicianCategory7CommonIssue7 = technicianCategory7 + " issue #7";
  static String technicianCategory7CommonIssue8 = technicianCategory7 + " issue #8";
  static String technicianCategory7CommonIssue9 = technicianCategory7 + " issue #9";

  static String technicianCategory8CommonIssue0 = technicianCategory8 + " issue #0";
  static String technicianCategory8CommonIssue1 = technicianCategory8 + " issue #1";
  static String technicianCategory8CommonIssue2 = technicianCategory8 + " issue #2";
  static String technicianCategory8CommonIssue3 = technicianCategory8 + " issue #3";
  static String technicianCategory8CommonIssue4 = technicianCategory8 + " issue #4";
  static String technicianCategory8CommonIssue5 = technicianCategory8 + " issue #5";
  static String technicianCategory8CommonIssue6 = technicianCategory8 + " issue #6";
  static String technicianCategory8CommonIssue7 = technicianCategory8 + " issue #7";
  static String technicianCategory8CommonIssue8 = technicianCategory8 + " issue #8";
  static String technicianCategory8CommonIssue9 = technicianCategory8 + " issue #9";

  static String technicianCategory9CommonIssue0 = technicianCategory9 + " issue #0";
  static String technicianCategory9CommonIssue1 = technicianCategory9 + " issue #1";
  static String technicianCategory9CommonIssue2 = technicianCategory9 + " issue #2";
  static String technicianCategory9CommonIssue3 = technicianCategory9 + " issue #3";
  static String technicianCategory9CommonIssue4 = technicianCategory9 + " issue #4";
  static String technicianCategory9CommonIssue5 = technicianCategory9 + " issue #5";
  static String technicianCategory9CommonIssue6 = technicianCategory9 + " issue #6";
  static String technicianCategory9CommonIssue7 = technicianCategory9 + " issue #7";
  static String technicianCategory9CommonIssue8 = technicianCategory9 + " issue #8";
  static String technicianCategory9CommonIssue9 = technicianCategory9 + " issue #9";


  //common applianceCategory [x] issues
  static String applianceCategory0CommonIssue0 = applianceCategory0 + " issue #0";
  static String applianceCategory0CommonIssue1 = applianceCategory0 + " issue #1";
  static String applianceCategory0CommonIssue2 = applianceCategory0 + " issue #2";
  static String applianceCategory0CommonIssue3 = applianceCategory0 + " issue #3";
  static String applianceCategory0CommonIssue4 = applianceCategory0 + " issue #4";
  static String applianceCategory0CommonIssue5 = applianceCategory0 + " issue #5";
  static String applianceCategory0CommonIssue6 = applianceCategory0 + " issue #6";
  static String applianceCategory0CommonIssue7 = applianceCategory0 + " issue #7";
  static String applianceCategory0CommonIssue8 = applianceCategory0 + " issue #8";
  static String applianceCategory0CommonIssue9 = applianceCategory0 + " issue #9";

  static String applianceCategory1CommonIssue0 = applianceCategory1 + " issue #0";
  static String applianceCategory1CommonIssue1 = applianceCategory1 + " issue #1";
  static String applianceCategory1CommonIssue2 = applianceCategory1 + " issue #2";
  static String applianceCategory1CommonIssue3 = applianceCategory1 + " issue #3";
  static String applianceCategory1CommonIssue4 = applianceCategory1 + " issue #4";
  static String applianceCategory1CommonIssue5 = applianceCategory1 + " issue #5";
  static String applianceCategory1CommonIssue6 = applianceCategory1 + " issue #6";
  static String applianceCategory1CommonIssue7 = applianceCategory1 + " issue #7";
  static String applianceCategory1CommonIssue8 = applianceCategory1 + " issue #8";
  static String applianceCategory1CommonIssue9 = applianceCategory1 + " issue #9";

  static String applianceCategory2CommonIssue0 = applianceCategory2 + " issue #0";
  static String applianceCategory2CommonIssue1 = applianceCategory2 + " issue #1";
  static String applianceCategory2CommonIssue2 = applianceCategory2 + " issue #2";
  static String applianceCategory2CommonIssue3 = applianceCategory2 + " issue #3";
  static String applianceCategory2CommonIssue4 = applianceCategory2 + " issue #4";
  static String applianceCategory2CommonIssue5 = applianceCategory2 + " issue #5";
  static String applianceCategory2CommonIssue6 = applianceCategory2 + " issue #6";
  static String applianceCategory2CommonIssue7 = applianceCategory2 + " issue #7";
  static String applianceCategory2CommonIssue8 = applianceCategory2 + " issue #8";
  static String applianceCategory2CommonIssue9 = applianceCategory2 + " issue #9";

  static String applianceCategory3CommonIssue0 = applianceCategory3 + " issue #0";
  static String applianceCategory3CommonIssue1 = applianceCategory3 + " issue #1";
  static String applianceCategory3CommonIssue2 = applianceCategory3 + " issue #2";
  static String applianceCategory3CommonIssue3 = applianceCategory3 + " issue #3";
  static String applianceCategory3CommonIssue4 = applianceCategory3 + " issue #4";
  static String applianceCategory3CommonIssue5 = applianceCategory3 + " issue #5";
  static String applianceCategory3CommonIssue6 = applianceCategory3 + " issue #6";
  static String applianceCategory3CommonIssue7 = applianceCategory3 + " issue #7";
  static String applianceCategory3CommonIssue8 = applianceCategory3 + " issue #8";
  static String applianceCategory3CommonIssue9 = applianceCategory3 + " issue #9";

  static String applianceCategory4CommonIssue0 = applianceCategory4 + " issue #0";
  static String applianceCategory4CommonIssue1 = applianceCategory4 + " issue #1";
  static String applianceCategory4CommonIssue2 = applianceCategory4 + " issue #2";
  static String applianceCategory4CommonIssue3 = applianceCategory4 + " issue #3";
  static String applianceCategory4CommonIssue4 = applianceCategory4 + " issue #4";
  static String applianceCategory4CommonIssue5 = applianceCategory4 + " issue #5";
  static String applianceCategory4CommonIssue6 = applianceCategory4 + " issue #6";
  static String applianceCategory4CommonIssue7 = applianceCategory4 + " issue #7";
  static String applianceCategory4CommonIssue8 = applianceCategory4 + " issue #8";
  static String applianceCategory4CommonIssue9 = applianceCategory4 + " issue #9";

  static String applianceCategory5CommonIssue0 = applianceCategory5 + " issue #0";
  static String applianceCategory5CommonIssue1 = applianceCategory5 + " issue #1";
  static String applianceCategory5CommonIssue2 = applianceCategory5 + " issue #2";
  static String applianceCategory5CommonIssue3 = applianceCategory5 + " issue #3";
  static String applianceCategory5CommonIssue4 = applianceCategory5 + " issue #4";
  static String applianceCategory5CommonIssue5 = applianceCategory5 + " issue #5";
  static String applianceCategory5CommonIssue6 = applianceCategory5 + " issue #6";
  static String applianceCategory5CommonIssue7 = applianceCategory5 + " issue #7";
  static String applianceCategory5CommonIssue8 = applianceCategory5 + " issue #8";
  static String applianceCategory5CommonIssue9 = applianceCategory5 + " issue #9";

  static String applianceCategory6CommonIssue0 = applianceCategory6 + " issue #0";
  static String applianceCategory6CommonIssue1 = applianceCategory6 + " issue #1";
  static String applianceCategory6CommonIssue2 = applianceCategory6 + " issue #2";
  static String applianceCategory6CommonIssue3 = applianceCategory6 + " issue #3";
  static String applianceCategory6CommonIssue4 = applianceCategory6 + " issue #4";
  static String applianceCategory6CommonIssue5 = applianceCategory6 + " issue #5";
  static String applianceCategory6CommonIssue6 = applianceCategory6 + " issue #6";
  static String applianceCategory6CommonIssue7 = applianceCategory6 + " issue #7";
  static String applianceCategory6CommonIssue8 = applianceCategory6 + " issue #8";
  static String applianceCategory6CommonIssue9 = applianceCategory6 + " issue #9";

  static String applianceCategory7CommonIssue0 = applianceCategory7 + " issue #0";
  static String applianceCategory7CommonIssue1 = applianceCategory7 + " issue #1";
  static String applianceCategory7CommonIssue2 = applianceCategory7 + " issue #2";
  static String applianceCategory7CommonIssue3 = applianceCategory7 + " issue #3";
  static String applianceCategory7CommonIssue4 = applianceCategory7 + " issue #4";
  static String applianceCategory7CommonIssue5 = applianceCategory7 + " issue #5";
  static String applianceCategory7CommonIssue6 = applianceCategory7 + " issue #6";
  static String applianceCategory7CommonIssue7 = applianceCategory7 + " issue #7";
  static String applianceCategory7CommonIssue8 = applianceCategory7 + " issue #8";
  static String applianceCategory7CommonIssue9 = applianceCategory7 + " issue #9";

  static String applianceCategory8CommonIssue0 = applianceCategory8 + " issue #0";
  static String applianceCategory8CommonIssue1 = applianceCategory8 + " issue #1";
  static String applianceCategory8CommonIssue2 = applianceCategory8 + " issue #2";
  static String applianceCategory8CommonIssue3 = applianceCategory8 + " issue #3";
  static String applianceCategory8CommonIssue4 = applianceCategory8 + " issue #4";
  static String applianceCategory8CommonIssue5 = applianceCategory8 + " issue #5";
  static String applianceCategory8CommonIssue6 = applianceCategory8 + " issue #6";
  static String applianceCategory8CommonIssue7 = applianceCategory8 + " issue #7";
  static String applianceCategory8CommonIssue8 = applianceCategory8 + " issue #8";
  static String applianceCategory8CommonIssue9 = applianceCategory8 + " issue #9";

  static String applianceCategory9CommonIssue0 = applianceCategory9 + " issue #0";
  static String applianceCategory9CommonIssue1 = applianceCategory9 + " issue #1";
  static String applianceCategory9CommonIssue2 = applianceCategory9 + " issue #2";
  static String applianceCategory9CommonIssue3 = applianceCategory9 + " issue #3";
  static String applianceCategory9CommonIssue4 = applianceCategory9 + " issue #4";
  static String applianceCategory9CommonIssue5 = applianceCategory9 + " issue #5";
  static String applianceCategory9CommonIssue6 = applianceCategory9 + " issue #6";
  static String applianceCategory9CommonIssue7 = applianceCategory9 + " issue #7";
  static String applianceCategory9CommonIssue8 = applianceCategory9 + " issue #8";
  static String applianceCategory9CommonIssue9 = applianceCategory9 + " issue #9";

}