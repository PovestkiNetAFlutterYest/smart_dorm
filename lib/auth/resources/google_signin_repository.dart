import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:smart_dorm/auth/dto/user_login_info.dart';

class SignInRepository {
  final _googleSignIn = GoogleSignIn();

  Future<UserLoginInfo> login() async {
    try {
      GoogleSignInAccount? data = await _googleSignIn.signIn();
      UserLoginInfo user =
          UserLoginInfo(data?.displayName, data?.email, data?.id);
      return user;
    } on Exception catch (e) {
      if (kDebugMode) {
        print("exception at login: $e");
      }
      rethrow;
    }
  }

  Future<void> logout() async {
    await _googleSignIn.signOut();
    // await _googleSignIn.disconnect();
  }

  Future<bool> isSignedIn() async {
    return await _googleSignIn.isSignedIn();
  }
}
