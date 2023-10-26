import 'dart:io';
import 'dart:math';

import 'package:contact_app/views/contactDetails.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../models/contact.dart';
import '../viewModels/appViewModel.dart';
import 'editContactWithImage.dart';
class ContactListViewBuilder extends StatefulWidget {
  const ContactListViewBuilder({super.key});

  @override
  State<ContactListViewBuilder> createState() => _ContactListViewBuilderState();
}

class _ContactListViewBuilderState extends State<ContactListViewBuilder> {
  Constants constants=Constants();

  @override
  Widget build(BuildContext context) {
    return Consumer<AppViewModel>(builder: (context,viewModel,child){
      return ListView.builder(

          itemCount: viewModel.numContacts,
          itemBuilder:(context,index){
            print("XXXXXXXXX${viewModel.getContactImage(index)}");
            // getImage(viewModel,index);
            return ListTile(
              onTap: (){
              setState(() {
                
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context)=>ContactDetails(contactIndex: index))

                );
                print("xxx==$index");

              });
            },

              leading: setProfileImage(viewModel, index),
              title: Text(viewModel.getContactName(index),style: TextStyle(fontWeight:FontWeight.w700)),
              subtitle: Text(viewModel.getContactPhone(index)),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      onPressed: (){
                        Navigator.of(context).push(
                          //MaterialPageRoute(builder: (context)=>EditProfile(selectedContact: index,))
                            MaterialPageRoute(builder: (context)=>EditContactWithImage(selectedContact: index,))
                        );
                      }, icon: Icon(Icons.edit)),
                  IconButton(onPressed: (){
                    setState(() {
                      viewModel.deleteContact(index);
                    });
                  }, icon: Icon(Icons.delete)),

                ],
              ),
            );
          }

      );
    });
  }
  Widget setProfileImage(AppViewModel viewModel,int index){
    return ( viewModel.getContactImage(index).toString() != "null" ) ?
    // Text("yes ${viewModel.getContactImage(index).toString()}") : Text("no"),
    CircleAvatar(
      radius:35,
      backgroundImage:FileImage(File( viewModel.getContactImage(index) )) ,
    ):
    CircleAvatar(
      radius:35,
        backgroundColor: Colors.primaries[Random().nextInt(Colors.primaries.length)],
      // backgroundColor: constants.primaryColor,
      child: Text(viewModel.getContactName(index)[0].toUpperCase(),style: TextStyle(fontSize: 22,color: Colors.white),),
    )

    ;
  }
}

