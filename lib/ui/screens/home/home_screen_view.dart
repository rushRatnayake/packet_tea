class HomeScreenView {

  final String value;

  const HomeScreenView._(this.value);

  static const _home = "HOME";
  static const _manure = "MANURE";
  static const _loan = "LOAN";
  static const _profile = "PROFILE";

  static const home = HomeScreenView._(_home);
  static const manure = HomeScreenView._(_manure);
  static const loan = HomeScreenView._(_loan);
  static const profile = HomeScreenView._(_profile);

  static const values = [];

  static HomeScreenView parse(String value) {
    switch (value) {
      case _home:
        return HomeScreenView.home;
      case _manure:
        return HomeScreenView.manure;
      case _loan:
        return HomeScreenView.loan;
      case _profile:
        return HomeScreenView.profile;
      default:
        return null;
    }
  }
}