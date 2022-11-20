import 'package:google_sign_in/google_sign_in.dart';

class SignInRepository {
  final _googleSignIn = GoogleSignIn();

  Future<String?> login() async {
    var data = await _googleSignIn.signIn();

    return data?.email;
  }

  Future<void> logout() async {
    if (await _googleSignIn.isSignedIn()) {
      _googleSignIn.signOut();
    }
  }

  Future<bool> isSignedIn() async {
    return await _googleSignIn.isSignedIn();
  }
}
