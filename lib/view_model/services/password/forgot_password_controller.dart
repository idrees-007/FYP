import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:tech_media/utils/routes/route_name.dart';

import '../../../utils/utils.dart';
import '../session_controller.dart';

class ForgotPasswordController with ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  // DatabaseReference ref = FirebaseDatabase.instance.ref().child('Users');
  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void frgotPassword(BuildContext context, String email) async {
    setLoading(true);
    try {
      auth.sendPasswordResetEmail(email: email).then((value) {
        setLoading(false);
        Navigator.pushNamed(context, RouteName.loginView);
        Utils.ToastMessage('Email Sent To your Provided Address');
      }).onError((error, stackTrace) {
        setLoading(false);
        Utils.ToastMessage(error.toString());
      });
    } catch (e) {
      setLoading(false);
      Utils.ToastMessage(e.toString());
    }
  }
}
