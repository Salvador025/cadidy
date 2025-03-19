import 'package:cadidy/Providers/notification_provider.dart';
import 'package:cadidy/widgets/notifications_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Notifications extends StatelessWidget {
  const Notifications({super.key});

  @override
  Widget build(BuildContext context) {
    bool hasNotifications;
    return Consumer<NotificationProvider>(
      builder: (context, value, child) {
        hasNotifications = value.notification;
        if (hasNotifications) {
          return Scaffold(
            appBar: AppBar(
              title: Center(
                child: Text('Notifications', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
              ),
              backgroundColor: Colors.grey[350],
              toolbarHeight: 100,
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: NotificationsDrawer()),
                  ElevatedButton(
                    onPressed: () {
                      context.read<NotificationProvider>().setNotification(false);
                    },
                    child: Icon(Icons.turned_in, color: Colors.black),
                  )
                ],
              ),
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: Center(
                child: Text('Notifications', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
              ),
              backgroundColor: Colors.grey[350],
              toolbarHeight: 100,
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.notifications_off, size: 100),
                  Text(
                    'No Notifications Yet',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Text('You have no notifications right now.\nCome back later.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.read<NotificationProvider>().setNotification(true);
                    },
                    child: Icon(Icons.turned_in, color: Colors.black),
                  )
                ],
              ),
            ),
          );
        }
      },
    );
  }
}