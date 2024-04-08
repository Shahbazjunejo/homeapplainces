import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const Icon(Icons.location_on, color: Colors.black),
        title: const Text(
          'Batumnggal, Indonesia',
          style: TextStyle(color: Colors.black),
        ),
        actions: const [CircleAvatar(
          child: Icon(Icons.person),
        )],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(40.0),
              child: Text(
                'What services do you need?',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search services',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: const Icon(Icons.filter_list),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Service category',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/SearchScreen');
                    },
                    child: const Text('See more'),
                  ),
                ],
              ),
            ),
            Container(
              height: 450,// Adjust height accordingly
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10, // The number of categories
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: _buildCategoryCard(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard() {
    // Placeholder for category card
    return Container(
        width: 300, // Adjust width accordingly
        decoration: BoxDecoration(
          color: Colors.yellow[200], // Placeholder color
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Container(
              height: 300,
              decoration: const BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                  image: AssetImage("assets/images/room.png"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const SizedBox(
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("House Renovation", style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.normal
                  ),)
                ],
              ),
            ),
          ],
        )
    );
  }
}

