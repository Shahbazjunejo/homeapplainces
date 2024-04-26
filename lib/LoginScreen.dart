import 'package:flutter/material.dart';

import 'DatabaseHelper.dart';

class LoginScreen extends StatelessWidget {
   LoginScreen({super.key});

  final TextEditingController email = TextEditingController();
  final TextEditingController password= TextEditingController();
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
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Hello again!',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Please login to your account',
              style: TextStyle(color: Colors.grey[700]),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            TextFormField(
              controller: email,
              decoration: InputDecoration(
                labelText: 'Email',
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: password,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Login',
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    // Handle 'Remember me'
                  },
                  child: const Text('Remember me'),
                ),
                TextButton(
                  onPressed: () {
                    // Handle 'Forgot password?'
                  },
                  child: const Text('Forgot password?'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if(email.text.isNotEmpty&&email.text=="admin"&&password.text.isNotEmpty&&password.text=="admin"){
                  Navigator.of(context).pushNamed('/ServiceProvider');
                }
               loginUser(email.text, password.text, context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Let\'s start!',
                style: TextStyle(fontSize: 16,
                    color: Colors.white),
              ),
            ),
            const SizedBox(height: 30,),
            const Center(
              child: Text(
                "Didn't Have an Account?",
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/SignupScreen');
                },
                child: const Text(
                  "Signup",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.blue,
                  ),
                )),
          ],
        ),
      ),
    );
  }

  void loginUser(String useremail, String password,BuildContext context) async {
    Map<String, dynamic>? user = await DatabaseHelper.instance.getUser(useremail);
    if (user != null && user[DatabaseHelper.columnPassword] == password) {
      // Login successful
      Navigator.of(context).pushNamed('/HomeScreen',arguments: user);
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Login failed'),
            content: Text('Wrong username or password'),
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
      print('Login failed');
    }
  }


}

