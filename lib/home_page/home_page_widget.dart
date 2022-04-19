import 'package:flutter/cupertino.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:petbook/edit_user_profile/edit_user_profile_widget.dart';

import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../create_pet_profile_new/create_pet_profile_new_widget.dart';
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
import 'package:flutter_card_swipper/flutter_card_swiper.dart';
import 'package:flutter_svg/svg.dart';

import '../profile_page/profile_page_widget.dart';
import '../view_pet_profile/view_pet_profile.dart';
import 'package:flutter_slidable/flutter_slidable.dart';


class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key key, this.petProfile}) : super(key: key);

  final PetsRecord petProfile;

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
        
        appBar: AppBar(
          foregroundColor: Colors.black,
          backgroundColor: PetbookTheme.of(context).tertiaryColor,
          elevation: 0,
          actionsIconTheme: IconThemeData(size: 80),
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePageWidget()),
                );
              },
              child: Padding(
              padding: EdgeInsetsDirectional
                  .fromSTEB(0, 0, 10, 0),
              child: Padding(
                  padding:
                      EdgeInsetsDirectional
                          .fromSTEB(
                              1, 1, 1, 1),
                  child: Container(
                    width: 40,
                    height: 40,
                    clipBehavior:
                        Clip.antiAlias,
                    decoration:
                        BoxDecoration(
                      shape:
                          BoxShape.circle,
                    ),
                    child:Image.network(
                    valueOrDefault<String>(
                      profilePageUsersRecord.photoUrl,
                      'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/sample-app-social-app-tx2kqp/assets/5lywt4ult0tj/flouffy-qEO5MpLyOks-unsplash.jpg',
                    ),
                    )
                  ),
                ),
              ),
            )
          ],
          leading: IconButton(
            icon: const Icon(
              Icons.menu,
              size: 32,
            ),
            onPressed: () {
              ZoomDrawer.of(context).toggle();
            },
          ),
        ),
      body: Container(
        color: PetbookTheme.of(context).tertiaryColor,
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello ' + valueOrDefault<String>(
                      profilePageUsersRecord.displayName,
                      '',
                    ),
                    textAlign: TextAlign.start,
                    style:
                        PetbookTheme.of(context).title1,
                  ),
                  const Text(
                    'Good Evening 🌚',
                    style: TextStyle(
                      color: Color.fromARGB(255, 53, 53, 53),
                      fontSize: 15,
                    ),
                  ),
                  
                  const SizedBox(
                    height: 22,
                  ),
                  
                ],
              ),
            ),
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                /*Container(
                  width: size.width,
                  height: size.height / 2,
                  //color: const Color(0XFFDCF2F3),
                ),
                Container(
                  width: size.width,
                  height: size.height / 3,
                  color: Color.fromRGBO(246, 189, 96, 1),
                ),
                Positioned(
                  top: 0,
                  height: 70,
                  width: size.width,
                  child: SizedBox(
                    child: SvgPicture.asset(
                      'assets/images/background-top-wave.svg',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Positioned(
                  height: 70,
                  width: size.width,
                  bottom: 0,
                  child: SizedBox(
                    child: SvgPicture.asset(
                      'assets/images/background-bottom-wave.svg',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),*/
                SizedBox(
                  height: size.height,
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
                        return Column(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                height: 150,
                                child: GestureDetector(
                                  
                                  onTap: () async {
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
                                  child: Lottie.asset('assets/lottie_animations/catanimation.json', repeat: true, reverse: true)
                                )
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Text("It looks like you haven't added any pets yet.\nTap on the Cat to get started!", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w600))

                              )
                            ]
                          
                          
                            
                        );
                      }
                      
                      return GridView.count(
                        // Create a grid with 2 columns. If you change the scrollDirection to
                        // horizontal, this produces 2 rows.
                        crossAxisCount: 2,
                        // Generate 100 widgets that display their index in the List.
                        children:List.generate(
                                          columnPetsRecordList.length,
                                          (columnIndex) {
                                        final columnPetsRecord =
                                            columnPetsRecordList[columnIndex]; {
                         
                          return Center(
                            child: GestureDetector(
                                
                                onTap: () async {
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ViewPetProfileWidget(
                                            petProfile: columnPetsRecord,
                                      ),
                                    ),
                                  );
                                },
                            child: Column(
                              children: [
                                Container(
                                  constraints: BoxConstraints(maxHeight: 150, maxWidth: 150),
                                  margin: const EdgeInsets.symmetric(horizontal: 10.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(30))
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.all(Radius.circular(30)),
                                    child: CachedNetworkImage(
                                    imageUrl:
                                        valueOrDefault<String>(
                                      columnPetsRecord.petPhoto,
                                      'https://post.medicalnewstoday.com/wp-content/uploads/sites/3/2020/02/322868_1100-800x825.jpg',
                                    )),
                                    
                                  
                                  ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(columnPetsRecord.petName, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold), )
                                
                              ] 
                            )
                            
                          )
                          );
                        }}),
                   
                      );
                      
                      
                    
                    }
                  )
                )]
            ),
            
            /*Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Reminders 🗓️',
                    
                    textAlign: TextAlign.start,
                    style:
                        PetbookTheme.of(context).title1,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text('Add a Reminder',
                    
                    textAlign: TextAlign.start,
                    
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  
                
                  
                ],
              ),
            ),*/
          ],
          )
        ),
      ),
    );
      },
    );
  }
  
}