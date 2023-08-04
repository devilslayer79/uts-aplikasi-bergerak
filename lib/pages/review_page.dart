import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../const.dart';

class Review {
  final String name;
  final String description;

  Review({required this.name, required this.description});
}

class ReviewPage extends StatefulWidget {
  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  final List<Review> reviews = []; // List to store reviews

  // Text editing controllers for name and review text fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController reviewController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchDataFromApi();
  }

  // Method to fetch data from the Strapi API
  void fetchDataFromApi() async {
    final apiUrl = "http://localhost:1337/api/reviews";
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        List<Review> fetchedReviews = [];
        for (var item in data['data']) {
          String name = item['attributes']['name'] ?? ''; // Handle null value
          String description =
              item['attributes']['Description'] ?? ''; // Handle null value
          fetchedReviews.add(Review(name: name, description: description));
        }
        setState(() {
          reviews.addAll(fetchedReviews);
        });
      } else {
        // Handle error if API call fails
        print('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      // Handle error if an exception occurs
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            Text(
              "Reviews",
              style: TextStyle(
                fontSize: 20,
                color: textColor,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: reviews.length,
                itemBuilder: (context, index) {
                  Review review = reviews[index];
                  return ListTile(
                    title: Text(review.name),
                    subtitle: Text(review.description),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: "Name",
                    ),
                    onChanged: (value) {
                      // You can store the name value here if needed
                    },
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: reviewController,
                    decoration: InputDecoration(
                      labelText: "Review",
                    ),
                    onChanged: (value) {
                      // You can store the review value here if needed
                    },
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text("Add Review"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
