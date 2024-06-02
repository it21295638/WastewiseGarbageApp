import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:appnew/screens/login_screen.dart';

class DeleteUserProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Delete Profile"),
      content: Text("Do you really want to delete the profile?"),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text("Cancel"),
        ),
        TextButton(
          onPressed: () async {
            try {
              // Delete the user profile from Firestore
              User? user = FirebaseAuth.instance.currentUser;
              await FirebaseFirestore.instance
                  .collection("users")
                  .doc(user!.uid)
                  .delete();
              await user.delete(); // Delete the user from Firebase Auth
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) =>
                      LoginScreen())); // Navigate to login screen

              // Show success message using a SnackBar
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Profile deleted successfully')),
              );
            } catch (error) {
              // Show error message if profile deletion fails
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Profile not deleted')),
              );
            }
          },
          child: Text("Delete"),
        ),
      ],
    );
  }
}
