import 'dart:io';

import 'package:contact_app/viewModels/appViewModel.dart';
import 'package:contact_app/views/editContactWithImage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../models/contact.dart';
import '../widgets/floatingActionButton.dart';
import 'ContactListViewBuilder.dart';
import 'package:contact_app/views/searchList.dart';

class ContactListWithSearch extends StatefulWidget {
  const ContactListWithSearch({super.key});

  @override
  State<ContactListWithSearch> createState() => _ContactListWithSearchState();
}

class _ContactListWithSearchState extends State<ContactListWithSearch> {
  Widget appBarTitle =  Text("Contacts");
  Icon actionIcon =  Icon(Icons.search);
  late List<Contact> allContacts;
  String? img;
  String? firstLetter;
  Constants constants=Constants();
  String? searchTxt;
  TextEditingController searchController = TextEditingController();

  List<Contact>? myList;
  List<Contact>? searchList;
  List? searchListIndex=[];

  String? _query;
  bool isSearching=false;
  Map<int,Contact>? contactwithIndex;
  int? currentIndex;


  @override
  Widget build(BuildContext context) {

    return Consumer<AppViewModel>(builder: (context,viewModel,child){
      myList=viewModel.contactList;

      return Scaffold(
          appBar: AppBar(
              centerTitle: false,
              backgroundColor:constants.primaryColor ,
              title:appBarTitle,
              actions: <Widget>[
                IconButton(icon: actionIcon,
                  onPressed:(){
                    setState(() {
                      if ( actionIcon.icon == Icons.close){
                        isSearching=false;
                      }
                      if ( actionIcon.icon == Icons.search){
                        actionIcon =  Icon(Icons.close);
                        appBarTitle =
                            TextField(
                              controller: searchController,
                              //****************************
                              onChanged:(value){
                                setState(() {
                                  _query=value;
                                  search(value);


                                });
                              } ,
                              //****************************

                              style:  TextStyle(
                                color: Colors.white,
                              ),
                              decoration:  InputDecoration(
                                prefixIcon:  Icon(Icons.search,color: Colors.white),
                                hintText: "Search...",
                                hintStyle:  TextStyle(color: Colors.white),
                              ),
                            );
                      }
                      else {
                        this.actionIcon = new Icon(Icons.search);
                        this.appBarTitle = new Text("Contacts");
                      }
                    });
                  } ,),]
          ),


          body: isSearching?
          SearchList(searchList:searchList,):
          ContactListViewBuilder(),

          floatingActionButton: MYFloatingActionButton()
      );
    });
  }

  AppBar buildAppBarWithSearch(Constants constants) {
    return AppBar(
      centerTitle: false,
      backgroundColor:constants.primaryColor ,
      title:Text("Contacts") ,
      actions: [
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {  },
              icon: Icon(Icons.search),
            )
        )
      ],
    );
  }

  void deleteItem(index){

  }



  void search(value){
    setState(() {
      searchList=myList!.where((contact) => contact.firstName.toLowerCase().contains(value.toLowerCase()))
          .toList();

      currentIndex=myList!.indexWhere((contact) => contact.firstName.toLowerCase().contains(value.toLowerCase()));
      // print("xxx==$currentIndex");

      if(searchList!.length != 0){
        isSearching=true;

      }

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
      child: Text(searchList![index].firstName[0].toUpperCase(),style: TextStyle(fontSize: 22,color: Colors.white),),
    )

    ;
  }
}
