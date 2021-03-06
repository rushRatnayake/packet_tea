class EndPoints{


  ///Manure : Endpoints
  static const String requestManure = "manure";
  static const String deleteManure = "manure/";
  static const String getManureByUserID = "manure/estate/";
  static const String getManureTotal = "";

  ///User : Endpoints
  static const String customerLogin = "user/mobile/login";
  static const String getUserBalance = "test";
  static const String getDashboardData = "tea-estate/";
  static const String getEstates = "tea-estate/owner/related/list";
  static const String getUserData = "user/mobile/me";

  ///Loans : Endpoints
  static const String requestLoan = "loan";
  static const String getLoansByEstateID = "loan/estate/";
  static const String deleteLoans = "loan/";


  ///Harvest : Endpoints
  static const String getHarvestByEstateID = "/harvest/tea-estate/";



}