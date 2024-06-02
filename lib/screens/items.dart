import 'package:appnew/screens/postitems_screen.dart';
import 'package:flutter/material.dart';

class ItemsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Items'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ItemRow(
                      imageUrl: 'assets/nike1.jpeg',
                      description: 'Description 1'),
                  SizedBox(height: 30), // Add bigger space between rows
                  ItemRow(
                      imageUrl: 'assets/nike2.jpeg',
                      description: 'Description 2'),
                  SizedBox(height: 30), // Add bigger space between rows
                  ItemRow(
                      imageUrl: 'assets/nike3.jpeg',
                      description: 'Description 3'),
                  Spacer(), // Add spacer to push items to the top
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(
                20.0, 0, 20.0, 20.0), // Adjust padding
            child: ElevatedButton(
              onPressed: () {
                // Navigate to PostItems screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PostItems(
                            collectionName: '',
                          )),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 15.0), // Adjust button padding
                child: Text('Post Your Items'),
              ),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.lightGreen, // Set text color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ItemRow extends StatelessWidget {
  final String imageUrl;
  final String description;

  const ItemRow({
    Key? key,
    required this.imageUrl,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Container(
              width: 100, // Adjust the width as needed
              height: 100, // Adjust the height as needed
              child: Image.asset(
                imageUrl,
                fit: BoxFit.cover, // Adjust the fit of the image
              ),
            ),
          ),
        ),
        SizedBox(width: 10), // Add space between the buttons and the image
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                description,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Add functionality for email button
                      },
                      child: Text('Phone'),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.lightGreen, // Set text color
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Add functionality for location button
                      },
                      child: Text('Location'),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.lightGreen, // Set text color
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
