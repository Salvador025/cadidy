import 'package:flutter/material.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 1
                )
              ),
              child: ListTile(
                leading: Icon(Icons.account_circle),
                title: Text('My Profile'),
                trailing: Icon(Icons.arrow_forward_ios_rounded),
                onTap: () {
              
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 1
                )
              ),
              child: ListTile(
              leading: Icon(Icons.contact_phone_rounded),
              title: Text('Contact us'),
              trailing: Icon(Icons.arrow_forward_ios_rounded),
              onTap: () {
            
                },
              )
            ),
            Container(
              padding: const EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 1
                )
              ),
              child: ListTile(
              leading: Icon(Icons.work_rounded),
              title: Text('Become a worker'),
              trailing: Icon(Icons.arrow_forward_ios_rounded),
              onTap: () {
            
                },
              )
            ),
            Container(
              padding: const EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 1
                )
              ),
              child: ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              trailing: Icon(Icons.arrow_forward_ios_rounded),
              onTap: () {
            
                },
              )
            ),
          ],
    );
  }
}