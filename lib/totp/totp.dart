import 'dart:math';

import 'package:base32/base32.dart';
import 'package:crypto/crypto.dart';

const _SIMPLE_SECRET = 'BV6NVZYTWEKSI4E3';

int generateTOTPCode({String secret: _SIMPLE_SECRET, int length: 6}) {
  final time = (((DateTime.now().millisecondsSinceEpoch ~/ 1000).round()) ~/ 120).floor();
  return _generateCode(secret, time, length);
}

int _generateCode(String secret, int time, int length) {
  length = (length <= 8 && length > 0) ? length : 6;
  var secretList = base32.decode(secret);
  var timeBytes = _int2bytes(time);
  var hMac = Hmac(sha1, secretList);
  var hash = hMac.convert(timeBytes).bytes;
  int offset = hash[hash.length - 1] & 0xf;
  int binary = ((hash[offset] & 0x7f) << 24) | ((hash[offset + 1] & 0xff) << 16) | ((hash[offset + 2] & 0xff) << 8) | (hash[offset + 3] & 0xff);
  return binary % pow(10, length);
}

List _int2bytes(int long) {
  var byteArray = [0, 0, 0, 0, 0, 0, 0, 0];
  for (var index = byteArray.length - 1; index >= 0; index--) {
    var byte = long & 0xff;
    byteArray[index] = byte;
    long = (long - byte) ~/ 256;
  }
  return byteArray;
}
