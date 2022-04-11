import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:petbook/edit_user_profile/edit_user_profile_widget.dart';

import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../create_pet_profile_new/create_pet_profile_new_widget.dart';
import '../edit_pet_profile/edit_pet_profile_widget.dart';
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


class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key key}) : super(key: key);

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
          actionsIconTheme: IconThemeData(size: 50),
          actions: [
            IconButton(
              iconSize: 55,
              icon: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 2,
                  ),
                ),
                child: ClipRRect(
                  child: Image.network(
                    valueOrDefault<String>(
                      profilePageUsersRecord.photoUrl,
                      'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/sample-app-social-app-tx2kqp/assets/5lywt4ult0tj/flouffy-qEO5MpLyOks-unsplash.jpg',
                    ),
                    fit: BoxFit.fitWidth,
                  ),
                  borderRadius: BorderRadius.circular(20.0),
                  )
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePageWidget()),
                );
              },
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
                  SizedBox(
                    height: 55.0,
                    child: CategorySelectionList(),
                  ),
                ],
              ),
            ),
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Container(
                  width: size.width,
                  height: size.height / 2,
                  //color: const Color(0XFFDCF2F3),
                ),
                Container(
                  width: size.width,
                  height: size.height / 3,
                  color: const Color(0XFFF6BD60),
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
                ),
                SizedBox(
                  height: size.height / 3.1,
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
                            
                                width: MediaQuery.of(context)
                                        .size
                                        .width *
                                    0.6,
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
                      
                      return Swiper(
                        loop: false,
                        itemBuilder: (context, index) {
                        
                        return Wrap(
                          children: List.generate(
                                          columnPetsRecordList.length,
                                          (columnIndex) {
                                        final columnPetsRecord =
                                            columnPetsRecordList[columnIndex];

                          return GestureDetector(
                                onTap: () async {
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ViewPetProfileWidget(
                                        petProfile:
                                            columnPetsRecord,
                                      ),
                                    ),
                                  );
                                },
                            child: Container(

                            margin: const EdgeInsets.symmetric(horizontal: 10.0),
                            width: 200,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: CachedNetworkImage(
                              imageUrl:
                                  valueOrDefault<String>(
                                columnPetsRecord.petPhoto,
                                'https://post.medicalnewstoday.com/wp-content/uploads/sites/3/2020/02/322868_1100-800x825.jpg',
                              )),
                              
                            
                            ),
                            )
                          );
                          
                        }));
                      
                        },
                        itemCount: columnPetsRecordList.length,
                        viewportFraction: 0.6,
                        scale: 0.8,
                      );
                        
                  
                  
                  
                  
                  
                  
                 
                    }
                  )
                )]
            ),
            
            Padding(
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
            ),
          ],
          )
        ),
      ),
    );
      },
    );
  }
}


class CategorySelectionList extends StatelessWidget {
  CategorySelectionList({
    Key key,
  }) : super(key: key);
  List<String> categories = ['Dogs', 'Cats', 'Rabbits', 'Birds', 'Reptiles'];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      scrollDirection: Axis.horizontal,
      itemCount: categories.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          margin: EdgeInsets.only(right: 25.0),
          child: Text(
            categories[index],
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 22,
            ),
          ),
        );
      },
    );
  }
}