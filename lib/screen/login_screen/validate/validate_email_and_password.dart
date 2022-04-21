mixin ValidationForm {
   bool isValidEmail(String email) {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegExp.hasMatch(email);
  }

  bool isValidUserName(String userName) {
    final nameRegExp = new RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$");
    return nameRegExp.hasMatch(userName);
  }

  bool isValidPassword(String password) {
  final passwordRegExp = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\><*~]).{8,}/pre>');
    return passwordRegExp.hasMatch(password);
  }

  bool isValidPhone(String phoneNumber){
    final phoneRegExp = RegExp(r"^\+?0[0-9]{10}$");
    return phoneRegExp.hasMatch(phoneNumber);
  }
}