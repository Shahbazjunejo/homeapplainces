import 'package:flutter/material.dart';

import 'DatabaseHelper.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController? username,password,fullname,emailaddress,phonenumber = TextEditingController();

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
            const Text("Start Your Journey with Us!",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.normal,
              ),
            ),
            const SizedBox(height: 30,),
         //   _buildTextField(hint: 'Username',username),
            const SizedBox(height: 20,),
            _buildTextField(hint: 'Password', obscureText: true),
            const SizedBox(height: 20,),
            _buildTextField(hint: 'Full name'),
            const SizedBox(height: 20,),
            _buildTextField(hint: 'Email address'),
            const SizedBox(height: 20,),
            _buildTextField(hint: 'Phone number'),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                // Handle sign up logic
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Background color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14.0),
              ),
              child: const Text('Start', style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),),
            ),
            const SizedBox(
              height: 30,
            ),
            const Center(
              child: Text(
                "Already Have an Account?",
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/LoginScreen');
                },
                child: const Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.blue,
                  ),
                ))
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
