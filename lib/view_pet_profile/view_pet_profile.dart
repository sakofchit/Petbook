import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';

import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../backend/firebase_storage/storage.dart';
import '../edit_pet_profile/edit_pet_profile_widget.dart';
import '../petbook/petbook_icon_button.dart';
import '../petbook/petbook_theme.dart';
import '../petbook/petbook_util.dart';
import '../petbook/petbook_widgets.dart';
import '../petbook/upload_media.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewPetProfileWidget extends StatefulWidget {
  const ViewPetProfileWidget({
    Key key,
    this.petProfile,
  }) : super(key: key);

  final PetsRecord petProfile;

  @override
  _ViewPetProfileWidgetState createState() => _ViewPetProfileWidgetState();
}

class _ViewPetProfileWidgetState extends State<ViewPetProfileWidget> {
  String uploadedFileUrl = '';
  TextEditingController petNameController;
  TextEditingController dogBreedController;
  TextEditingController petAgeController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    petAgeController = TextEditingController(text: widget.petProfile.petAge);
    dogBreedController = TextEditingController(text: widget.petProfile.petType);
    petNameController = TextEditingController(text: widget.petProfile.petName);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PetsRecord>(
      stream: PetsRecord.getDocument(currentUserReference),
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
        final ViewPetProfilePetsRecord = snapshot.data;
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            backgroundColor: PetbookTheme.of(context).tertiaryColor,
            automaticallyImplyLeading: false,
            leading: PetbookIconButton(
              borderColor: Colors.transparent,
              borderRadius: 30,
              buttonSize: 46,
              icon: Icon(
                Icons.arrow_back_rounded,
                color: Colors.black,
                size: 24,
              ),
              onPressed: () async {
                final dogsUpdateData = createPetsRecordData(
                      petPhoto: uploadedFileUrl,
                      petName: petNameController.text,
                      petType: dogBreedController.text,
                      petAge: petAgeController.text,
                    );
                    await widget.petProfile.reference
                        .update(dogsUpdateData);
                Navigator.pop(context);
              },
            ),
            
            title: Text(
              "Preview",
              style: PetbookTheme.of(context).title2,
            ),
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 0),
                child: PetbookIconButton(
                icon: Icon(
                  Icons.qr_code_scanner_rounded,
                  color: PetbookTheme.of(context).primaryColor,
                  size: 30,
                ),
                onPressed: () async { },
              ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 10),
                child: PetbookIconButton(
                icon: Icon(
                  Icons.done_rounded,
                  color: PetbookTheme.of(context).primaryColor,
                  size: 30,
                ),
                onPressed: () async {
                    final dogsUpdateData = createPetsRecordData(
                      petPhoto: uploadedFileUrl,
                      petName: petNameController.text,
                      petType: dogBreedController.text,
                      petAge: petAgeController.text,
                    );
                    await widget.petProfile.reference
                        .update(dogsUpdateData);
                  },
              ),
              )
              
            ],
            centerTitle: false,
            elevation: 0,
          ),
          backgroundColor: PetbookTheme.of(context).tertiaryColor,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 5,
                                      color: PetbookTheme.of(context).primaryColor
                                      
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(8))
                                    
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        valueOrDefault<String>(
                                        ViewPetProfilePetsRecord.petPhoto,
                                        'https://post.medicalnewstoday.com/wp-content/uploads/sites/3/2020/02/322868_1100-800x825.jpg',
                                      ),
                                      width: 300,
                                      height: 300,
                                      fit: BoxFit.cover,
                                    ),
                                )
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 4, 16, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: petNameController,
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelText: 'Name',
                                  labelStyle:
                                      PetbookTheme.of(context).subtitle1,
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00000000),
                                      width: 1,
                                    ),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(4.0),
                                      topRight: Radius.circular(4.0),
                                    ),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00000000),
                                      width: 1,
                                    ),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(4.0),
                                      topRight: Radius.circular(4.0),
                                    ),
                                  ),
                                ),
                                style: PetbookTheme.of(context).title2,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                                child: TextFormField(
                                  controller: dogBreedController,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: 'Breed',
                                    labelStyle:
                                        PetbookTheme.of(context).bodyText1,
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1,
                                      ),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0),
                                      ),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1,
                                      ),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0),
                                      ),
                                    ),
                                  ),
                                  style: PetbookTheme.of(context).title3,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 4, 16, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: petAgeController,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: 'Age',
                                    labelStyle:
                                        PetbookTheme.of(context).bodyText1,
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1,
                                      ),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0),
                                      ),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1,
                                      ),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0),
                                      ),
                                    ),
                                  ),
                                  style: PetbookTheme.of(context).title3,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 4, 16, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            StreamBuilder<UsersRecord>(
                                stream: UsersRecord.getDocument(currentUserReference),
                                builder: (context, snapshot) {
                                final profilePageUsersRecord = snapshot.data;
                                return Expanded(
                                  child: Padding(
                                    padding:
                                        EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                                    child: Text(
                                      'Owner:' + valueOrDefault<String>(
                                        profilePageUsersRecord.displayName,
                                        '',
                                      ),
                                      textAlign: TextAlign.start,
                                      style:
                                          PetbookTheme.of(context).title3,
                                    ),
                                  ),
                                );
                                })
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )));
       });   
    }
  }