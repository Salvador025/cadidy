import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditPhotoPage extends StatefulWidget {
  const EditPhotoPage({super.key});

  @override
  State<EditPhotoPage> createState() => _EditPhotoPageState();
}

class _EditPhotoPageState extends State<EditPhotoPage> {
  File? _imageFile;
  bool _uploading = false;

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadImage() async {
    if (_imageFile == null) return;
    setState(() {
      _uploading = true;
    });
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid == null) return;

      final ref =
          FirebaseStorage.instance.ref().child('profile_photos/$uid.jpg');
      await ref.putFile(_imageFile!);

      final imageUrl = await ref.getDownloadURL();
      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'profilePicture': imageUrl,
      });

      if (context.mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      print('Error uploading image: $e');
    } finally {
      setState(() {
        _uploading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Photo'),
        backgroundColor: const Color.fromARGB(255, 88, 82, 76),
        actions: [
          TextButton(
            onPressed:
                (_imageFile != null && !_uploading) ? _uploadImage : null,
            child: const Text(
              'Save',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 63, 59, 55),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: _imageFile != null
                        ? FileImage(_imageFile!)
                        : const AssetImage(
                                'assets/images/profile_placeholder.png')
                            as ImageProvider,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.edit,
                          size: 20, color: Colors.purple),
                      onPressed: () => _pickImage(ImageSource.gallery),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 170, 126, 74),
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onPressed: () => _pickImage(ImageSource.gallery),
              icon: const Icon(Icons.photo),
              label: const Text('Choose from Gallery'),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 170, 126, 74),
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onPressed: () => _pickImage(ImageSource.camera),
              icon: const Icon(Icons.camera_alt),
              label: const Text('Take Photo'),
            ),
            const SizedBox(height: 20),
            if (_uploading)
              const CircularProgressIndicator(color: Colors.white),
          ],
        ),
      ),
    );
  }
}
