/// [Utils] is a class that contains all the utility functions.
abstract final class Utils {
  /// [isEmailValid] returns true if the email is valid.
  static bool isEmailValid(String? email) {
    if (email == null) return false;
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }
}
