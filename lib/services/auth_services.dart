import 'package:authentication_test/pages/exeptions/auth_exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:google_sign_in/google_sign_in.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email', 'profile']);

  // static const String _serverClientId =
  //     '10312021689-58acq92fv53qreq2d0sd1n75sj59nu6k.apps.googleusercontent.com';
  //sign annonimously
  Future<void> signInAnnonimously() async {
    try {
      final UserCredential userCredential = await _auth.signInAnonymously();
      final user = userCredential.user;
      if (user != null) {
        print("Signed In annonimously ${user.uid}");
      }
    } catch (e) {
      print("Error in annonimous login $e");
    }
  }

  //sign Anonymously with exceptions
  Future<void> signInAnnonimouslyWithExceptions() async {
    try {
      final UserCredential userCredential = await _auth.signInAnonymously();
      final user = userCredential.user;
      if (user != null) {
        print("Signed In annonimously ${user.uid}");
      }
    } on FirebaseAuthException catch (error) {
      print(
        "Error sign in anonymously ${mapFirebaseAuthExceptionCode(errorCode: error.code)}",
      );
      throw Exception(mapFirebaseAuthExceptionCode(errorCode: error.code));
    } catch (e) {
      print("Unexpected error occured $e");
    }
  }

  //signout
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      print("Signedout");
    } on FirebaseAuthException catch (error) {
      print(
        'Error in signout ${mapFirebaseAuthExceptionCode(errorCode: error.code)}',
      );
      throw Exception(mapFirebaseAuthExceptionCode(errorCode: error.code));
    } catch (error) {
      print("Unexpected error occured $error");
    }
  }

  //register with emai & password
  Future<void> registerWithEmailPasword({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (error) {
      print(
        "Error in create with email & passwords ${mapFirebaseAuthExceptionCode(errorCode: error.code)}",
      );
      throw Exception(mapFirebaseAuthExceptionCode(errorCode: error.code));
    } catch (error) {
      print("Unexpected Error occoured $error");
    }
  }

  //sign with emai & password
  Future<void> signWithEmailPasword({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (error) {
      print(
        "Error in sign with email & passwords ${mapFirebaseAuthExceptionCode(errorCode: error.code)}",
      );
      throw Exception(mapFirebaseAuthExceptionCode(errorCode: error.code));
    } catch (error) {
      print("Unexpected Error occoured $error");
    }
  }

  //sign with google
  // Future<void> signWithgoogle() async {
  //   try {
  //     final googleUser = await _googleSignIn.signIn();

  //     if (googleUser == null) {
  //       print("Google sign in cancelled");
  //       return;
  //     }

  //     final GoogleSignInAuthentication googleAuth =
  //         await googleUser.authentication;

  //     final OAuthCredential credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth.accessToken,
  //       idToken: googleAuth.idToken,
  //     );

  //     await _auth.signInWithCredential(credential);
  //     print("Signed in with Google: ${googleUser.email}");
  //   } on FirebaseAuthException catch (error) {
  //     print(
  //       "Error signing in with Google ${mapFirebaseAuthExceptionCode(errorCode: error.code)}",
  //     );
  //     throw Exception(mapFirebaseAuthExceptionCode(errorCode: error.code));
  //   } catch (error) {
  //     print("Unexpected error occurred: $error");
  //   }
  // }
  //sign with github
  Future<void> signWithGitHub() async {
    try {
      final GithubAuthProvider signWithGithub = GithubAuthProvider();
      await _auth.signInWithProvider(signWithGithub);
    } on Exception catch (e) {
      print("Error in authservices github signin $e");
    }
  }

  //get user details
  User? getUserDetails() {
    return _auth.currentUser;
  }
}
