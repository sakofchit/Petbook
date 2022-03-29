import 'package:petbook/login/login_page.dart';

import '../auth/auth_util.dart';
import '../create_account/create_account_page.dart';
import '../petbook/petbook_theme.dart';
import '../petbook/petbook_util.dart';
import '../petbook/petbook_widgets.dart';
import '../forgot_password/forgot_password_widget.dart';
import '../main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key key}) : super(key: key);

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  TextEditingController emailController;
  TextEditingController passwordController;
  bool passwordVisibility;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    passwordVisibility = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: PetbookTheme.of(context).tertiaryColor,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFFEEEEEE),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: Image.asset(
              'assets/images/hero@2x.jpg',
            ).image,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [],
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 150),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Petbook',
                          style: PetbookTheme.of(context).title1,
                        ),
                        
                      ],
                  ),
                  SizedBox(height: 10),
                  Padding(padding: EdgeInsets.only(right: 15), child: Text('Track your pets and their daily needs', style: PetbookTheme.of(context).subtitle1)),
                  SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(const Color(0xff3A405A)),
                        ),
                      onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const LoginPage()),
                          );
                      },
                      child: Text('LOGIN', style: TextStyle(fontWeight: FontWeight.bold)),
                    )
                  ),
                  SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 255, 255, 255)),
                        ),
                      onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const CreateAccountPage()),
                          );
                      },
                      child: Text('SIGN UP', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                    )
                  )
                  
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
