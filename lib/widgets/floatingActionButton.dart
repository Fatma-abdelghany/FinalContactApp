import 'package:contact_app/views/addContactWithImg.dart';
import 'package:flutter/material.dart';

class MYFloatingActionButton extends StatelessWidget {
  bool addFromFirstScreen;
   MYFloatingActionButton({required this.addFromFirstScreen,super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.of(context).pushReplacement(
           // MaterialPageRoute(builder: (context)=>AddContact())
            MaterialPageRoute(builder: (context)=>AddContactWithImg(isFromFirstScreen: addFromFirstScreen,))
        );
      },
      child: Icon(Icons.add),
      backgroundColor:Color(0xff3f51b5) ,

    );
  }
}
