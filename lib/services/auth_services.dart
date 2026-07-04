import 'package:authentication_test/pages/exeptions/auth_exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
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

  //sigen with emai & password
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

  //get user details
  User? getUserDetails() {
    return _auth.currentUser;
  }
}
