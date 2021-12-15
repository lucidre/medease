abstract class Constants {
  static const mulish = 'Mulish';
  static const spartan = 'Spartan';
  static const appName = "MedEase";

  static Uri getAuthUri(String append) =>
      Uri.parse("https://swep-be.herokuapp.com/$append");
}
