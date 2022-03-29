import '../auth/auth_util.dart';
import '../petbook/petbook_theme.dart';
import '../petbook/petbook_util.dart';
import '../petbook/petbook_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPasswordWidget extends StatefulWidget {
  const ForgotPasswordWidget({Key key}) : super(key: key);

  @override
  _ForgotPasswordWidgetState createState() => _ForgotPasswordWidgetState();
}

class _ForgotPasswordWidgetState extends State<ForgotPasswordWidget> {
  TextEditingController phoneNumberController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    phoneNumberController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: PetbookTheme.of(context).tertiaryColor,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () async {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.chevron_left_rounded,
            color: PetbookTheme.of(context).dark600,
            size: 32,
          ),
        ),
        title: Text(
          'Forgot Password',
          style: PetbookTheme.of(context).title2,
        ),
        actions: [],
        centerTitle: false,
        elevation: 0,
      ),
      backgroundColor: PetbookTheme.of(context).tertiaryColor,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
            child: TextFormField(
              controller: phoneNumberController,
              obscureText: false,
              decoration: InputDecoration(
                labelText: 'Enter your email',
                
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 136, 136, 136),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 136, 136, 136),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                filled: true,
                fillColor: PetbookTheme.of(context).tertiaryColor,
                contentPadding: EdgeInsetsDirectional.fromSTEB(20, 24, 20, 24),
              ),
            
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20, 12, 20, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Text(
                    'We will send you an email with a link to reset your password.',
                    style: PetbookTheme.of(context).bodyText1,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20, 24, 20, 0),
            child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(const Color(0xff3A405A)),
                      ),
                    onPressed: () async {
                      if (phoneNumberController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Email required!',
                            ),
                          ),
                        );
                        return;
                      }
                      await resetPassword(
                        email: phoneNumberController.text,
                        context: context,
                      );
                    },
                    child: Text('Send Reset Link', style: TextStyle(fontWeight: FontWeight.bold)),
               ))
          ),
        ],
      ),
    );
  }
}
