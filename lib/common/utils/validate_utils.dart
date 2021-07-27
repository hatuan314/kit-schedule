import 'package:schedule/common/constants/string_constants.dart';

class ValidateUtils {
  String? validatePassword(String pass){
    if (pass.length < 6 || pass.isEmpty){
      return StringConstants.invalidPassword;
    }
    return null;
  }
}