import 'package:flutter/material.dart';
import 'package:homeappliances/Services.dart';


class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

TextEditingController search = TextEditingController();

List<Services> servicesList = [
  Services(
    serviceName: 'House Cleaning',
    serviceCategory: 'Home',
    serviceProvider: 'Clean Co',
    serviceRating: '4.5',
    servicePrice: '100',
  ),
  Services(
    serviceName: 'House Renovation',
    serviceCategory: 'Home',
    serviceProvider: 'Clean Co',
    serviceRating: '4.5',
    servicePrice: '200',
  ),
  Services(
    serviceName: 'Plumbing Repair',
    serviceCategory: 'Maintenance',
    serviceProvider: 'Plumb Perfect',
    serviceRating: '4.8',
    servicePrice: '150',
  ),
  Services(
    serviceName: 'Interior Painting',
    serviceCategory: 'Renovation',
    serviceProvider: 'Paint Pros',
    serviceRating: '4.7',
    servicePrice: '200',
  ),
  Services(
    serviceName: 'Electrical Wiring',
    serviceCategory: 'Repair',
    serviceProvider: 'Electric Wizards',
    serviceRating: '4.9',
    servicePrice: '250',
  ),
  Services(
    serviceName: 'Lawn Mowing',
    serviceCategory: 'Gardening',
    serviceProvider: 'Green Thumb',
    serviceRating: '4.3',
    servicePrice: '75',
  ),
  Services(
    serviceName: 'Window Cleaning',
    serviceCategory: 'Home Care',
    serviceProvider: 'Clear View',
    serviceRating: '4.6',
    servicePrice: '80',
  ),
  Services(
    serviceName: 'Air Conditioning Fix',
    serviceCategory: 'HVAC',
    serviceProvider: 'Cool Comfort',
    serviceRating: '4.8',
    servicePrice: '220',
  )
];

class _SearchScreenState extends State<SearchScreen> {
  List<Services> filteredServicesList = []; // Added for filtered services

  @override
  void initState() {
    super.initState();
    // Initialize the filtered list with all services
    filteredServicesList = servicesList;
    // Add listener to search controller
    search.addListener(_filterServicesList);
  }

  void _filterServicesList() {
    String query = search.text.toLowerCase();
    setState(() {
      filteredServicesList = servicesList.where((service) {
        // Define the condition for filtering
        // Example: Check if service name contains the search query
        return service.serviceName.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            TextField(
              controller: search,
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
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: filteredServicesList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _buildServiceCard(filteredServicesList[index]),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildServiceCard(Services service) {
    // Build your service card using the service data
    return Container(
      width: 200, // Specify a width for your cards
      height: 150,
      decoration: BoxDecoration(
        color: Colors.white, // Placeholder color
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              service.serviceName,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(service.serviceCategory),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(service.serviceRating, style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.orange
                ),),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  "Rs.${service.servicePrice}",
                  style: const TextStyle(fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
