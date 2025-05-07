import 'package:cadidy/screens/hireService/services.dart';
import 'package:cadidy/screens/profile/profile.dart';
import 'package:cadidy/service/users_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MenuDrawer extends StatefulWidget {
  const MenuDrawer({super.key});

  @override
  State<MenuDrawer> createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {
  void _logoutDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            icon: Icon(Icons.logout, color: Colors.red, size: 50),
            title: Text('Come back soon!',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold)),
            content: Text('Are you sure you want\n to logout?',
                textAlign: TextAlign.center),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          onPressed: () async {
                            await FirebaseAuth.instance.signOut();
                            UsersService.uid = null;
                            Navigator.of(context).pop();
                            print('User logged out');
                          },
                          child: Text('Yes, Logout',
                              style: TextStyle(color: Colors.white))),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Cancel',
                              style: TextStyle(color: Colors.red))),
                    ],
                  ),
                ],
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 1),
            color: Color.fromARGB(255, 63, 59, 55),
          ),
          child: ListTile(
            leading: Icon(
              Icons.account_circle,
              color: Colors.white,
            ),
            title: Text(
              'My Profile',
              style: TextStyle(color: Colors.white),
            ),
            trailing:
                Icon(Icons.arrow_forward_ios_rounded, color: Colors.white),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfilePage()),
              );
            },
          ),
        ),
        Container(
            padding: const EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1),
              color: Color.fromARGB(255, 63, 59, 55),
            ),
            child: ListTile(
              leading: Icon(Icons.contact_phone_rounded, color: Colors.white),
              title: Text(
                'Contact us',
                style: TextStyle(color: Colors.white),
              ),
              trailing:
                  Icon(Icons.arrow_forward_ios_rounded, color: Colors.white),
              onTap: () {},
            )),
        Container(
            padding: const EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1),
              color: Color.fromARGB(255, 63, 59, 55),
            ),
            child: ListTile(
              leading: Icon(Icons.work_rounded, color: Colors.white),
              title: Text(
                'Hire a service',
                style: TextStyle(color: Colors.white),
              ),
              trailing:
                  Icon(Icons.arrow_forward_ios_rounded, color: Colors.white),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ServicesScreen(),
                  ),
                );
              },
            )),
        Container(
            padding: const EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1),
              color: Color.fromARGB(255, 63, 59, 55),
            ),
            child: ListTile(
              leading: Icon(Icons.logout, color: Colors.white),
              title: Text(
                'Logout',
                style: TextStyle(color: Colors.white),
              ),
              trailing:
                  Icon(Icons.arrow_forward_ios_rounded, color: Colors.white),
              onTap: () {
                _logoutDialog();
              },
            )),
      ],
    );
  }
}
