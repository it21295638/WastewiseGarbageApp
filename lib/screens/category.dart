import 'package:flutter/material.dart';
import 'Cloth_items.dart';
import 'Home_Items.dart';
import 'Other_items.dart';

class Category extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ClothItems(collectionName: 'cloth_items')),
                );
              },
              child: SortingOption(
                label: 'Clothes',
                color: Colors.lightGreen,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          HomeItems(collectionName: 'home_items')),
                );
              },
              child: SortingOption(
                label: 'Home Items',
                color: Colors.lightGreen,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          OtherItems(collectionName: 'other_items')),
                );
              },
              child: SortingOption(
                label: 'Other',
                color: Colors.lightGreen,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SortingOption extends StatelessWidget {
  final String label;
  final Color color;

  const SortingOption({Key? key, required this.label, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: 300,
      height: 60,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
