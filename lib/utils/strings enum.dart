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

  //global header in onboarding selection hero tag
  static int globalHeaderHero = 90;

  //strings for the priority page
  static String selectPriorityString = "When do you need the technician?";
  static String immediately = "Right now";
  static String appointment = "Appointment";

  //select technician page strings
  static String selectTechnicianString = "Select a technician";

  static List<Technician> techniciansList = [
    Technician(
      name: "Ahmed",
      desc: "Best plumber ever",
      image: Container(
        height: 25,
        width: 25,
        color: Colors.grey,
      ),
      rating: "5",
      availability: "Available",
    ),
    Technician(
      name: "Samir",
      desc: "electrician",
      image: Container(
        height: 25,
        width: 25,
        color: Colors.grey,
      ),
      rating: "4.5",
      availability: "Not Available",
    ),
    Technician(
      name: "Hosam",
      desc: "I can fix stuff",
      image: Container(
        height: 25,
        width: 25,
        color: Colors.grey,
      ),
      rating: "4.8",
      availability: "Available",
    ),
    Technician(
      name: "Iyad",
      desc: "wood",
      image: Container(
        height: 25,
        width: 25,
        color: Colors.grey,
      ),
      rating: "4.3",
      availability: "Not Available",
    ),
    Technician(
      name: "Gamil",
      desc: "Can do anything!",
      image: Container(
        height: 25,
        width: 25,
        color: Colors.grey,
      ),
      rating: "5",
      availability: "Available",
    ),
    Technician(
      name: "Foaad",
      desc: "electricity pew pew",
      image: Container(
        height: 25,
        width: 25,
        color: Colors.grey,
      ),
      rating: "4.1",
      availability: "Available",
    ),
    Technician(
      name: "Amr",
      desc: "I fix cars",
      image: Container(
        height: 25,
        width: 25,
        color: Colors.grey,
      ),
      rating: "4.8",
      availability: "Not Available",
    ),
    Technician(
      name: "Karim",
      desc: "5 pounds please",
      image: Container(
        height: 25,
        width: 25,
        color: Colors.grey,
      ),
      rating: "5",
      availability: "Available",
    ),
    Technician(
      name: "Mazen",
      desc: "I am watching you",
      image: Container(
        height: 25,
        width: 25,
        color: Colors.grey,
      ),
      rating: "4.9",
      availability: "Available",
    ),
  ];

  //confirm appointment dialog strings
  static String confirmAppointmentDialogTitle = "";

  //list of pending and completed orders page strings
  static String listOfOrdersString = "Previous orders";

  static List<Issue> listOfIssues = [
    Issue(
        issueCategory: "Carpenter",
        issueDesc:
            "Carpenter issue #3, this is quite the long issue by the way!",
        timeRequested: "22 July, 2015",
        timeCompleted: "25 July, 2015",
        assignedTo: "Ahmed",
        isCompleted: false,
        paymentMethod: "In App",
        technicianReview:
            "I really loved the work of this guy, he was quick and "
            "nice. I will definately be ordering him again the next time i need to!",
        technicianRating: "5",
        price: 450.50,
        image: ClipRRect(
          borderRadius: BorderRadius.circular(10.0), //or 15.0
          child: Container(
            height: 75.0,
            width: 75.0,
            color: Color(0xffFF0E58),
            child: Icon(Icons.gps_not_fixed_rounded,
                color: Colors.white, size: 50.0),
          ),
        )),
    Issue(
        issueCategory: "Plumber",
        issueDesc: "Plumber issue #3",
        timeRequested: "13 August, 2015",
        timeCompleted: "25 August, 2015",
        assignedTo: "Samir",
        isCompleted: true,
        paymentMethod: "In Hand",
        technicianReview: "Amazing and super long descreption here just because"
            " I want to test how this super long text will fit, for testing "
            "purposes of course, this is just a test and nothing else, absolutely "
            "nothing else as i would say. Ok I think this is long enough isn't it? "
            "It's about time to stop this review.",
        technicianRating: "5",
        price: 200,
        image: ClipRRect(
          borderRadius: BorderRadius.circular(10.0), //or 15.0
          child: Container(
            height: 75.0,
            width: 75.0,
            color: Color(0xffFF0E58),
            child: Icon(Icons.gps_not_fixed_rounded,
                color: Colors.white, size: 50.0),
          ),
        )),
    Issue(
        issueCategory: "Carpenter",
        issueDesc: "Carpenter issue #3",
        timeRequested: "22 July, 2015",
        timeCompleted: "25 July, 2015",
        assignedTo: "Ahmed",
        isCompleted: false,
        paymentMethod: "In Hand",
        technicianReview:
            "I really loved the work of this guy, he was quick and "
            "nice. I will definately be ordering him again the next time i need to!",
        technicianRating: "5",
        price: 152.22,
        image: ClipRRect(
          borderRadius: BorderRadius.circular(10.0), //or 15.0
          child: Container(
            height: 75.0,
            width: 75.0,
            color: Color(0xffFF0E58),
            child: Icon(Icons.gps_not_fixed_rounded,
                color: Colors.white, size: 50.0),
          ),
        )),
    Issue(
        issueCategory: "Carpenter",
        issueDesc: "Carpenter issue #3",
        timeRequested: "22 July, 2015",
        timeCompleted: "25 July, 2015",
        assignedTo: "Ahmed",
        isCompleted: true,
        paymentMethod: "In Hand",
        technicianReview:
            "I really loved the work of this guy, he was quick and "
            "nice. I will definately be ordering him again the next time i need to!",
        technicianRating: "5",
        price: 152.22,
        image: ClipRRect(
          borderRadius: BorderRadius.circular(10.0), //or 15.0
          child: Container(
            height: 75.0,
            width: 75.0,
            color: Color(0xffFF0E58),
            child: Icon(Icons.gps_not_fixed_rounded,
                color: Colors.white, size: 50.0),
          ),
        )),
    Issue(
        issueCategory: "Carpenter",
        issueDesc: "Carpenter issue #3",
        timeRequested: "22 July, 2015",
        timeCompleted: "25 July, 2015",
        assignedTo: "Ahmed",
        isCompleted: false,
        paymentMethod: "In App",
        technicianReview:
            "I really loved the work of this guy, he was quick and "
            "nice. I will definately be ordering him again the next time i need to!",
        technicianRating: "5",
        price: 152.22,
        image: ClipRRect(
          borderRadius: BorderRadius.circular(10.0), //or 15.0
          child: Container(
            height: 75.0,
            width: 75.0,
            color: Color(0xffFF0E58),
            child: Icon(Icons.gps_not_fixed_rounded,
                color: Colors.white, size: 50.0),
          ),
        )),
    Issue(
        issueCategory: "Carpenter",
        issueDesc: "Carpenter issue #3",
        timeRequested: "22 July, 2015",
        timeCompleted: "25 July, 2015",
        assignedTo: "Ahmed",
        isCompleted: true,
        paymentMethod: "In Hand",
        technicianReview:
            "I really loved the work of this guy, he was quick and "
            "nice. I will definately be ordering him again the next time i need to!",
        technicianRating: "5",
        price: 152.22,
        image: ClipRRect(
          borderRadius: BorderRadius.circular(10.0), //or 15.0
          child: Container(
            height: 75.0,
            width: 75.0,
            color: Color(0xffFF0E58),
            child: Icon(Icons.gps_not_fixed_rounded,
                color: Colors.white, size: 50.0),
          ),
        )),
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
