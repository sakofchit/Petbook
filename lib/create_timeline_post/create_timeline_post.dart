import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:petbook/create_timeline_post/petbook_video_player.dart';
import 'package:petbook/home_page/home_page_widget.dart';
import 'package:petbook/main.dart';

import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../backend/firebase_storage/storage.dart';
import '../backend/schema/pet_posts_record.dart';
import '../petbook/petbook_icon_button.dart';
import '../petbook/petbook_media_display.dart';
import '../petbook/petbook_theme.dart';
import '../petbook/petbook_util.dart';
import '../petbook/petbook_widgets.dart';
import '../petbook/upload_media.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../petbook/custom_functions.dart' as functions;
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:age_calculator/age_calculator.dart';

class CreateTimelinePostWidget extends StatefulWidget {
  const CreateTimelinePostWidget({Key key}) : super(key: key);

  @override
  _CreateTimelinePostWidgetState createState() =>
      _CreateTimelinePostWidgetState();
}

class _CreateTimelinePostWidgetState extends State<CreateTimelinePostWidget> {
  String uploadedFileUrl = '';
  TextEditingController textController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: PetbookTheme.of(context).background,
        automaticallyImplyLeading: false,
        title: Text(
          'Add to Timeline',
          style: PetbookTheme.of(context).title2.override(
                fontFamily: 'Lexend Deca',
                color: Color(0xFF090F13),
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
        ),
        actions: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
            child: PetbookIconButton(
              borderColor: Colors.transparent,
              borderRadius: 30,
              buttonSize: 48,
              icon: Icon(
                Icons.close_rounded,
                color: Color(0xFF95A1AC),
                size: 30,
              ),
              onPressed: () async {
                Navigator.pop(context);
              },
            ),
          ),
        ],
        centerTitle: false,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                height: 350,
                                child: Stack(
                                  children: [
                                    if (!(functions.hasUploadedMedia(
                                            uploadedFileUrl)) ??
                                        true)
                                      InkWell(
                                        onTap: () async {
                                          final selectedMedia =
                                              await selectMediaWithSourceBottomSheet(
                                            context: context,
                                            allowPhoto: true,
                                            allowVideo: true,
                                            backgroundColor:
                                                PetbookTheme.of(context)
                                                    .dark600,
                                            textColor:
                                                PetbookTheme.of(context)
                                                    .tertiaryColor,
                                            pickerFontFamily: 'Lexend Deca',
                                          );
                                          if (selectedMedia != null &&
                                              validateFileFormat(
                                                  selectedMedia.storagePath,
                                                  context)) {
                                            showUploadMessage(
                                              context,
                                              'Uploading file...',
                                              showLoading: true,
                                            );
                                            final downloadUrl =
                                                await uploadData(
                                                    selectedMedia.storagePath,
                                                    selectedMedia.bytes);
                                            ScaffoldMessenger.of(context)
                                                .hideCurrentSnackBar();
                                            if (downloadUrl != null) {
                                              setState(() => uploadedFileUrl =
                                                  downloadUrl);
                                              showUploadMessage(
                                                context,
                                                'Success!',
                                              );
                                            } else {
                                              showUploadMessage(
                                                context,
                                                'Failed to upload media',
                                              );
                                              return;
                                            }
                                          }
                                        },
                                        child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 350,
                                          decoration: BoxDecoration(
                                            color: Color(0xFFF1F5F8),
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: Image.asset(
                                                'assets/images/emptyPost@2x.png',
                                              ).image,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                blurRadius: 3,
                                                color: Color(0x2D000000),
                                                offset: Offset(0, 1),
                                              )
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(0),
                                          ),
                                        ),
                                      ),
                                    if (functions.hasUploadedMedia(
                                            uploadedFileUrl) ??
                                        true)
                                      Align(
                                        alignment: AlignmentDirectional(0, 0),
                                        child: PetbookMediaDisplay(
                                          path: uploadedFileUrl,
                                          imageBuilder: (path) => Image.network(
                                            path,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: double.infinity,
                                            fit: BoxFit.cover,
                                          ),
                                          videoPlayerBuilder: (path) =>
                                              PetbookVideoPlayer(
                                            path: path,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            autoPlay: false,
                                            looping: true,
                                            showControls: true,
                                            allowFullScreen: true,
                                            allowPlaybackSpeedMenu: false,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        controller: textController,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          hintText: 'Comment....',
                                          hintStyle:
                                              PetbookTheme.of(context)
                                                  .bodyText2
                                                  .override(
                                                    fontFamily: 'Lexend Deca',
                                                    color: Color(0xFF8B97A2),
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  PetbookTheme.of(context)
                                                      .gray200,
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(0),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  PetbookTheme.of(context)
                                                      .gray200,
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(0),
                                          ),
                                          contentPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  20, 20, 20, 12),
                                        ),
                                        style: PetbookTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: 'Lexend Deca',
                                              color: Color(0xFF090F13),
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
                                            ),
                                        textAlign: TextAlign.start,
                                        maxLines: 4,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                 /*Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FlutterFlowPlacePicker(
                        iOSGoogleMapsApiKey: '',
                        androidGoogleMapsApiKey: '',
                        webGoogleMapsApiKey: '',
                        onSelect: (place) =>
                            setState(() => placePickerValue = place),
                        defaultText: 'Location',
                        icon: Icon(
                          Icons.place,
                          color: PetbookTheme.of(context).grayIcon,
                          size: 24,
                        ),
                        buttonOptions: FFButtonOptions(
                          width: 300,
                          height: 60,
                          color: Colors.white,
                          textStyle:
                              PetbookTheme.of(context).subtitle2.override(
                                    fontFamily: 'Lexend Deca',
                                    color: Color(0xFF95A1AC),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                          borderSide: BorderSide(
                            color: Color(0xFFDBE2E7),
                            width: 2,
                          ),
                          borderRadius: 8,
                        ),
                      ),
                    ],
                  ),*/
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 100,
            decoration: BoxDecoration(
              color: PetbookTheme.of(context).primaryColor,
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 40),
              child: FFButtonWidget(
                onPressed: () async {
                  final petPostsCreateData = createPetPostsRecordData(
                    postPhoto: uploadedFileUrl,
                    postDescription: textController.text,
                    postUser: currentUserReference,
                    //petProfile:
                    postTitle: '',
                    timePosted: getCurrentTimestamp,
                    postOwner: true,
                  );
                  await PetPostsRecord.collection
                      .doc()
                      .set(petPostsCreateData);
                  await Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.leftToRight,
                      duration: Duration(milliseconds: 250),
                      reverseDuration: Duration(milliseconds: 250),
                      child: NavBarPage(initialPage: 'homePage'),
                    ),
                  );
                },
                text: 'Add to Timeline',
                options: FFButtonOptions(
                  width: 270,
                  height: 50,
                  color: PetbookTheme.of(context).primaryColor,
                  textStyle: PetbookTheme.of(context).subtitle2.override(
                        fontFamily: 'Lexend Deca',
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                  elevation: 0,
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 1,
                  ),
                  borderRadius: 8,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


}

