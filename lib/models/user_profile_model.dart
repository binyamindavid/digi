class UserProfileModel {
  final email;
  final username;
  final mobile;
  final firstName;
  final lastName;
  final bool isLoggedIn;

  UserProfileModel(
      {this.email,
      this.username,
      this.mobile,
      this.firstName,
      this.lastName,
      this.isLoggedIn: false});
}