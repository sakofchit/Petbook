import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../create_pet_profile/create_pet_profile_widget.dart';
import '../petbook/petbook_theme.dart';

class ConfirmEmail extends StatefulWidget {
  @override
  _ConfirmEmailState createState() => _ConfirmEmailState();
}

class _ConfirmEmailState extends State<ConfirmEmail> {
  final auth = FirebaseAuth.instance;
  User user;
  Timer timer;

  @override
  void initState() {
    user = auth.currentUser;
    user.sendEmailVerification();

    timer = Timer.periodic(Duration(seconds: 5), (timer) {
      checkEmailVerified();
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PetbookTheme.of(context).tertiaryColor,
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 200),
            SizedBox(height: 250, child: Lottie.asset("assets/lottie_animations/email.json")),
            Padding(
              padding: EdgeInsets.all(30),
              child: Text(
                'An email has been sent to ${user.email}. Please click on the verification link to proceed.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16)
              ),
            )
            
          ],
        )
      ),
    );
  }

  Future<void> checkEmailVerified() async {
    user = auth.currentUser;
    await user.reload();
    if (user.emailVerified) {
      timer.cancel();
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => CreatePetProfileWidget()));
    }
  }
}