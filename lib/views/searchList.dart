import 'package:flutter/material.dart';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../models/contact.dart';
import '../viewModels/appViewModel.dart';
import 'contactDetails.dart';
import 'editContactWithImage.dart';

class SearchList extends StatefulWidget {

   SearchList({this.searchList,super.key});

  List<Contact>? searchList;

  @override
  State<SearchList> createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  Constants constants=Constants();


  @override
  Widget build(BuildContext context) {
    return Consumer<AppViewModel>(builder: (context,viewModel,child){
      return ListView.builder(
          itemCount: widget.searchList!.length,
          itemBuilder: (context,index){
            // return Text(searchList![index].firstName);
            return ListTile(
              onTap: (){
                setState(() {
                  Contact myContact=widget.searchList![index];
                  int myIndex=viewModel.getContactIndex(myContact);
                  print("xxx==$myIndex");
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context)=>ContactDetails(contactIndex: myIndex))

                  );

                });
              },
              leading: setProfileImage(widget.searchList![index].image,index),
              title: Text(widget.searchList![index].firstName,style: TextStyle(fontWeight:FontWeight.w700)),
              subtitle: Text(widget.searchList![index].phone),

            );

          }
      );

    });
  }


Widget setProfileImage(String image,int index){
  return ( image.toString() != "null" ) ?
  // Text("yes ${viewModel.getContactImage(index).toString()}") : Text("no"),
  CircleAvatar(
    radius:35,
    backgroundImage:FileImage(File( image )) ,
  ):
  CircleAvatar(
    radius:35,
    backgroundColor: constants.primaryColor,
    // child: Text(viewModel.getContactName(index)[0],style: TextStyle(fontSize: 22,color: Colors.white),),
    child: Text(widget.searchList![index].firstName[0].toUpperCase(),style: TextStyle(fontSize: 22,color: Colors.white),),
  )

  ;
}
}
