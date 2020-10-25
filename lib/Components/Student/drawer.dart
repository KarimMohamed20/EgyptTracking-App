import 'package:app/Controller/Auth/logout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StudentDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          // First Part
          _tile(text: 'Dashboard', icon: Icons.home, route: '/student/home'),
          Divider(
            color: Colors.grey[500],
          ),
          _tile(text: 'Profile', icon: Icons.person, route: '/student/profile'),
          _tile(
              icon: Icons.message, text: "Messages", route: '/student/messages'),
          Divider(
            color: Colors.grey[500],
          ),
          _tile(
              icon: Icons.bus_alert, text: "Ride", route: '/student/ride'),
          Divider(
            color: Colors.grey[500],
          ),
          // Third Part
          _tile(
              icon: Icons.notifications,
              route: '/student/notifications',
              text: 'Notifications'),
          _tile(
              icon: Icons.settings,
              route: '/student/settings',
              text: 'Settings'),
          Divider(
            color: Colors.grey[500],
          ),
          _tile(icon: Icons.logout, isLogout: true, text: 'Logout'),
        ],
      ),
    );
  }

  _tile({dynamic icon, String text, String route, bool isLogout = false}) {
    return ListTile(
      leading: icon.runtimeType == IconData
          ? Icon(
              icon,
              color: Colors.black,
              size: 20,
            )
          : Image.asset(
              'assets/images/$icon',
              color: Colors.black,
              width: 20,
              height: 20,
            ),
      title: Text(
        text,
      ),
      onTap: () async {
        if (isLogout == true) {
          await LogoutController().logOut();
        } else {
          Get.toNamed('$route');
        }
      },
    );
  }
}
