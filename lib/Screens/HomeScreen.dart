import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 250,
        height: 250,
        child: InkWell(
          onTap: () {
            FirebaseAuth.instance.signOut();
          },
          child: const ListTile(
            title: Text('LOG OUT'),
            leading: Icon(Icons.logout),
          ),
        ),
        color: Colors.black12,
      ),
    );
  }
}
