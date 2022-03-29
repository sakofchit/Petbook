import '../auth/auth_util.dart';
import '../petbook/petbook_theme.dart';
import '../petbook/petbook_util.dart';
import '../petbook/petbook_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChangePasswordWidget extends StatefulWidget {
  const ChangePasswordWidget({Key key}) : super(key: key);

  @override
  _ChangePasswordWidgetState createState() => _ChangePasswordWidgetState();
}

class _ChangePasswordWidgetState extends State<ChangePasswordWidget> {
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
          'Change Password',
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
                  borderRadius: BorderRadius.circular(8),
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
              style: PetbookTheme.of(context).bodyText1.override(
                    fontFamily: 'Lexend Deca',
                    color: PetbookTheme.of(context).primaryDark,
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
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
                    'We will send you an email with a link to reset your password, please enter the email associated with your account above.',
                    style: PetbookTheme.of(context).bodyText1,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
            child: FFButtonWidget(
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
              text: 'Send Reset Link',
              options: FFButtonOptions(
                width: 200,
                height: 50,
                color: PetbookTheme.of(context).primaryColor,
                textStyle: PetbookTheme.of(context).subtitle2.override(
                      fontFamily: 'Lexend Deca',
                      color: PetbookTheme.of(context).tertiaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                elevation: 3,
                borderSide: BorderSide(
                  color: Colors.transparent,
                  width: 1,
                ),
                borderRadius: 8,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
