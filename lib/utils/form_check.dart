final phoneReg = RegExp('^[1][3456789][0-9]{9}\$');
final verCodeReg = RegExp('^[0-9]{6}\$');

bool isPhoneValid(phone) {
  return phoneReg.hasMatch(phone);
}

bool isAuthCodeValid(verCode) {
  return verCodeReg.hasMatch(verCode);
}
