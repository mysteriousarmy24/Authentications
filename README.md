# authentication_test

This project demonstrates a simple Firebase Authentication flow in Flutter with:

- Anonymous sign-in
- Logout
- Firebase exception handling with user-friendly messages

## Authentication flow

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