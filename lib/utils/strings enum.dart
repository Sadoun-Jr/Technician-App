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
  static String isSetBasicInfo = "user set basic info already";

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

  //consumer database keys
  static String listOfFavouritesKey = "listOfFavourites";
  static String userUidKey =
      "userUid"; //TODO: CHANGE TO userUid both var and value

  //database empty values when creating issue, NY = not yet
  static String paymentMethodNY = " ";
  static String reviewNY = " ";
  static int priceNY = 0;
  static double ratingNY = 0.0;
  static int timeCompletedNY = 0;
  static String descNY = "No description made";


  //issue database keys
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
  static String issuedToKey = "issuedTo";
  static String isTerminatedMidWork = "isTerminatedMidWork";
  static String isAcceptedByTechnicianKey = "isAcceptedByTechnician";
  static String isCanceledByUserKey = "isCanceledByUser";

  //technician collection keys
  static String firstNameKey = "firstName";
  static String familyNameKey = "familyName";
  static String technicianUid = "technicianUid";
  static String jobTitleKey = "jobTitle";
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
  static String mapPricesOfJobIssuesKey = "pricesOfJobIssues";
  static String mapPricesOfApplianceIssuesKey = "pricesOfApplianceIssues";
  static String ageKey= "age";
  static String subLocationKey = "subLocation";
  static String technicianDesc = "techDesc";

  //portfolio database keys
  static String portfolioUidkey = "portfolioUid";
  static String titlekey = "title";
  static String portfolioDesckey = "desc";
  static String dateAddedkey = "dateAdded";
  static String numberOfViewskey = "numberOfViews";
  static String numberOfPictureskey = "numberOfPictures";
  static String numberOfFavouriteskey = "numberOfFavourites";
  static String listOfImagePathskey = "listOfImagePaths";

  static List<String> listOfReviews = [
    "Condimentum sagittis laoreet nu"
        "llam curabitur lorem adipiscing viverra at dolor ipsum id libero dolor sit amet a consectetur nunc in libero",
    "Nullam curabitur auctor in elit euismod nunc lorem ipsum laoreet condimentum viverra est libero tincidunt id consectetur sit adipiscing",
    "Nullam dolor odio at viverra id sagittis elit in amet auctor a vel lorem laoreet euismod tincidunt",
    "Consectetur odio nunc nullam viverra curabitur vitae dolor amet euismod enim id libero libero sit ipsum elit nec sagittis id auctor lorem at vel adipiscing est",
    "Lorem libero curabitur tincidunt ipsum viverra est id dolor at laoreet auctor nec nunc sagittis vitae libero condimentum dolor euismod sit nullam elit amet vel odio enim consectetur",
    "Libero lorem curabitur amet in elit ipsum est odio a euismod condimentum laoreet libero nullam consectetur viverra id nec sagittis sit at dolor dolor enim nunc auctor vel tincidunt vitae",
    "Elit lorem adipiscing curabitur consectetur id laoreet id viverra in at libero auctor sit tincidunt vitae amet a nec est vel",
    "Ipsum laoreet lorem viverra condimentum est libero enim adipiscing dolor nunc libero elit auctor id vitae nullam nec vel consectetur",
    "Dolor sit dolor consectetur curabitur nunc est at tincidunt ipsum lorem libero adipiscing libero laoreet",
    "Ipsum a lorem libero at consectetur vitae odio id sagittis nullam nunc enim elit libero amet nec",
    "Ipsum in elit odio id condimentum viverra lorem amet curabitur dolor dolor sit libero adipiscing nunc auctor enim id libero est nullam euismod nec a vitae consectetur",
    "Consectetur viverra lorem sit ipsum in libero nullam dolor auctor tincidunt libero vel amet adipiscing elit euismod est condimentum"
  ];

  static List<String> myUris = [
    "https://firebasestorage.googleapis.com/v0/b/technicians-2d714.appspot.com/o/portfolios%2Ftech%20uid%2Fportfolio%20%232?alt=media&token=9cfc0ccf-cbeb-404e-80a7-fcfc454ed75f",
    "https://firebasestorage.googleapis.com/v0/b/technicians-2d714.appspot.com/o/portfolios%2Ftech%20uid%2Fportfolio%20%230?alt=media&token=4bb10a54-aaee-4fcc-ba8f-65d595f83bb7",
    "https://firebasestorage.googleapis.com/v0/b/technicians-2d714.appspot.com/o/portfolios%2Ftech%20uid%2Fportfolio%20%233?alt=media&token=bf7545e3-a02d-4a24-82ee-791c83b7334c",
    "https://firebasestorage.googleapis.com/v0/b/technicians-2d714.appspot.com/o/portfolios%2Ftech%20uid%2Fportfolio%20%231?alt=media&token=ad607bf8-0e70-4e71-ae9c-df320a91375c",
    "https://firebasestorage.googleapis.com/v0/b/technicians-2d714.appspot.com/o/portfolios%2Ftech%20uid%2Fportfolio%20%231?alt=media&token=22d11aff-9399-42b0-b92a-5f6d99838051",
  ];

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
