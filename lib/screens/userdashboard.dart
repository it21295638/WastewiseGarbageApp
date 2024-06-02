import 'package:appnew/screens/category.dart';
import 'package:appnew/screens/login_screen.dart';
import 'package:flutter/material.dart';

class UserDashboard extends StatelessWidget {
  const UserDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: const Color.fromARGB(255, 255, 255, 255)),
      body: Container(
          // color: Colors.lightGreen,
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Hello,',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const Text(
              'What can we do for you?',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 25), // Add spacing between text and GridView
            Expanded(
              child: GridView.count(
                crossAxisCount: 2, // Two columns in the grid
                mainAxisSpacing: 10.0, // Spacing between items vertically
                crossAxisSpacing: 10.0, // Spacing between items horizontally
                padding: const EdgeInsets.all(10.0), // Padding around the grid
                children: [
                  buildGridItem('Shedule a pickup', Icons.access_alarm, () {
                    // Handle click for item 1
                  }),
                  buildGridItem('View service request', Icons.access_time, () {
                    // Handle click for item 2
                  }),
                  buildGridItem('Exchange items', Icons.accessibility, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Category()),
                    );
                    // Handle click for item 3
                  }),
                  buildGridItem('Account', Icons.account_balance, () {
                    // Handle click for item 4
                  }),
                  buildGridItem('Sorting guidance', Icons.account_circle, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }

  Widget buildGridItem(String title, IconData icon, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      child: Card(
        color: Colors.lightGreen,
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40.0),
            const SizedBox(height: 12.0),
            Text(title, style: const TextStyle(fontSize: 12.0)),
          ],
        ),
      ),
    );
  }
}
