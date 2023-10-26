import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../entities/strings_manager.dart';
import '../models/contact.dart';
import '../viewModels/appViewModel.dart';
import '../widgets/customTextField.dart';

class EditContactWithImage extends StatefulWidget {

   EditContactWithImage({required this.selectedContact,super.key});
  int selectedContact;

  @override
  State<EditContactWithImage> createState() => _EditContactWithImageState();
}

class _EditContactWithImageState extends State<EditContactWithImage> {
  XFile? _imageFile;
  String? profileImagepath;


  final ImagePicker _picker = ImagePicker();

  Constants constants = Constants();

  final myFormKey = GlobalKey<FormState>();

  TextEditingController secondNameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController companyController = TextEditingController();
  TextEditingController webController = TextEditingController();

  String? firstName;
  String? lastName;
  String? phone;
  String? email;
  String? company;
  String? webSite;


  Contact? myContact;


  @override
  Widget build(BuildContext context) {


    return Consumer<AppViewModel>(builder: (context, viewModel, child) {

 //==============================************************==============
      getContact(viewModel,widget.selectedContact);
 //==============================************************==============

      return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: constants.primaryColor,
          title: Text(AppStrings.newContact),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                  onPressed: () async {

                    setState(() {
                      firstName=firstNameController.text;
                      lastName=lastNameController.text;
                      phone=phoneController.text;
                      email=emailController.text;
                      company=companyController.text;
                      webSite=webController.text;
                      print("before save =======$profileImagepath");

                      myContact=Contact(
                          firstName: firstName!,
                          lastName: lastName!,
                          phone: phone!,
                          email: email!,
                          image: profileImagepath!.toString(),
                          company: company!,
                          web:webSite!);
                      viewModel.updateContact(myContact!,context,widget.selectedContact);
                    });



                    // final prefs = await SharedPreferences.getInstance();
                    // prefs.setBool('isFirstTime', false); // You might want to save this on a callback.


                  },
                  child: Text(AppStrings.save, style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w700),)),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Form(
              key: myFormKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [

  // =======================**************************************************
                    setProfileImage(viewModel,widget.selectedContact),
 //=======================**************************************************


                    SizedBox(height: 40,),
                    CustomTextField(
                      icon: Icons.person,
                      autovalidate: true,
                      controller: firstNameController,
                      type: TextInputType.text,
                      hint: AppStrings.firstNameHint,
                      validate: (v) {
                        if (v!.isEmpty || v == null) {
                          return AppStrings.firstNameRequired;
                        }
                      },
                    ),


                    SizedBox(height: 20,),
                    CustomTextField(
                        icon: Icons.person,
                        autovalidate: false,
                        controller: lastNameController,
                        type: TextInputType.text,
                        hint: AppStrings.lastNameHint,
                        validate: (v) {}),
                    SizedBox(height: 40,),
                    CustomTextField(
                      autovalidate: false,
                      icon: Icons.work,
                      controller: companyController,
                      type: TextInputType.text,
                      hint: AppStrings.compHint,
                      validate: (val) {

                      },
                    ),
                    SizedBox(height: 20,),
                    CustomTextField(
                      autovalidate: true,
                      icon: Icons.call,
                      controller: phoneController,
                      type: TextInputType.phone,
                      hint: AppStrings.phoneHint,
                      validate: (Phone) {
                        if (Phone.isEmpty || Phone == null) {
                          return AppStrings.mobileNoIsRequired;
                        }
                      },
                    ),

                    SizedBox(height: 20,),

                    CustomTextField(
                      icon: Icons.mail,
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      hint: AppStrings.emailHint,
                      autovalidate: true,
                      validate: (Email) {
                        // if (Email.isEmpty || Email == null) {
                        //   Email.isValidEmail() ? null : "Check your email";
                        // }
                      },
                    ),
                    SizedBox(height: 40,),
                    CustomTextField(
                      autovalidate: false,
                      icon: Icons.web,
                      controller: webController,
                      type: TextInputType.text,
                      hint: AppStrings.webHint,
                      validate: (val) {

                      },
                    ),


                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
    );
  }

  void mySelectImage(AppViewModel viewModel,int index) async {
    XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    setState(() {
      _imageFile = pickedFile;
      profileImagepath = _imageFile!.path;
      viewModel.updateImage(index, profileImagepath!);

      print("after select Image =======$profileImagepath");

    });
  }


  void getContact(AppViewModel viewModel, int selectedContact) {
    Contact myContact = viewModel.getContactBYIndex(selectedContact);

    profileImagepath=myContact.image;
    print("first =======$profileImagepath");
    firstNameController.value = TextEditingValue(text: myContact.firstName);
    lastNameController.value = TextEditingValue(text: myContact.lastName);
    phoneController.value = TextEditingValue(text: myContact.phone);
    emailController.value = TextEditingValue(text: myContact.email);
    companyController.value = TextEditingValue(text: myContact.company);
    webController.value = TextEditingValue(text: myContact.web);
  }

  Widget setProfileImage(AppViewModel viewModel,int index){
    print("before set  =======$profileImagepath");
    return ( profileImagepath != "null" ) ?
    CircleAvatar(
      radius:55,
      backgroundImage:FileImage(File( profileImagepath!)) ,
    ):
    Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
          color: constants.primaryColor,
          shape: BoxShape.circle
      ),
      child: IconButton(
        onPressed: () {
          setState(() {
            mySelectImage(viewModel,index);

          });
        },
        icon: Icon(
          Icons.camera_alt, size: 40, color: Colors.white,),

      ),
    );

  }
}




