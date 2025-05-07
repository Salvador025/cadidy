import 'package:flutter/material.dart';
import 'edit_info.dart';
import 'edit_photo.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  final String userName = 'User Name';
  final String userEmail = 'example@example.com';
  final String userPhone = '+1 (555) 123-4567';
  final String userGender = 'Not specified';
  final String address =
      'ITESO, 8585, Anillo Periférico Sur Manuel Gómez Morín, Tlaquepaque, San Pedro Tlaquepaque, Región Centro, Jalisco, 45604, México';
  final String profileImage = 'assets/images/profile_placeholder.png';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 88, 82, 76),
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
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage(profileImage),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 4,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const EditPhotoPage()),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
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
                    userName,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    userEmail,
                    style: const TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 107, 96, 85),
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
                    _buildListTile(
                        context, Icons.person_outline, 'Name', userName, () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditInfoPage(
                            title: 'Edit Name',
                            info: userName,
                          ),
                        ),
                      );
                    }),
                    _buildListTile(
                        context, Icons.email_outlined, 'Email', userEmail, () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditInfoPage(
                            title: 'Edit Email',
                            info: userEmail,
                          ),
                        ),
                      );
                    }),
                    _buildListTile(
                        context, Icons.phone_outlined, 'Contact', userPhone,
                        () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditInfoPage(
                            title: 'Edit Contact',
                            info: userPhone,
                          ),
                        ),
                      );
                    }),
                    _buildListTile(context, Icons.transgender_outlined,
                        'Gender', userGender, () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditInfoPage(
                            title: 'Edit Gender',
                            info: userGender,
                          ),
                        ),
                      );
                    }),
                    _buildListTile(
                        context, Icons.location_on_outlined, 'Address', address,
                        () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditInfoPage(
                            title: 'Edit Address',
                            info: address,
                          ),
                        ),
                      );
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
      leading: Icon(
        icon,
        color: Color.fromARGB(255, 170, 126, 74),
      ),
      title: Text(
        label,
        style: TextStyle(color: Colors.white),
      ),
      subtitle: Text(value, style: const TextStyle(color: Colors.white)),
      trailing: const Icon(
        Icons.arrow_forward_ios_rounded,
        size: 16,
        color: Colors.white,
      ),
      onTap: onTap,
    );
  }
}
