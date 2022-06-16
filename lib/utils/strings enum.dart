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

  //confirm appointment dialog strings
  static String confirmAppointmentDialogTitle = "";

  //list of pending and completed orders page strings
  static String listOfOrdersString = "Previous orders";

  // static List<Issue> listOfIssues = [
  //   Issue(
  //       issueCategory: "Carpenter",
  //       issueDesc:
  //           "Carpenter issue #3, this is quite the long issue by the way!",
  //       timeRequested: "22 July, 2015",
  //       timeCompleted: "25 July, 2015",
  //       assignedTo: "Ahmed",
  //       isCompleted: false,
  //       paymentMethod: "In App",
  //       technicianReview:
  //           "I really loved the work of this guy, he was quick and "
  //           "nice. I will definately be ordering him again the next time i need to!",
  //       technicianRating: "5",
  //       price: 450.50,
  //       image: ClipRRect(
  //         borderRadius: BorderRadius.circular(10.0), //or 15.0
  //         child: Container(
  //           height: 75.0,
  //           width: 75.0,
  //           color: Color(0xffFF0E58),
  //           child: Icon(Icons.gps_not_fixed_rounded,
  //               color: Colors.white, size: 50.0),
  //         ),
  //       )),
  //   Issue(
  //       issueCategory: "Plumber",
  //       issueDesc: "Plumber issue #3",
  //       timeRequested: "13 August, 2015",
  //       timeCompleted: "25 August, 2015",
  //       assignedTo: "Samir",
  //       isCompleted: true,
  //       paymentMethod: "In Hand",
  //       technicianReview: "Amazing and super long descreption here just because"
  //           " I want to test how this super long text will fit, for testing "
  //           "purposes of course, this is just a test and nothing else, absolutely "
  //           "nothing else as i would say. Ok I think this is long enough isn't it? "
  //           "It's about time to stop this review.",
  //       technicianRating: "5",
  //       price: 200,
  //       image: ClipRRect(
  //         borderRadius: BorderRadius.circular(10.0), //or 15.0
  //         child: Container(
  //           height: 75.0,
  //           width: 75.0,
  //           color: Color(0xffFF0E58),
  //           child: Icon(Icons.gps_not_fixed_rounded,
  //               color: Colors.white, size: 50.0),
  //         ),
  //       )),
  //   Issue(
  //       issueCategory: "Carpenter",
  //       issueDesc: "Carpenter issue #3",
  //       timeRequested: "22 July, 2015",
  //       timeCompleted: "25 July, 2015",
  //       assignedTo: "Ahmed",
  //       isCompleted: false,
  //       paymentMethod: "In Hand",
  //       technicianReview:
  //           "I really loved the work of this guy, he was quick and "
  //           "nice. I will definately be ordering him again the next time i need to!",
  //       technicianRating: "5",
  //       price: 152.22,
  //       image: ClipRRect(
  //         borderRadius: BorderRadius.circular(10.0), //or 15.0
  //         child: Container(
  //           height: 75.0,
  //           width: 75.0,
  //           color: Color(0xffFF0E58),
  //           child: Icon(Icons.gps_not_fixed_rounded,
  //               color: Colors.white, size: 50.0),
  //         ),
  //       )),
  //   Issue(
  //       issueCategory: "Carpenter",
  //       issueDesc: "Carpenter issue #3",
  //       timeRequested: "22 July, 2015",
  //       timeCompleted: "25 July, 2015",
  //       assignedTo: "Ahmed",
  //       isCompleted: true,
  //       paymentMethod: "In Hand",
  //       technicianReview:
  //           "I really loved the work of this guy, he was quick and "
  //           "nice. I will definately be ordering him again the next time i need to!",
  //       technicianRating: "5",
  //       price: 152.22,
  //       image: ClipRRect(
  //         borderRadius: BorderRadius.circular(10.0), //or 15.0
  //         child: Container(
  //           height: 75.0,
  //           width: 75.0,
  //           color: Color(0xffFF0E58),
  //           child: Icon(Icons.gps_not_fixed_rounded,
  //               color: Colors.white, size: 50.0),
  //         ),
  //       )),
  //   Issue(
  //       issueCategory: "Carpenter",
  //       issueDesc: "Carpenter issue #3",
  //       timeRequested: "22 July, 2015",
  //       timeCompleted: "25 July, 2015",
  //       assignedTo: "Ahmed",
  //       isCompleted: false,
  //       paymentMethod: "In App",
  //       technicianReview:
  //           "I really loved the work of this guy, he was quick and "
  //           "nice. I will definately be ordering him again the next time i need to!",
  //       technicianRating: "5",
  //       price: 152.22,
  //       image: ClipRRect(
  //         borderRadius: BorderRadius.circular(10.0), //or 15.0
  //         child: Container(
  //           height: 75.0,
  //           width: 75.0,
  //           color: Color(0xffFF0E58),
  //           child: Icon(Icons.gps_not_fixed_rounded,
  //               color: Colors.white, size: 50.0),
  //         ),
  //       )),
  //   Issue(
  //       issueCategory: "Carpenter",
  //       issueDesc: "Carpenter issue #3",
  //       timeRequested: "22 July, 2015",
  //       timeCompleted: "25 July, 2015",
  //       assignedTo: "Ahmed",
  //       isCompleted: true,
  //       paymentMethod: "In Hand",
  //       technicianReview:
  //           "I really loved the work of this guy, he was quick and "
  //           "nice. I will definately be ordering him again the next time i need to!",
  //       technicianRating: "5",
  //       price: 152.22,
  //       image: ClipRRect(
  //         borderRadius: BorderRadius.circular(10.0), //or 15.0
  //         child: Container(
  //           height: 75.0,
  //           width: 75.0,
  //           color: Color(0xffFF0E58),
  //           child: Icon(Icons.gps_not_fixed_rounded,
  //               color: Colors.white, size: 50.0),
  //         ),
  //       )),
  // ];

  //firestore issue collection keys
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

  //firestore technician collection keys
  static String firstNameKey = "firstName";
  static String familyNameKey = "familyName";
  static String jobTitleKey = "mainDesc"; //TODO: change to "jobTitle"
  static String profileDescKey = "profileDesc";
  static String technicianUidKey = "technicianUid";
  static String imageKey = "image";
  static String overallRatingKey = "overallRating";
  static String isAvailableKey = "isAvailable";
  static String jobsCompletedKey = "jobsCompleted";
  static String jobsDeclinedKey = "jobsDeclined";
  static String completionRateKey = "completionRate";
  static String jobsTerminatedMidWorkKey = "jobsTerminatedMidWork";
  static String requestAcceptanceRateKey = "requestAcceptanceRate";
  static String accountCreationTimeStampKey = "accountCreationTime";
  static String portfolioItemsKey = "portfolio items";
  static String isPreferredKey = "isPreferred";
  static String phoneNumberKey = "phoneNumber";
  static String emailKey = "email";
  static String jobsPaidPhysicallyKey = "jobsPaidPhysically";
  static String jobsPaidThroughAppKey = "jobsPaidThroughApp";
  static String isVerifiedByIdKey = "isIdVerified";
  static String appliancesSubscribedToKey = "appliancesSubscribedTo";
  static String isAvailableForEmergenciesKey = "isAvailableForEmergencies";
  static String numberOfFavouritesKey = "numberOfFavourites";
  static String listOfFavouritedByKey = "favouritedBy";
  static String numberOfReviewsKey = "numberOfReviews";
  static String locationKey = "location";
  static String mapPricesOfIssuesKey = "mapPricesOfIssues";

  static List<String> firstNamesList = [
    "Adam",
    "Alex",
    "Aaron",
    "Ben",
    "Carl",
    "Dan",
    "David",
    "Edward",
    "Fred",
    "Frank",
    "George",
    "Hal",
    "Hank",
    "Ike",
    "John",
    "Jack",
    "Joe",
    "Larry",
    "Monte",
    "Matthew",
    "Mark",
    "Nathan",
    "Otto",
    "Paul",
    "Peter",
    "Roger",
    "Roger",
    "Steve",
    "Thomas",
    "Tim",
    "Ty",
    "Victor",
    "Walter"
  ];
  static List<String> lastNamesList = [
    "Anderson",
    "Ashwoon",
    "Aikin",
    "Bateman",
    "Bongard",
    "Bowers",
    "Boyd",
    "Cannon",
    "Cast",
    "Deitz",
    "Dewalt",
    "Ebner",
    "Frick",
    "Hancock",
    "Haworth",
    "Hesch",
    "Hoffman",
    "Kassing",
    "Knutson",
    "Lawless",
    "Lawicki",
    "Mccord",
    "McCormack",
    "Miller",
    "Myers",
    "Nugent",
    "Ortiz",
    "Orwig",
    "Ory",
    "Paiser",
    "Pak",
    "Pettigrew",
    "Quinn",
    "Quizoz",
    "Ramachandran",
    "Resnick",
    "Sagar",
    "Schickowski",
    "Schiebel",
    "Sellon",
    "Severson",
    "Shaffer",
    "Solberg",
    "Soloman",
    "Sonderling",
    "Soukup",
    "Soulis",
    "Stahl",
    "Sweeney",
    "Tandy",
    "Trebil",
    "Trusela",
    "Trussel",
    "Turco",
    "Uddin",
    "Uflan",
    "Ulrich",
    "Upson",
    "Vader",
    "Vail",
    "Valente",
    "Van Zandt",
    "Vanderpoel",
    "Ventotla",
    "Vogal",
    "Wagle",
    "Wagner",
    "Wakefield",
    "Weinstein",
    "Weiss",
    "Woo",
    "Yang",
    "Yates",
    "Yocum",
    "Zeaser",
    "Zeller",
    "Ziegler",
    "Bauer",
    "Baxster",
    "Casal",
    "Cataldi",
    "Caswell",
    "Celedon",
    "Chambers",
    "Chapman",
    "Christensen",
    "Darnell",
    "Davidson",
    "Davis",
    "DeLorenzo",
    "Dinkins",
    "Doran",
    "Dugelman",
    "Dugan",
    "Duffman",
    "Eastman",
    "Ferro",
    "Ferry",
    "Fletcher",
    "Fietzer",
    "Hylan",
    "Hydinger",
    "Illingsworth",
    "Ingram",
    "Irwin",
    "Jagtap",
    "Jenson",
    "Johnson",
    "Johnsen",
    "Jones",
    "Jurgenson",
    "Kalleg",
    "Kaskel",
    "Keller",
    "Leisinger",
    "LePage",
    "Lewis",
    "Linde",
    "Lulloff",
    "Maki",
    "Martin",
    "McGinnis",
    "Mills",
    "Moody",
    "Moore",
    "Napier",
    "Nelson",
    "Norquist",
    "Nuttle",
    "Olson",
    "Ostrander",
    "Reamer",
    "Reardon",
    "Reyes",
    "Rice",
    "Ripka",
    "Roberts",
    "Rogers",
    "Root",
    "Sandstrom",
    "Sawyer",
    "Schlicht",
    "Schmitt",
    "Schwager",
    "Schutz",
    "Schuster",
    "Tapia",
    "Thompson",
    "Tiernan",
    "Tisler"
  ];
  static List<String> locationsList = [
    "Alexandria",
    "Aswan",
    "Asyut",
    "Beheira",
    "Beni Suef",
    "Cairo",
    "Dakahlia",
    "Damietta",
    "Faiyum",
    "Gharbia",
    "Giza",
    "Ismailia",
    "Kafr El Sheikh",
    "Luxor",
    "Matruh",
    "Minya",
    "Monufia",
    "New Valley",
    "North Sinai",
    "Port Said",
    "Qalyubia",
    "Qena",
    "Red Sea",
    "Sharqia",
    "Sohag",
    "South Sinai",
    "Suez"
  ];

  static String notCompletedYet = "Not yet";
}
