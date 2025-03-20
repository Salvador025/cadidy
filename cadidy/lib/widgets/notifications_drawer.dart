import 'package:flutter/material.dart';

class NotificationsDrawer extends StatefulWidget {
  const NotificationsDrawer({super.key});

  @override
  State<NotificationsDrawer> createState() => _NotificationsDrawerState();
}

class _NotificationsDrawerState extends State<NotificationsDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20),
      child: ListView(
        children: [
          ListTile(
            title: Text('Notification 1'),
            subtitle: Text('This is the first notification'),
            leading: Icon(Icons.notifications_active),
          )
        ],
      ),
    );
  }
}