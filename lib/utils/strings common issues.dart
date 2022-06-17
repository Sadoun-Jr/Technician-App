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
  static String technicianCategory8 = ".!!.";
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
  static String applianceCategory8 = "---";
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

  //map linking technician issues with their respective common issues
  static Map<String, List<String>> mapAllCommonIssues = {
    technicianCategory0 : listTechnicianCategory0CommonIssues,
    technicianCategory1 : listTechnicianCategory1CommonIssues,
    technicianCategory2 : listTechnicianCategory2CommonIssues,
    technicianCategory3 : listTechnicianCategory3CommonIssues,
    technicianCategory4 : listTechnicianCategory4CommonIssues,
    technicianCategory5 : listTechnicianCategory5CommonIssues,
    technicianCategory6 : listTechnicianCategory6CommonIssues,
    technicianCategory7 : listTechnicianCategory7CommonIssues,
    technicianCategory8 : listTechnicianCategory8CommonIssues,
    technicianCategory9 : listTechnicianCategory9CommonIssues,
    applianceCategory0 : listApplianceCategory0CommonIssues,
    applianceCategory1 : listApplianceCategory1CommonIssues,
    applianceCategory2 : listApplianceCategory2CommonIssues,
    applianceCategory3 : listApplianceCategory3CommonIssues,
    applianceCategory4 : listApplianceCategory4CommonIssues,
    applianceCategory5 : listApplianceCategory5CommonIssues,
    applianceCategory6 : listApplianceCategory6CommonIssues,
    applianceCategory7 : listApplianceCategory7CommonIssues,
    applianceCategory8 : listApplianceCategory8CommonIssues,
    applianceCategory9 : listApplianceCategory9CommonIssues,
  };

  //lists for common applianceCategoryIssues
  static List<String> listApplianceCategory0CommonIssues = [
    applianceCategory0CommonIssue0,
    applianceCategory0CommonIssue1,
    applianceCategory0CommonIssue2,
    applianceCategory0CommonIssue3,
    applianceCategory0CommonIssue4,
    applianceCategory0CommonIssue5,
    applianceCategory0CommonIssue6,
    applianceCategory0CommonIssue7,
    applianceCategory0CommonIssue8,
    applianceCategory0CommonIssue9,
  ];

  static List<String> listApplianceCategory1CommonIssues = [
    applianceCategory1CommonIssue0,
    applianceCategory1CommonIssue1,
    applianceCategory1CommonIssue2,
    applianceCategory1CommonIssue3,
    applianceCategory1CommonIssue4,
    applianceCategory1CommonIssue5,
    applianceCategory1CommonIssue6,
    applianceCategory1CommonIssue7,
    applianceCategory1CommonIssue8,
    applianceCategory1CommonIssue9,
  ];

  static List<String> listApplianceCategory2CommonIssues = [
    applianceCategory2CommonIssue0,
    applianceCategory2CommonIssue1,
    applianceCategory2CommonIssue2,
    applianceCategory2CommonIssue3,
    applianceCategory2CommonIssue4,
    applianceCategory2CommonIssue5,
    applianceCategory2CommonIssue6,
    applianceCategory2CommonIssue7,
    applianceCategory2CommonIssue8,
    applianceCategory2CommonIssue9,
  ];

  static List<String> listApplianceCategory3CommonIssues = [
    applianceCategory3CommonIssue0,
    applianceCategory3CommonIssue1,
    applianceCategory3CommonIssue2,
    applianceCategory3CommonIssue3,
    applianceCategory3CommonIssue4,
    applianceCategory3CommonIssue5,
    applianceCategory3CommonIssue6,
    applianceCategory3CommonIssue7,
    applianceCategory3CommonIssue8,
    applianceCategory3CommonIssue9,
  ];

  static List<String> listApplianceCategory4CommonIssues = [
    applianceCategory4CommonIssue0,
    applianceCategory4CommonIssue1,
    applianceCategory4CommonIssue2,
    applianceCategory4CommonIssue3,
    applianceCategory4CommonIssue4,
    applianceCategory4CommonIssue5,
    applianceCategory4CommonIssue6,
    applianceCategory4CommonIssue7,
    applianceCategory4CommonIssue8,
    applianceCategory4CommonIssue9,
  ];

  static List<String> listApplianceCategory5CommonIssues = [
    applianceCategory5CommonIssue0,
    applianceCategory5CommonIssue1,
    applianceCategory5CommonIssue2,
    applianceCategory5CommonIssue3,
    applianceCategory5CommonIssue4,
    applianceCategory5CommonIssue5,
    applianceCategory5CommonIssue6,
    applianceCategory5CommonIssue7,
    applianceCategory5CommonIssue8,
    applianceCategory5CommonIssue9,
  ];

  static List<String> listApplianceCategory6CommonIssues = [
    applianceCategory6CommonIssue0,
    applianceCategory6CommonIssue1,
    applianceCategory6CommonIssue2,
    applianceCategory6CommonIssue3,
    applianceCategory6CommonIssue4,
    applianceCategory6CommonIssue5,
    applianceCategory6CommonIssue6,
    applianceCategory6CommonIssue7,
    applianceCategory6CommonIssue8,
    applianceCategory6CommonIssue9,
  ];

  static List<String> listApplianceCategory7CommonIssues = [
    applianceCategory7CommonIssue0,
    applianceCategory7CommonIssue1,
    applianceCategory7CommonIssue2,
    applianceCategory7CommonIssue3,
    applianceCategory7CommonIssue4,
    applianceCategory7CommonIssue5,
    applianceCategory7CommonIssue6,
    applianceCategory7CommonIssue7,
    applianceCategory7CommonIssue8,
    applianceCategory7CommonIssue9,
  ];

  static List<String> listApplianceCategory8CommonIssues = [
    applianceCategory8CommonIssue0,
    applianceCategory8CommonIssue1,
    applianceCategory8CommonIssue2,
    applianceCategory8CommonIssue3,
    applianceCategory8CommonIssue4,
    applianceCategory8CommonIssue5,
    applianceCategory8CommonIssue6,
    applianceCategory8CommonIssue7,
    applianceCategory8CommonIssue8,
    applianceCategory8CommonIssue9,
  ];

  static List<String> listApplianceCategory9CommonIssues = [
    applianceCategory9CommonIssue0,
    applianceCategory9CommonIssue1,
    applianceCategory9CommonIssue2,
    applianceCategory9CommonIssue3,
    applianceCategory9CommonIssue4,
    applianceCategory9CommonIssue5,
    applianceCategory9CommonIssue6,
    applianceCategory9CommonIssue7,
    applianceCategory9CommonIssue8,
    applianceCategory9CommonIssue9,
  ];


  //lists for common technicianCategoryIssues
  static List<String> listTechnicianCategory0CommonIssues = [
    technicianCategory0CommonIssue0,
    technicianCategory0CommonIssue1,
    technicianCategory0CommonIssue2,
    technicianCategory0CommonIssue3,
    technicianCategory0CommonIssue4,
    technicianCategory0CommonIssue5,
    technicianCategory0CommonIssue6,
    technicianCategory0CommonIssue7,
    technicianCategory0CommonIssue8,
    technicianCategory0CommonIssue9,
  ];

  static List<String> listTechnicianCategory1CommonIssues = [
    technicianCategory1CommonIssue0,
    technicianCategory1CommonIssue1,
    technicianCategory1CommonIssue2,
    technicianCategory1CommonIssue3,
    technicianCategory1CommonIssue4,
    technicianCategory1CommonIssue5,
    technicianCategory1CommonIssue6,
    technicianCategory1CommonIssue7,
    technicianCategory1CommonIssue8,
    technicianCategory1CommonIssue9,
  ];

  static List<String> listTechnicianCategory2CommonIssues = [
    technicianCategory2CommonIssue0,
    technicianCategory2CommonIssue1,
    technicianCategory2CommonIssue2,
    technicianCategory2CommonIssue3,
    technicianCategory2CommonIssue4,
    technicianCategory2CommonIssue5,
    technicianCategory2CommonIssue6,
    technicianCategory2CommonIssue7,
    technicianCategory2CommonIssue8,
    technicianCategory2CommonIssue9,
  ];

  static List<String> listTechnicianCategory3CommonIssues = [
    technicianCategory3CommonIssue0,
    technicianCategory3CommonIssue1,
    technicianCategory3CommonIssue2,
    technicianCategory3CommonIssue3,
    technicianCategory3CommonIssue4,
    technicianCategory3CommonIssue5,
    technicianCategory3CommonIssue6,
    technicianCategory3CommonIssue7,
    technicianCategory3CommonIssue8,
    technicianCategory3CommonIssue9,
  ];

  static List<String> listTechnicianCategory4CommonIssues = [
    technicianCategory4CommonIssue0,
    technicianCategory4CommonIssue1,
    technicianCategory4CommonIssue2,
    technicianCategory4CommonIssue3,
    technicianCategory4CommonIssue4,
    technicianCategory4CommonIssue5,
    technicianCategory4CommonIssue6,
    technicianCategory4CommonIssue7,
    technicianCategory4CommonIssue8,
    technicianCategory4CommonIssue9,
  ];

  static List<String> listTechnicianCategory5CommonIssues = [
    technicianCategory5CommonIssue0,
    technicianCategory5CommonIssue1,
    technicianCategory5CommonIssue2,
    technicianCategory5CommonIssue3,
    technicianCategory5CommonIssue4,
    technicianCategory5CommonIssue5,
    technicianCategory5CommonIssue6,
    technicianCategory5CommonIssue7,
    technicianCategory5CommonIssue8,
    technicianCategory5CommonIssue9,
  ];

  static List<String> listTechnicianCategory6CommonIssues = [
    technicianCategory6CommonIssue0,
    technicianCategory6CommonIssue1,
    technicianCategory6CommonIssue2,
    technicianCategory6CommonIssue3,
    technicianCategory6CommonIssue4,
    technicianCategory6CommonIssue5,
    technicianCategory6CommonIssue6,
    technicianCategory6CommonIssue7,
    technicianCategory6CommonIssue8,
    technicianCategory6CommonIssue9,
  ];

  static List<String> listTechnicianCategory7CommonIssues = [
    technicianCategory7CommonIssue0,
    technicianCategory7CommonIssue1,
    technicianCategory7CommonIssue2,
    technicianCategory7CommonIssue3,
    technicianCategory7CommonIssue4,
    technicianCategory7CommonIssue5,
    technicianCategory7CommonIssue6,
    technicianCategory7CommonIssue7,
    technicianCategory7CommonIssue8,
    technicianCategory7CommonIssue9,
  ];

  static List<String> listTechnicianCategory8CommonIssues = [
    technicianCategory8CommonIssue0,
    technicianCategory8CommonIssue1,
    technicianCategory8CommonIssue2,
    technicianCategory8CommonIssue3,
    technicianCategory8CommonIssue4,
    technicianCategory8CommonIssue5,
    technicianCategory8CommonIssue6,
    technicianCategory8CommonIssue7,
    technicianCategory8CommonIssue8,
    technicianCategory8CommonIssue9,
  ];

  static List<String> listTechnicianCategory9CommonIssues = [
    technicianCategory9CommonIssue0,
    technicianCategory9CommonIssue1,
    technicianCategory9CommonIssue2,
    technicianCategory9CommonIssue3,
    technicianCategory9CommonIssue4,
    technicianCategory9CommonIssue5,
    technicianCategory9CommonIssue6,
    technicianCategory9CommonIssue7,
    technicianCategory9CommonIssue8,
    technicianCategory9CommonIssue9,
  ];


  //strings for common technicianCategory [x] issues
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