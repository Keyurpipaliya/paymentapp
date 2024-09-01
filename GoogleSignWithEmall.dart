import 'package:flutter/material.dart';

class GoogleSignInWithEmail extends StatefulWidget {
  @override
  _GoogleSignInWithEmailState createState() => _GoogleSignInWithEmailState();
}

class _GoogleSignInWithEmailState extends State<GoogleSignInWithEmail> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<UserCredential> signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      return await _auth.signInWithCredential(credential);
    } catch (error) {
      print(error);

      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Sign-In with Email'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            UserCredential userCredential = await signInWithGoogle();
            if (userCredential != null) {
              // Successfully signed in
              User user = userCredential.user;
              print('Signed in user: ${user.displayName}');
              // Navigate to the next screen or perform other actions
            } else {
              // Sign in failed
              print('Sign in failed.');
            }
          },
          child: Text('Sign in with Google'),
        ),
      ),
    );
  }
}
