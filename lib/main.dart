import 'package:flutter/material.dart';
import 'package:homeappliances/AddServiceProvider.dart';
import 'package:homeappliances/AddUser.dart';
import 'package:homeappliances/PaymentScreen.dart';
import 'package:homeappliances/RegisterUser.dart';
import 'package:homeappliances/ServiceInformation.dart';
import 'package:homeappliances/ServiceProvider.dart';
import 'package:homeappliances/Welcome%20Screen.dart';
import 'HomeScreen.dart';
import 'LoginScreen.dart';
import 'SearchScreen.dart';
import 'SignupScreen.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/WelcomeScreen': (context) => WelcomeScreen(),
        '/HomeScreen': (context) => HomeScreen(),
        '/LoginScreen': (context) => LoginScreen(),
        '/SignupScreen': (context) => SignupScreen(),
        '/SearchScreen': (context) => SearchScreen(),
        '/RegisterUser': (context) => RegisterUser(),
        '/ServiceProvider': (context) => ServiceProvider(),
        '/AddUser': (context) => AddUser(),
        '/AddServiceProvider': (context) => AddServiceProvider(),
        '/ServiceInformation': (context) => ServiceInformation(),
        '/PaymentScreen': (context) => PaymentScreen(),
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const WelcomeScreen(),
    );
  }
}


