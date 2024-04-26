

import 'package:flutter/material.dart';

import '../DatabaseHelper.dart';
import 'dart:convert';

class UserData {
  final String name;
  final String contact;
  final String email;

  UserData({
    required this.name,
    required this.contact,
    required this.email,
  });
}
class RegisterUser  extends StatefulWidget {
  @override
  _DatabaseListViewState createState() =>  _DatabaseListViewState();
}


class _DatabaseListViewState extends State<RegisterUser> {
  List<UserData>? _items;

  @override
  void initState() {
    super.initState();
    _fetchItems();
  }

  Future<void> _fetchItems() async {
    List<UserData>  studentData=await DatabaseHelper.instance.getallUser();
    setState(() {
      _items = studentData;
    });
  }

  void removeItem(int index) {
    setState(() {
      _items?.removeAt(index); // Remove item at the specified index
    });
  }



  void showDataInputDialog(BuildContext context) {
    String field1 = '';
    String field2 = '';
    String field3 = '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Enter Data'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  field1 = value;
                },
                decoration: InputDecoration(labelText: 'Field 1'),
              ),
              TextField(
                onChanged: (value) {
                  field2 = value;
                },
                decoration: InputDecoration(labelText: 'Field 2'),
              ),
              TextField(
                onChanged: (value) {
                  field3 = value;
                },
                decoration: InputDecoration(labelText: 'Field 3'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Save data to database
                _saveData(field1, field2, field3);
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }


  void _saveData(String field1, String field2, String field3) {
    // Implement your database saving logic here
    print('Field 1: $field1');
    print('Field 2: $field2');
    print('Field 3: $field3');
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register  User'),
      ),


      body: ListView.builder(
        itemCount: _items!.length,
        itemBuilder: (context, index) {
          return ItemWidget(item: _items![index], onTap:(){ removeItem(index);},update:(){showDataInputDialog(context);});
        },
      ),
    );
  }




}

class ItemWidget extends StatelessWidget {
  final  UserData item;
  final void Function() onTap;
  final void Function() update;
  const ItemWidget({Key? key, required this.item, required  this.onTap,required this.update}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(item.name),
            Text(' Name: ${item.name}'),
            Text('Contact: ${item.contact}'),
            Text('Email: ${item.email}'),
          ],
        ),

        trailing:Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {

                onTap();
                await DatabaseHelper.instance.deleteUser(item.contact);

              },
            ),
            IconButton(
              icon: Icon(Icons.update),
              onPressed: () async {
                update();

              },
            ),


          ],
        )


      ),
    );
  }
}