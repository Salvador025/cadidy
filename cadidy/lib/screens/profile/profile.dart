import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'edit_info.dart';
import 'edit_photo.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map<String, dynamic>? userData;
  File? _localImage;

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _loadLocalImage();
  }

  Future<void> _loadUserData() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      final doc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (doc.exists) {
        setState(() {
          userData = doc.data();
        });
      }
    }
  }

  Future<void> _loadLocalImage() async {
    final appDir = await getApplicationDocumentsDirectory();
    final localPath = '${appDir.path}/profile_photo.jpg';
    final file = File(localPath);
    if (await file.exists()) {
      setState(() {
        _localImage = file;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (userData == null) {
      return const Scaffold(
        backgroundColor: Color.fromARGB(255, 63, 59, 55),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final String name = userData!["name"] ?? "";
    final String email = userData!["email"] ?? "";
    final String phone = userData!["phone"] ?? "";
    final String gender = userData!["gender"] ?? "Not specified";
    final String address = userData!["adress"] ?? "";

    ImageProvider profileImageProvider = _localImage != null
        ? FileImage(_localImage!)
        : const AssetImage('assets/images/profile_placeholder.png');

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 88, 82, 76),
      ),
      backgroundColor: const Color.fromARGB(255, 63, 59, 55),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 170, 126, 74),
                    Color.fromARGB(255, 134, 98, 54),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: profileImageProvider,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 4,
                        child: GestureDetector(
                          onTap: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const EditPhotoPage()),
                            );
                            await _loadLocalImage();
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            padding: const EdgeInsets.all(6),
                            child: const Icon(Icons.edit,
                                size: 16, color: Colors.purple),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    name,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(email, style: const TextStyle(color: Colors.white70)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 107, 96, 85),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ListView(
                  padding: const EdgeInsets.all(8),
                  children: [
                    _buildListTile(context, Icons.person_outline, 'Name', name,
                        () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                EditInfoPage(title: 'Edit Name', info: name)),
                      );
                      await _loadUserData();
                    }),
                    _buildListTile(
                        context, Icons.email_outlined, 'Email', email,
                        () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                EditInfoPage(title: 'Edit Email', info: email)),
                      );
                      await _loadUserData();
                    }),
                    _buildListTile(
                        context, Icons.phone_outlined, 'Contact', phone,
                        () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditInfoPage(
                                title: 'Edit Contact', info: phone)),
                      );
                      await _loadUserData();
                    }),
                    _buildListTile(
                        context, Icons.transgender_outlined, 'Gender', gender,
                        () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditInfoPage(
                                title: 'Edit Gender', info: gender)),
                      );
                      await _loadUserData();
                    }),
                    _buildListTile(
                        context, Icons.location_on_outlined, 'Address', address,
                        () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditInfoPage(
                                title: 'Edit Address', info: address)),
                      );
                      await _loadUserData();
                    }),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile(BuildContext context, IconData icon, String label,
      String value, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: const Color.fromARGB(255, 170, 126, 74)),
      title: Text(label, style: const TextStyle(color: Colors.white)),
      subtitle: Text(value, style: const TextStyle(color: Colors.white)),
      trailing: const Icon(Icons.arrow_forward_ios_rounded,
          size: 16, color: Colors.white),
      onTap: onTap,
    );
  }
}
