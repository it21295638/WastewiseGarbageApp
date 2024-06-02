import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:appnew/model/item_model.dart';

class PostItems extends StatefulWidget {
  final String collectionName;

  PostItems({required this.collectionName});

  @override
  _PostItemsState createState() => _PostItemsState();
}

class _PostItemsState extends State<PostItems> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late File _image = File('');
  final ImagePicker _picker = ImagePicker();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _locationController = TextEditingController();

  Future<void> getImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<String> uploadImageToStorage(File imageFile) async {
    try {
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('images/${DateTime.now().millisecondsSinceEpoch}');

      UploadTask uploadTask = storageReference.putFile(imageFile);

      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      print('Error uploading image: $e');
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Your Item'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 20),
                Text(
                  'Item Details',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: getImage,
                  child: Container(
                    height: 150,
                    color: Colors.grey[300],
                    child: _image.path.isEmpty
                        ? Center(
                            child: Icon(
                              Icons.photo,
                              size: 50,
                              color: Colors.grey,
                            ),
                          )
                        : Image.file(
                            _image,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _descriptionController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter description';
                    }
                    return null;
                  },
                  maxLines: null,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.lightGreen),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _phoneNumberController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter phone number';
                    }
                    final phoneRegex = RegExp(r'^[0-9]{10}$');
                    if (!phoneRegex.hasMatch(value)) {
                      return 'Please enter a valid phone number';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.lightGreen),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _locationController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please pick a location';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Location',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.lightGreen),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.location_on),
                      onPressed: () {
                        // Add location picker functionality here
                      },
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        String imageUrl = await uploadImageToStorage(_image);

                        Item newItem = Item(
                          imageUrl: imageUrl,
                          description: _descriptionController.text,
                          phoneNumber: _phoneNumberController.text,
                          location: _locationController.text,
                          approved: false, // Set to false by default
                        );

                        await FirebaseFirestore.instance
                            .collection(widget.collectionName)
                            .add(newItem.toMap());
                      } catch (e) {
                        print('Error adding item: $e');
                      }
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child:
                        Text('Add Item', style: TextStyle(color: Colors.white)),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    backgroundColor: Colors.lightGreen,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
