import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../create_pet_profile_new/create_pet_profile_new_widget.dart';
import '../edit_pet_profile/edit_pet_profile_widget.dart';
import '../edit_settings/edit_settings_widget.dart';
import '../petbook/petbook_icon_button.dart';
import '../petbook/petbook_theme.dart';
import '../petbook/petbook_toggle_icon.dart';
import '../petbook/petbook_util.dart';
import '../petbook/petbook_widgets.dart';
import '../petbook/custom_functions.dart' as functions;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';


class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UsersRecord>(
      stream: UsersRecord.getDocument(currentUserReference),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Center(
            child: SizedBox(
              width: 50,
              height: 50,
              child: CircularProgressIndicator(
                color: PetbookTheme.of(context).primaryColor,
              ),
            ),
          );
        }
        final profilePageUsersRecord = snapshot.data;
        return Scaffold(
          key: scaffoldKey,
          backgroundColor: PetbookTheme.of(context).tertiaryColor,
          floatingActionButton: Container(
            height: 65,
            width: 65,
            child: FloatingActionButton(
              child: Icon(Icons.add_rounded, size: 30),
              backgroundColor: PetbookTheme.of(context).primaryColor,
              
              onPressed: () async {
                await Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.bottomToTop,
                    duration: Duration(milliseconds: 250),
                    reverseDuration: Duration(milliseconds: 250),
                    child: CreatePetProfileNewWidget(),
                  ),
                );
              },
            )
          ),
          body: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: PetbookTheme.of(context).tertiaryColor,
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(24, 0, 0, 0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Hi there, ' + valueOrDefault<String>(
                                        profilePageUsersRecord.displayName,
                                        '',
                                      ),
                                      textAlign: TextAlign.start,
                                      style:
                                          PetbookTheme.of(context).title3,
                                    ),
                                    Align(
                                      alignment: AlignmentDirectional(-1, 0),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 4, 0, 0),
                                        child: Text(
                                          profilePageUsersRecord.email,
                                          textAlign: TextAlign.start,
                                          style: PetbookTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'Lexend Deca',
                                                color: Color(0xFFEE8B60),
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal,
                                              ),
                                        ),
                                      ),
                                    ),
                                    
                                  ],
                                ),
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(0.85, 0.68),
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 16, 0),
                                child: Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    color: PetbookTheme.of(context)
                                        .primaryColor,
                                    borderRadius: BorderRadius.circular(90),
                                  ),
                                  child: Align(
                                    alignment: AlignmentDirectional(0.85, 0),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          4, 4, 4, 4),
                                      child: Container(
                                        width: 90,
                                        height: 90,
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                        child: Image.network(
                                          valueOrDefault<String>(
                                            profilePageUsersRecord.photoUrl,
                                            'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/sample-app-social-app-tx2kqp/assets/5lywt4ult0tj/flouffy-qEO5MpLyOks-unsplash.jpg',
                                          ),
                                          fit: BoxFit.fitWidth,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: DefaultTabController(
                    length: 2,
                    initialIndex: 0,
                    child: Column(
                      children: [
                        TabBar(
                          labelColor: PetbookTheme.of(context).primaryColor,
                          unselectedLabelColor:
                              PetbookTheme.of(context).grayIcon,
                          labelStyle: GoogleFonts.getFont(
                            'Roboto',
                          ),
                          indicatorColor:
                              PetbookTheme.of(context).primaryColor,
                          indicatorWeight: 2,
                          tabs: [
                            Tab(
                              text: 'My Pets',
                            ),
                            Tab(
                              text: 'Reminders',
                            ),
                          ],
                        ),
                        Expanded(
                          child: TabBarView(
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  color:
                                      PetbookTheme.of(context).tertiaryColor,
                                ),
                                child: StreamBuilder<List<PetsRecord>>(
                                  stream: queryPetsRecord(
                                    queryBuilder: (PetsRecord) =>
                                        PetsRecord.where('userAssociation',
                                            isEqualTo: currentUserReference),
                                  ),
                                  builder: (context, snapshot) {
                                    // Customize what your widget looks like when it's loading.
                                    if (!snapshot.hasData) {
                                      return Center(
                                        child: SizedBox(
                                          width: 50,
                                          height: 50,
                                          child: CircularProgressIndicator(
                                            color: PetbookTheme.of(context)
                                                .primaryColor,
                                          ),
                                        ),
                                      );
                                    }
                                    List<PetsRecord> columnPetsRecordList =
                                        snapshot.data;
                                    if (columnPetsRecordList.isEmpty) {
                                      return Center(
                                        child: Column(
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.8,
                                              child: Lottie.asset('assets/lottie_animations/catanimation.json', repeat: true, reverse: true)
                                            ),
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                                              child: Text("It looks like you haven't added any pets yet.\nTap on the '+' icon to get started!", textAlign: TextAlign.center)

                                            )
                                          ]
                                        
                                        )
                                        
                                         
                                      );
                                    }
                                    return SingleChildScrollView(
                                      child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: List.generate(
                                          columnPetsRecordList.length,
                                          (columnIndex) {
                                        final columnPetsRecord =
                                            columnPetsRecordList[columnIndex];
                                        return Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 12, 0, 12),
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.9,
                                            height: 400,
                                            decoration: BoxDecoration(
                                              color:
                                                  PetbookTheme.of(context)
                                                      .secondaryColor,
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 3,
                                                  color: Color(0x32000000),
                                                  offset: Offset(0, 1),
                                                )
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                ClipRRect(
                                                  /*borderRadius:
                                                      BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(8),
                                                    bottomRight:
                                                        Radius.circular(8),
                                                    topLeft: Radius.circular(8),
                                                    topRight:
                                                        Radius.circular(8),
                                                  ),*/
                                                  child: Padding(
                                                    padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                                    child: CachedNetworkImage(
                                                    imageUrl:
                                                        valueOrDefault<String>(
                                                      columnPetsRecord.petPhoto,
                                                      'https://post.medicalnewstoday.com/wp-content/uploads/sites/3/2020/02/322868_1100-800x825.jpg',
                                                    ),
                                                    width: 300,
                                                    height: 300,
                                                    fit: BoxFit.cover,
                                                  ),
                                                  )
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                20, 0, 0, 0),
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.max,
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          columnPetsRecord.petName,
                                                          style: PetbookTheme.of(context).title3,
                                                        ),
                                                        Row(
                                                          mainAxisSize: MainAxisSize.max,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                                                              child: Text(
                                                                columnPetsRecord.petType,
                                                                style: PetbookTheme.of(context).bodyText2,
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          4,
                                                                          4,
                                                                          0,
                                                                          0),
                                                              child: Text(
                                                                columnPetsRecord
                                                                    .petAge,
                                                                style: PetbookTheme.of(
                                                                        context)
                                                                    .bodyText2,
                                                              ),
                                                            ),
                                                           /* Padding(
                                                              padding: EdgeInsetsDirectional
                                                                  .fromSTEB(175, 0, 0, 0),
                                                              child: PetbookIconButton(
                                                                borderColor:
                                                                    PetbookTheme.of(
                                                                            context)
                                                                        .gray200,
                                                                borderRadius: 30,
                                                                borderWidth: 2,
                                                                buttonSize: 44,
                                                                icon: Icon(
                                                                  Icons.edit,
                                                                  color: PetbookTheme.of(
                                                                            context)
                                                                        .gray200,
                                                                  size: 24,
                                                                ),
                                                                onPressed: () async {
                                                                  await Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          EditPetProfileWidget(
                                                                        petProfile:
                                                                            columnPetsRecord,
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                              ),
                                                            ),*/
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                      )
                                    );
                                  },
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 32),
                                child: Container()
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
          ),
        );
      },
    );
  }
}
