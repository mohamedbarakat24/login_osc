// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:login_osc/sign_in/logIn.dart';
// import 'package:login_osc/sign_in/signUp.dart';
// import 'package:login_osc/user_state.dart';
// import 'package:firebase_core/firebase_core.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   if (kIsWeb) {
//     await Firebase.initializeApp(
//         options: FirebaseOptions(
//             apiKey: "AIzaSyAtA0hx78lRlb-yPnGCEzu2ngbR0_i5IeY",
//             authDomain: "loginosc-973f7.firebaseapp.com",
//             projectId: "loginosc-973f7",
//             storageBucket: "loginosc-973f7.appspot.com",
//             messagingSenderId: "281548009556",
//             appId: "1:281548009556:web:8232b6d8698c50fdb7bdc1"));
//   } else {
//     await Firebase.initializeApp();
//   }

//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: const UserState(),
//     );
//   }
// }

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:login_osc/user_state.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<FirebaseApp> _appIntialization = Firebase.initializeApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _appIntialization,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          }

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
                  .copyWith(background: const Color(0xffede7dc)),
            ),
            home: const UserState(),
          );
        });
  }
}
