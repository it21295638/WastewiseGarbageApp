import 'package:flutter/material.dart';
import 'package:appnew/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditUserProfile extends StatefulWidget {
  final UserModel loggedInUser;

  const EditUserProfile({Key? key, required this.loggedInUser})
      : super(key: key);

  @override
  _EditUserProfileState createState() => _EditUserProfileState();
}

class _EditUserProfileState extends State<EditUserProfile> {
  late TextEditingController _firstNameController;
  late TextEditingController _secondNameController;
  late TextEditingController _emailController;
  late TextEditingController _addressController;

  @override
  void initState() {
    super.initState();
    _firstNameController =
        TextEditingController(text: widget.loggedInUser.firstName);
    _secondNameController =
        TextEditingController(text: widget.loggedInUser.secondName);
    _emailController = TextEditingController(text: widget.loggedInUser.email);
    _addressController =
        TextEditingController(text: widget.loggedInUser.address);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.greenAccent),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 120,
                      child: Image.asset(
                        "assets/logo1.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(height: 45),
                    TextFormField(
                      controller: _firstNameController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.account_circle),
                        labelText: 'First Name',
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _secondNameController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.account_circle),
                        labelText: 'Second Name',
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.mail),
                        labelText: 'Email',
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _addressController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.location_on),
                        labelText: 'Address',
                      ),
                    ),
                    SizedBox(height: 35),
                    ElevatedButton(
                      onPressed: () {
                        _updateUserProfile();
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        backgroundColor: Colors.greenAccent, // Corrected line
                        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                        minimumSize: Size(MediaQuery.of(context).size.width, 0),
                      ),
                      child: Text(
                        'Save Changes',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _updateUserProfile() async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(widget.loggedInUser.uid)
          .update({
        "firstName": _firstNameController.text,
        "secondName": _secondNameController.text,
        "email": _emailController.text,
        "address": _addressController.text,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile updated successfully')),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update profile')),
      );
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _secondNameController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    super.dispose();
  }
}
