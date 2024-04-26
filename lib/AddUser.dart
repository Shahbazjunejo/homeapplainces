import 'package:flutter/material.dart';

import 'DatabaseHelper.dart';

class AddUser extends StatelessWidget {
  AddUser({super.key});


  final TextEditingController username = TextEditingController();
  final TextEditingController password= TextEditingController();
  final TextEditingController fullname = TextEditingController();
  final TextEditingController emailaddress = TextEditingController();
  final TextEditingController phonenumber = TextEditingController();


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text("Add User",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.normal,
              ),
            ),
            const SizedBox(height: 30,),
            _buildTextField(hint: 'Username',controller: username),
            const SizedBox(height: 20,),
            _buildTextField(hint: 'Password', obscureText: true,controller: password),
            const SizedBox(height: 20,),
            _buildTextField(hint: 'Full name',controller: fullname),
            const SizedBox(height: 20,),
            _buildTextField(hint: 'Email address',controller: emailaddress),
            const SizedBox(height: 20,),
            _buildTextField(hint: 'Phone number',controller: phonenumber),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                registerUser( username!.text,password!.text,fullname!.text,emailaddress!.text,phonenumber!.text);
                username.clear();
                password.clear();
                fullname.clear();
                emailaddress.clear();
                phonenumber.clear();
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('User '),
                      content: Text('User has been Added'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Background color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14.0),
              ),
              child: const Text('Add User ', style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),),
            ),
            const SizedBox(
              height: 30,
            ),

          ],
        ),
      ),
    );
  }

  Widget _buildTextField({required String hint, bool obscureText = false, TextEditingController? controller}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
      ),
      obscureText: obscureText,
    );
  }

  void registerUser(String username, String password,String name,String email,String contact) async {
    int id = await DatabaseHelper.instance.insertUser({
      DatabaseHelper.columnName: username,
      DatabaseHelper.columnPassword: password,
      DatabaseHelper.Name:name,
      DatabaseHelper.columnemail :email,
      DatabaseHelper.columncontact:contact ,
    });
    if (id != null) {
      // Registration successful
      print('User registered successfully');
    } else {
      // Registration failed
      print('Failed to register user');
    }
  }


}
