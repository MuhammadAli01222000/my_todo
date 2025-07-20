import 'package:my_todo/domain/interfaces/check_input_data.dart';

class CheckInputDataImpl implements CheckInputData {
  bool _checkInput = false;
  @override
  bool valeidateInput({
    required String name,
    required String email,
    required String password,
    required String reconfirmPassword,
  }) {
    if (name.length < 3 ||
        email.length < 11 ||
        password.length < 6 ||
        password != reconfirmPassword) {
      _checkInput = false;
    }
    if (name.length >= 3 &&
        email.length >= 11 &&
        password.length >= 6 &&
        password == reconfirmPassword &&
        email.endsWith("@gmail.com")) {
      _checkInput = true;
    }
    return _checkInput;
  }
}
