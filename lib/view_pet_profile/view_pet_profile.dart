import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petbook/auth/auth_util.dart';
import 'package:petbook/backend/backend.dart';
import 'package:petbook/petbook/petbook_theme.dart';
import 'package:petbook/petbook/petbook_util.dart';

// ignore: must_be_immutable
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
  bool isFavorite = false;

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
    final size = MediaQuery.of(context).size;
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
          body: Stack(
            children: [
              Column(
                children: [
                  
                  Expanded(
                      child: CachedNetworkImage(
                          imageUrl:
                              valueOrDefault<String>(
                              ViewPetProfilePetsRecord.petPhoto,
                              'https://post.medicalnewstoday.com/wp-content/uploads/sites/3/2020/02/322868_1100-800x825.jpg',
                            ),
                            
                            fit: BoxFit.cover,
                          ),
                      ),
                      
                  SizedBox(height: size.height / 2.5, width: size.width)
                ],
              ),
              DraggableScrollableSheet(
                snap: true,
                initialChildSize: 0.5,
                minChildSize: 0.5,
                maxChildSize: 1.0,
                builder: (BuildContext context, scrollController) {
                  return Container(
                    padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                    decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topRight: Radius.circular(45), topLeft: Radius.circular(45)), color: PetbookTheme.of(context).tertiaryColor),
                    child: ListView(
                      controller: scrollController,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                valueOrDefault<String>(
                                  ViewPetProfilePetsRecord.petName,
                                  'pet name',
                                ),
                                //textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                )
                              ),
                              Spacer(),
                              GestureDetector(
                                onTap: () {},
                                child: Icon(
                                  Icons.qr_code_2_rounded,
                                  size: 28,
                                )
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Icon(
                                  Icons.edit_rounded,
                                  size: 28,
                                )
                              )
                              
                              
                          
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Beagle',
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                valueOrDefault<String>(
                                  ViewPetProfilePetsRecord.petAge,
                                  '14 years old',
                                ),
                                //textAlign: TextAlign.start,
                                
                              ),
                          
                              SizedBox(
                                width: 20,
                              ),
                              Text('13.72 Kg'),
                            ],
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          StreamBuilder<UsersRecord>(
                                  stream: UsersRecord.getDocument(currentUserReference),
                                  builder: (context, snapshot) {
                                  final profilePageUsersRecord = snapshot.data;
                          return Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  Text(valueOrDefault<String>(
                                          profilePageUsersRecord.displayName,
                                          '',
                                        ),
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                  )),
                                  Text('Owner',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300,
                                      )),
                                ],
                              ),
                              Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Orlando',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold, )           
                                  ),
                                  Text('Location',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300,
                                      )),
                                ],
                              ),
                              Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(valueOrDefault<String>(
                                          profilePageUsersRecord.phoneNumber,
                                          ''),
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold, )           
                                  ),
                                  Text('Phone Number',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300,
                                      )),
                                ],
                              ),
                              
                          ],
                        );
                        }),
                        SizedBox(
                          height: 20,
                        ),
                        
                        Divider(),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Timeline',
                          //textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          )
                        ),
                        
                      ],
                    ),
                      ],
                    )
                  );
                }
              )
              
            
            ],
          ),
        );
      });
    
  }
}