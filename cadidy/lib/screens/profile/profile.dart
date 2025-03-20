import 'package:flutter/material.dart';
import 'edit_info.dart';
import 'edit_photo.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My profile'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile photo'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const EditPhotoPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Name'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EditInfoPage(
                    title: 'Edit Name',
                    info: 'Saddam Shadab',
                  ),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.email),
            title: const Text('Email'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EditInfoPage(
                    title: 'Edit Email',
                    info: 'example@example.com',
                  ),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.phone),
            title: const Text('Contact'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EditInfoPage(
                    title: 'Edit Contact',
                    info: '+92 3470967396',
                  ),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Gender'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EditInfoPage(
                    title: 'Edit Gender',
                    info: 'Male',
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}