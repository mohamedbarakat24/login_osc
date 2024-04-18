import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_osc/Screens/HomeScreen.dart';
import 'package:login_osc/sign_in/logIn.dart';

class UserState extends StatelessWidget {
  const UserState({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, userSnapshot) {
          if (userSnapshot.hasData) {
            print('user is login');
            return const HomeScreen();
          } else {
            return LoginScreen();
          }
        });
  }
}
