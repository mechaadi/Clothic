import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/cupertino.dart';

class AuthProvider extends ChangeNotifier {
  auth.User user;
  StreamSubscription userAuthSub;
  AuthProvider() {
    userAuthSub =
        auth.FirebaseAuth.instance.onAuthStateChanged.listen((newUser) {
      user = newUser;
      notifyListeners();
    }, onError: (e) {
      print('AuthProvider - FirebaseAuth - onAuthStateChanged - $e');
    });
  }

  @override
  void dispose() {
    if (userAuthSub != null) {
      userAuthSub.cancel();
      userAuthSub = null;
    }
    super.dispose();
  }

  bool get isAnonymous {
    assert(user != null);
    bool isAnonymousUser = true;
    for (auth.UserInfo info in user.providerData) {
      if (info.providerId == "facebook.com" ||
          info.providerId == "google.com" ||
          info.providerId == "password") {
        isAnonymousUser = false;
        break;
      }
    }
    return isAnonymousUser;
  }

  bool get isAuthenticated {
    print("checking");
    return user != null;
  }

  void signInAnonymously() {
    auth.FirebaseAuth.instance.signInAnonymously();
  }

  void signOut() {
    auth.FirebaseAuth.instance.signOut();
  }
}
