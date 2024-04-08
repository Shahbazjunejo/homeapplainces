import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: PageView(
                children: <Widget>[
                  _buildPageContent(
                    context,
                    image: 'assets/images/image1.jpg',
                    title: 'Have a problem?',
                    subtitle: 'Don’t worry, let’s get started.',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/LoginScreen');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow, // Background color
                padding: const EdgeInsets.all(14.0),
              ),

              child: const Text('Get Started',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.blue
                ),),
            ),
            const SizedBox(height: 20),
            // Add your page indicators here
          ],
        ),
      ),
    );
  }

  Widget _buildPageContent(BuildContext context,
      {required String image, required String title, required String subtitle}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset('assets/images/image1.jpg'), // Replace with your asset image path
        const SizedBox(height: 20),
        Text(
          title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.blue, // Color for title text
          ),
        ),
        const SizedBox(height: 10),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.grey, // Color for subtitle text
          ),
        ),
      ],
    );
  }
}