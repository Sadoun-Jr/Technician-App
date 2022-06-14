import 'package:flutter/material.dart';
import 'package:technicians/models/technician%20object.dart';
import 'package:technicians/models/issue%20object.dart';

class AppStrings {

  //login and register pages strings
  static const loginScreenHeader = "Sign in portal";
  static const forgotPassword = "Forgot password";
  static const schoolName = "TEXAS SCHOOL";
  static const registerString = "REGISTER";
  static const usernameString = "User Name";
  static const emailString = "Email";
  static const passwordString = "Password";
  static const loginString = "LOGIN";
  static const noAccountRegisterPlease = "Don't have an account?";
  static const connectWithFb = "CONNECT WITH FACEBOOK";
  static String registerNewAccountString = "Register a new Account";
  static var confirmPasswordString = "Confirm password";
  static String createAccountButton = "CREATE ACCOUNT";
  static String userRegistered = "Registered successfully";

  //login and register FAB hero tags
  static int heroLogin = 111;
  static int heroRegister = 222;
  static int heroConnectwithFb = 333;

  //strings for the priority page
  static String selectPriorityString = "When do you need the technician?";
  static String immediately = "Right now";
  static String appointment = "Appointment";

  //strings for the category page
  //IMPORTANT: NEVER CHANGE THE ARRANGEMENT OF THE CATEGORIES LISTS, JUST ADD IF NEEDED
  //TODO: convert to static strings
  static List<String> listOfTechnicianCategories = [
    "Plumber", "Electrician", "Carpenter", "Painter", "Builder",
    "Cleaner", "Butcher", "Mechanic", "...", "..."
  ];
  //TODO: convert to static strings
  static List<String> listOfAppliancesCategories = [
    "AC", "Refrigirator", "Computer", "Dry cleaner", "Drier",
    "Mobile phone", "Drier", "Other", "///", "///"
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

  //select technician page strings
  static String selectTechnicianString = "Select a technician";

  static List<Technician> techniciansList = [
    Technician(name: "Ahmed", desc: "Best plumber ever",
    image: Container(height: 25, width: 25, color: Colors.grey,),rating: "5",
      availability: "Available",),
    Technician(name: "Samir", desc: "electrician",
      image: Container(height: 25, width: 25, color: Colors.grey,),rating: "4.5",
      availability: "Not Available",),
    Technician(name: "Hosam", desc: "I can fix stuff",
      image: Container(height: 25, width: 25, color: Colors.grey,),rating: "4.8",
      availability: "Available",),
    Technician(name: "Iyad", desc: "wood",
      image: Container(height: 25, width: 25, color: Colors.grey,),rating: "4.3",
      availability: "Not Available",),
    Technician(name: "Gamil", desc: "Can do anything!",
      image: Container(height: 25, width: 25, color: Colors.grey,),rating: "5",
      availability: "Available",),
    Technician(name: "Foaad", desc: "electricity pew pew",
      image: Container(height: 25, width: 25, color: Colors.grey,),rating: "4.1",
      availability: "Available",),
    Technician(name: "Amr", desc: "I fix cars",
      image: Container(height: 25, width: 25, color: Colors.grey,),rating: "4.8",
      availability: "Not Available",),
    Technician(name: "Karim", desc: "5 pounds please",
      image: Container(height: 25, width: 25, color: Colors.grey,),rating: "5",
      availability: "Available",),
    Technician(name: "Mazen", desc: "I am watching you",
      image: Container(height: 25, width: 25, color: Colors.grey,),rating: "4.9",
      availability: "Available",),
  ];

  //confirm appointment dialog strings
  static String confirmAppointmentDialogTitle = "";

  //list of pending and completed orders page strings
  static String listOfOrdersString = "Previous orders";

  static List<Issue> listOfIssues = [
    Issue(issueCategory: "Carpenter", issueDesc: "Carpenter issue #3, this is quite the long issue by the way!",
      timeRequested: "22 July, 2015", timeCompleted: "25 July, 2015",
        assignedTo: "Ahmed", isCompleted: false, paymentMethod: "In App",
      technicianReview: "I really loved the work of this guy, he was quick and "
          "nice. I will definately be ordering him again the next time i need to!",
      technicianRating: "5", price: 450.50,
      image:ClipRRect(
        borderRadius: BorderRadius.circular(10.0),//or 15.0
        child: Container(
          height: 75.0, width: 75.0, color: Color(0xffFF0E58),
          child: Icon(Icons.gps_not_fixed_rounded, color: Colors.white, size: 50.0),
        ),
      )
    ),
    Issue(issueCategory: "Plumber", issueDesc: "Plumber issue #3",
      timeRequested: "13 August, 2015", timeCompleted: "25 August, 2015",
        assignedTo: "Samir", isCompleted: true, paymentMethod: "In Hand",
        technicianReview: "Amazing and super long descreption here just because"
           " I want to test how this super long text will fit, for testing "
          "purposes of course, this is just a test and nothing else, absolutely "
          "nothing else as i would say. Ok I think this is long enough isn't it? "
          "It's about time to stop this review.",
        technicianRating: "5", price: 200,
        image: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),//or 15.0
        child: Container(
          height: 75.0, width: 75.0, color: Color(0xffFF0E58),
          child: Icon(Icons.gps_not_fixed_rounded, color: Colors.white, size: 50.0),
        ),
      )
    ),
    Issue(issueCategory: "Carpenter", issueDesc: "Carpenter issue #3",
        timeRequested: "22 July, 2015", timeCompleted: "25 July, 2015",
        assignedTo: "Ahmed", isCompleted: false, paymentMethod: "In Hand",
        technicianReview: "I really loved the work of this guy, he was quick and "
            "nice. I will definately be ordering him again the next time i need to!",
        technicianRating: "5", price: 152.22,
        image:ClipRRect(
          borderRadius: BorderRadius.circular(10.0),//or 15.0
          child: Container(
            height: 75.0, width: 75.0, color: Color(0xffFF0E58),
            child: Icon(Icons.gps_not_fixed_rounded, color: Colors.white, size: 50.0),
          ),
        )
    ),
    Issue(issueCategory: "Carpenter", issueDesc: "Carpenter issue #3",
        timeRequested: "22 July, 2015", timeCompleted: "25 July, 2015",
        assignedTo: "Ahmed", isCompleted: true, paymentMethod: "In Hand",
        technicianReview: "I really loved the work of this guy, he was quick and "
            "nice. I will definately be ordering him again the next time i need to!",
        technicianRating: "5",price: 152.22,
        image:ClipRRect(
          borderRadius: BorderRadius.circular(10.0),//or 15.0
          child: Container(
            height: 75.0, width: 75.0, color: Color(0xffFF0E58),
            child: Icon(Icons.gps_not_fixed_rounded, color: Colors.white, size: 50.0),
          ),
        )
    ),
    Issue(issueCategory: "Carpenter", issueDesc: "Carpenter issue #3",
        timeRequested: "22 July, 2015", timeCompleted: "25 July, 2015",
        assignedTo: "Ahmed", isCompleted: false, paymentMethod: "In App",
        technicianReview: "I really loved the work of this guy, he was quick and "
            "nice. I will definately be ordering him again the next time i need to!",
        technicianRating: "5",price: 152.22,
        image:ClipRRect(
          borderRadius: BorderRadius.circular(10.0),//or 15.0
          child: Container(
            height: 75.0, width: 75.0, color: Color(0xffFF0E58),
            child: Icon(Icons.gps_not_fixed_rounded, color: Colors.white, size: 50.0),
          ),
        )
    ),
    Issue(issueCategory: "Carpenter", issueDesc: "Carpenter issue #3",
        timeRequested: "22 July, 2015", timeCompleted: "25 July, 2015",
        assignedTo: "Ahmed", isCompleted: true, paymentMethod: "In Hand",
        technicianReview: "I really loved the work of this guy, he was quick and "
            "nice. I will definately be ordering him again the next time i need to!",
        technicianRating: "5",price: 152.22,
        image:ClipRRect(
          borderRadius: BorderRadius.circular(10.0),//or 15.0
          child: Container(
            height: 75.0, width: 75.0, color: Color(0xffFF0E58),
            child: Icon(Icons.gps_not_fixed_rounded, color: Colors.white, size: 50.0),
          ),
        )
    ),
  ];

  //firestore keys
  static String issueCategoryKey = "issueCategory";
  static String issueDescKey = "issueDesc";
  static String completedByKey = "completedBy";
  static String isCompletedKey = "isCompleted";
  static String assignedToKey = "assignedTo";
  static String technicianRatingKey = "technicianRating";
  static String technicianReviewKey = "technicianReview";
  static String timeRequestedKey = "timeRequested";
  static String timeCompletedKey = "timeCompleted";
  static String paymentMethodKey = "paymentMethod";
  static String priceKey = "price";
  static String issueUidKey = "uid";
  static String isEmergencyKey = "isEmergency";
  static String isPaidKey = "isPaid";
  static String issuedByKey = "issuedBy";
  static String isAcceptedByTechnicianKey = "isAcceptedByTechnician";
  static String isCanceledByUserKey = "isCanceledByUser";
  static String uidKey = "uid";

  static String notCompletedYet = "Not yet";

}