import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:petbook/home_page/home_page_widget.dart';

import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../backend/firebase_storage/storage.dart';
import '../petbook/petbook_icon_button.dart';
import '../petbook/petbook_theme.dart';
import '../petbook/petbook_util.dart';
import '../petbook/petbook_widgets.dart';
import '../petbook/upload_media.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:age_calculator/age_calculator.dart';

class CreatePetProfileNewWidget extends StatefulWidget {
  const CreatePetProfileNewWidget({Key key}) : super(key: key);

  @override
  _CreatePetProfileNewWidgetState createState() =>
      _CreatePetProfileNewWidgetState();
}

class _CreatePetProfileNewWidgetState extends State<CreatePetProfileNewWidget> {
  String uploadedFileUrl = '';
  TextEditingController petNameController;
  TextEditingController petTypeController;
  TextEditingController petBreedController;
  //TextEditingController petAgeController;
  TextEditingController petWeightController;
  List<bool> isSelected = [false, false];
  List<bool> isSelectedGender = [false, false];
  String petType;
  String petGender;
  DateTime _dateTime;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    //petAgeController = TextEditingController();
    petBreedController = TextEditingController();
    petNameController = TextEditingController();
    petTypeController = TextEditingController();
    petWeightController = TextEditingController();
    petType = "N/a";
    petGender = "N/a";
  }

  calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age;
  }

  int currentStep = 0;
  int age = -1;
  String getAge;

  DateTime date = DateTime(2008, 12, 22);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: PetbookTheme.of(context).tertiaryColor,
        automaticallyImplyLeading: false,
        title: Text(
          'Add a Pet',
          style: PetbookTheme.of(context).title1,
        ),
        leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_rounded,
              size: 32,
              color: Colors.black,
            ),
            onPressed: () {
              ZoomDrawer.of(context).toggle();
            },
          ),
        
        centerTitle: false,
        elevation: 0,
      ),
      backgroundColor: PetbookTheme.of(context).tertiaryColor,
      body: Theme(
        data: Theme.of(context).copyWith(
                 
          colorScheme: ColorScheme.light(
            primary: PetbookTheme.of(context).primaryColor
          )
        ),
        child: SafeArea(
        child: Stepper(
          type: StepperType.vertical,
          steps: getSteps(),
          currentStep: currentStep,
          onStepContinue: () async {
            final isLastStep = currentStep == getSteps().length - 1;
            if(isLastStep) {
              print('completed');
              final petsCreateData = createPetsRecordData(
                userAssociation: currentUserReference,
                petPhoto: uploadedFileUrl,
                petName: petNameController.text,
                petType: petType,
                petBreed: petBreedController.text,
                petAge: age.toString(),
                petWeight: petWeightController.text,
                petGender: petGender
                
              );
              await PetsRecord.collection.doc().set(petsCreateData);
              await Navigator.of(context).pop;
              /*await Navigator.push(context,
              MaterialPageRoute(
                builder: (context) => HomePageWidget(),
              ));*/
            }
            else {
              setState(() {
              currentStep += 1;
            });
            }
            
          },
          onStepCancel: currentStep == 0 ? null : () => setState(() => currentStep -= 1),
          onStepTapped: (step) => setState(() => currentStep = step),
        )
      ),
      )
    );
  }

   List<Step> getSteps() => [
     Step(
       state: currentStep > 0 ? StepState.complete : StepState.indexed,
       title: Text('Name'),
       isActive: currentStep >= 0,
       content: Container(
         child: TextFormField(
            controller: petNameController,
            obscureText: false,
            decoration: InputDecoration(
              labelText: 'Pet\'s Name',
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
        
       )
     ),
     Step(
       state: currentStep > 1 ? StepState.complete : StepState.indexed,
       title: Text('General Info'),
       isActive: currentStep >= 1,
       content: Container(
         alignment: Alignment.centerLeft,
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           mainAxisAlignment: MainAxisAlignment.start,
           children: <Widget>[
            Text("What kind of pet do you have?", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            SizedBox(height: 15),
            ToggleButtons(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(30),
                  child: Column(children: [
                    Image.asset("assets/images/dog.png", width: 60),
                    SizedBox(height: 15),
                    Text("Dog"),

                  ],)
                ),
                Padding(
                  padding: EdgeInsets.all(30),
                  child: Column(children: [
                    Image.asset("assets/images/cat.png", width: 60),
                    SizedBox(height: 15),
                    Text("Cat")
                  ],)
                ),
                
              ],
              onPressed: (int index) {
                setState(() {
                  for (int buttonIndex = 0; buttonIndex < isSelected.length; buttonIndex++) {
                    if (buttonIndex == index) {
                      isSelected[buttonIndex] = !isSelected[buttonIndex];
                    } else {
                      isSelected[buttonIndex] = false;
                    }
                  }
                  if(index == 0)
                    petType = "Dog";
                  else if(index == 1)
                    petType = "Cat";
                  else
                    petType = "N/A";
                  //index == 0 ? petType = "Dog" : petType = "Cat";
                  //print(petType);
                });
              },
              isSelected: isSelected,
            ),
            SizedBox(height: 15),
            Text("What is its breed?", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            TextFormField(
              controller: petBreedController,
              obscureText: false,
              decoration: InputDecoration(
                labelText: 'Pet\'s Breed',
                labelStyle: TextStyle(color: Color.fromARGB(255, 132, 132, 132)),
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
              style: TextStyle(color: Color.fromARGB(255, 255, 0, 0),)
            ),
            SizedBox(height: 15),
            Text("What is their gender?", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            SizedBox(height: 15),
            ToggleButtons(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(30),
                  child: Column(children: [
                    Image.asset("assets/images/male.png", width: 60),
                    SizedBox(height: 15),
                    Text("Male")
                  ],)
                ),
                Padding(
                  padding: EdgeInsets.all(30),
                  child: Column(children: [
                    Image.asset("assets/images/female.png", width: 60),
                    SizedBox(height: 15),
                    Text("Female")
                  ],)
                ),
                
              ],
              onPressed: (int index) {
                setState(() {
                  for (int buttonIndex = 0; buttonIndex < isSelectedGender.length; buttonIndex++) {
                    if (buttonIndex == index) {
                      isSelectedGender[buttonIndex] = !isSelectedGender[buttonIndex];
                    } else {
                      isSelectedGender[buttonIndex] = false;
                    }
                  }

                  if(index == 0)
                    petGender = "Male";
                  else if(index == 1)
                    petGender = "Female";
                  else
                    petGender = "N/A";

                  //index == 0 ? petGender = "Male" : petGender = "Female";
                  //print(petType);
                  //print(petGender);
                  
                });
              },
              isSelected: isSelectedGender,
            ),
            SizedBox(height: 15),
            Text("How much does it weigh?", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            TextFormField(
              controller: petWeightController,
              obscureText: false,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Pet\'s Weight (lbs)',
                labelStyle: TextStyle(color: Color.fromARGB(255, 132, 132, 132)),
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
              style: TextStyle(color: Color.fromARGB(255, 255, 0, 0),)
            ),
         ],)
       )
     ),
     Step(
       state: currentStep > 2 ? StepState.complete : StepState.indexed,
       title: Text('Birthday'),
       isActive: currentStep >= 2,
       content: Container(
         alignment: Alignment.centerLeft,
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           mainAxisAlignment: MainAxisAlignment.start,
           children: <Widget>[
            Text("When was your pet born?", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            SizedBox(height: 15),
            Row(children: [
               GestureDetector(
              onTap: () async {
                DateTime newDate = await showDatePicker(
                  context: context,
                  initialDate: date,
                  firstDate: DateTime(1990),
                  lastDate: DateTime.now(),
                );
                if(newDate == null) return;

                setState(() {
                  date = newDate;
                });

                this.age = calculateAge(newDate);

                getAge = age.toString();
              },
              child: Icon(
                Icons.calendar_month_rounded,
              )
            ),
            
            Text('${date.month}/${date.day}/${date.year}, age: $age'),
            
            ],)
            
           ],
        )
       )
     ),
     Step(
       state: currentStep > 3 ? StepState.complete : StepState.indexed,
       title: Text('Photo'),
       isActive: currentStep >= 3,
       content: Container(
         child: Column(children: [
           Container(
              width: MediaQuery.of(context).size.width * 0.6,
              height: 200,
              decoration: BoxDecoration(
                //color: PetbookTheme.of(context).gray200,
                image: DecorationImage(
  
                  fit: BoxFit.contain,
                  image: Image.asset(
                    'assets/images/add_photo.png',
                  ).image,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: InkWell(
                onTap: () async {
                  final selectedMedia =
                      await selectMediaWithSourceBottomSheet(
                    context: context,
                    allowPhoto: true,
                  );
                  if (selectedMedia != null &&
                      validateFileFormat(
                          selectedMedia.storagePath, context)) {
                    showUploadMessage(
                      context,
                      'Uploading file...',
                      showLoading: true,
                    );
                    final downloadUrl = await uploadData(
                        selectedMedia.storagePath, selectedMedia.bytes);
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    if (downloadUrl != null) {
                      setState(() => uploadedFileUrl = downloadUrl);
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
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    uploadedFileUrl,
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
           
           SizedBox(height: 10),
           Text("Tap to Upload a Photo", style: TextStyle(fontSize: 16)),
           SizedBox(height: 30)

         ],)
       )
     ),
     Step(
       title: Text('Review'),
       isActive: currentStep >= 4,
       content: Container(
         alignment: Alignment.centerLeft,
         child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
           Row(
             children: [
               Text("Name: ", style: TextStyle(fontWeight: FontWeight.bold)),
               Text(petNameController.text)
             ],
           ),
           SizedBox(height:10),
           Row(
             children: [
               Text("Type: ", style: TextStyle(fontWeight: FontWeight.bold)),
               Text(petType)
             ],
           ),
           SizedBox(height:10),
           Row(
             children: [
               Text("Breed: ", style: TextStyle(fontWeight: FontWeight.bold)),
               Text(petBreedController.text)
             ],
           ),
           SizedBox(height:10),
           Row(
             children: [
               Text("Gender: ", style: TextStyle(fontWeight: FontWeight.bold)),
               Text(petGender)
             ],
           ),
           SizedBox(height:10),
           Row(
             children: [
               Text("Weight: ", style: TextStyle(fontWeight: FontWeight.bold)),
               Text(petWeightController.text)
             ],
           ),
           SizedBox(height:10),
           Row(
             children: [
               Text("Age: ", style: TextStyle(fontWeight: FontWeight.bold)),
               Text(age.toString())
             ],
           ),
           SizedBox(height:10),
           Text("You can edit any of these details later!")

         ],)
       )
     )
   ];
}

