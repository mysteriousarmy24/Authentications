# authentication_test

This project demonstrates a simple Firebase Authentication flow in Flutter with:

- Anonymous sign-in
- Logout
- Firebase exception handling with user-friendly messages

## Authentication flow
```YAML
dependencies:
  flutter:
    sdk: flutter
  firebase_core: ^3.0.0      # Use latest compatible versions
  firebase_auth: ^5.0.0
  google_sign_in: ^6.2.0
  ```

### 1. Anonymous login

The app uses Firebase Authentication to sign in anonymously through the authentication service.

```dart
Future<void> signInAnnonimouslyWithExceptions() async {
  try {
    final UserCredential userCredential = await _auth.signInAnonymously();
    final user = userCredential.user;
    if (user != null) {
      print("Signed In annonimously ${user.uid}");
    }
  } on FirebaseAuthException catch (error) {
    throw Exception(mapFirebaseAuthExceptionCode(errorCode: error.code));
  }
}
```

### 2. Handling Firebase exceptions

Firebase errors are handled using a reusable pattern: a helper function is created in a separate file, and then that function is imported and used inside the authentication service.

This keeps the exception logic clean and centralized. Instead of writing error messages directly inside each service method, the project creates a mapper function in a dedicated exception file and calls it from the Firebase service methods.

The helper function in the project converts codes such as:

- `wrong-password` → "The password is invalid or the account does not have a password set."
- `user-not-found` → "No user corresponding to the given email was found."
- `email-already-in-use` → "An account already exists with the given email address."
- `weak-password` → "The password provided is not strong enough."

This makes the app easier to debug and provides clearer feedback to the user.

### 3. Logout

The logout flow signs the current user out and handles Firebase errors in the same way.

```dart
Future<void> signOut() async {
  try {
    await _auth.signOut();
  } on FirebaseAuthException catch (error) {
    throw Exception(mapFirebaseAuthExceptionCode(errorCode: error.code));
  }
}
```

When the user taps the sign-out button from the home page, the app signs them out and navigates back to the authentication page.

## Project structure

- `lib/services/auth_services.dart` → contains the authentication logic
- `lib/pages/exeptions/auth_exceptions.dart` → maps Firebase exception codes to readable messages
- `lib/pages/main-page.dart` → shows the user ID and handles sign-out

## Getting started

1. Make sure Firebase is configured for your platform.
2. Run:

```bash
flutter pub get
flutter run
```

If you want, you can also expand this project later to support email/password login, Google sign-in, or persistent authentication.

### Creating Account using Email & Password
```dart
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
  ```
  ### Signin in Account using Email & Password
  ```Dart
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
  ```
  ### Sign in with Git Hub
  ```Dart
  //sign with github
  Future<void> signWithGitHub() async {
    try {
      final GithubAuthProvider signWithGithub = GithubAuthProvider();
      await _auth.signInWithProvider(signWithGithub);
    } on Exception catch (e) {
      print("Error in authservices github signin $e");
    }
  }
  ```
  ### Signin with Gmail
  ```Dart
  import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<User?> signInWithGoogle() async {
    try {
      // 1. Trigger the native Google sign-in overlay
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null; // User aborted the sign-in

      // 2. Obtain authentication details (tokens) from the request
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // 3. Create a new credential for Firebase Auth
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // 4. Sign in to Firebase with the credential and return the user
      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      return userCredential.user;
      
    } catch (e) {
      print("Google Sign-In Error: $e");
      return null;
    }
  }

  // Sign out helper
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}
```
### Reset Password
```Dart
 Future<void> sendPasswordResetEmail({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      print("Password reset email sent to $email");
    } on FirebaseException catch (e) {
      print(
        "Error in authservices reset password ${mapFirebaseAuthExceptionCode(errorCode: e.code)}",
      );
      throw (mapFirebaseAuthExceptionCode(errorCode: e.code));
    } catch (e) {
      print("Unexpected error occurred: $e");
    }
  }
  ```
  ### Creating Wrapper to prevent redirecting to register page after a Hot restart

  ## 01.Create a Dart file called "wrapper.dart".
  ## 02.Implement this code 
  ```Dart
  class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Something went wrong!'));
        } else if (snapshot.hasData) {
          return MainPage();
        } else {
          return const LoginPage();
        }
      },
    );
  }
}
```

  