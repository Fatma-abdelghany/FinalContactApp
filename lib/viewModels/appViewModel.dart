
import 'package:flutter/material.dart';

import '../models/contact.dart';
import '../views/contactsListWithSearch.dart';
class AppViewModel extends ChangeNotifier{

  List<Contact> contactList=<Contact>[];

  void addContact(Contact contact,BuildContext context ){
    contactList.add(contact);
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context)=>ContactListWithSearch())

    );
    notifyListeners();

  }
  void updateContact(Contact contact,BuildContext context,int index ){
    contactList[index]=contact;
    Navigator.of(context).pushReplacement(

       MaterialPageRoute(builder: (context)=>ContactListWithSearch())
    );
    notifyListeners();

  }
  void updateImage(int index ,String image){
    contactList[index].image=image;
    notifyListeners();

  }

  Contact getContactBYIndex(int index){
    return contactList[index];

  }

  int getContactIndex(Contact contact){
    int index=contactList.indexOf(contact);
    return index;

  }


  int get numContacts=>contactList.length;
  String getContactName(int index){
    return contactList[index].firstName;
  }
  String getContactPhone(int index){
    return contactList[index].phone;
  }
  String getContactImage(int index){
    return contactList[index].image;
  }
  void deleteContact(int index){
    contactList.removeAt(index);
    notifyListeners();
  }
  void updateContactList(List<Contact>? newContactList){
    contactList=newContactList!;
    notifyListeners();
  }
}