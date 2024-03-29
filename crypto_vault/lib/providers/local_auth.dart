import 'package:flutter/widgets.dart';

import 'package:flutter_bcrypt/flutter_bcrypt.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalAuth with ChangeNotifier {
  String _masterPw;
  bool _isFingerprintCorrect = false;

  bool get isAuthenticated {
    return _masterPw != null && _isFingerprintCorrect;
  }

  String get masterPw {
    return _masterPw;
  }

  set fingerprintStatus (bool status) {
    this._isFingerprintCorrect = status;
  }

  Future<void> login(String pw) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String _pwHash = _prefs.get('pwHash');

    bool _isPwMatch = await FlutterBcrypt.verify(password: pw, hash: _pwHash);
    if (_isPwMatch) {
      _masterPw = pw;
      notifyListeners();
    }
  }

  void logout() {
    _masterPw = null;
    notifyListeners();
  }
}
