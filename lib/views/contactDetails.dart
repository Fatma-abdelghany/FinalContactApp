import 'dart:io';

import 'package:contact_app/constants.dart';
import 'package:contact_app/views/editContactWithImage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewModels/appViewModel.dart';
class ContactDetails extends StatelessWidget {

  int contactIndex;
   ContactDetails({required this.contactIndex,super.key});

  Constants constants = Constants();

  @override
  Widget build(BuildContext context) {
    return Consumer<AppViewModel>(builder: (context, viewModel, child)
    {
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: constants.primaryColor,
          actions: [
            IconButton(onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context)=>EditContactWithImage(selectedContact: contactIndex,))

              );
            }, icon: Icon(Icons.edit)),
          ],
        ),
        body: Column(
          children: [
            Container(
              width: double.infinity,
              height: 250,
              color: constants.primaryColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  setProfileImage(viewModel,contactIndex),
                  SizedBox(height: 20,),
                  Text(viewModel.getContactName(contactIndex),style: TextStyle(fontSize:30, fontWeight:FontWeight.w700,color: Colors.white)),
                  SizedBox(height: 20,),


                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount:1,
                padding: EdgeInsets.all(10),
                itemBuilder: (BuildContext context, int index) {

                  return Card(
                    child: ListTile(
                      leading: Icon(Icons.call,color: constants.primaryColor,),
                      title: Text(viewModel.getContactPhone(contactIndex),style: TextStyle(fontWeight:FontWeight.w500,color: Colors.grey[500])),
                      // subtitle: Text("telephone"),


                    ),
                  );

                } ,

              ),
            )
          ],
        ),

      );
    });
  }

  Widget setProfileImage(AppViewModel viewModel,int index){
    String profileImagepath=viewModel.getContactImage(index);
    print("before set  =======$profileImagepath");
    return ( profileImagepath != "null" ) ?
    CircleAvatar(
      radius:55,
      backgroundImage:FileImage(File( profileImagepath!)) ,
    ):
    Icon(Icons.person, size: 150, color: Colors.white,);

  }
}
