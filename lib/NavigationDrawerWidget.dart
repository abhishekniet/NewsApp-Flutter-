import 'dart:ui';

import 'home.dart';
import 'model.dart';
import 'main.dart';
import 'package:flutter/material.dart';

class NavigationDrawerWidget extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 20);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.red,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            arrowColor: Colors.green,
            accountName: Text("HITESH"),
            accountEmail: Text("hitesh@gmail.com"),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset(
                  "Images/tree.jpg",
                  width: 90,
                  height: 50,
                ),
              ),
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("Images/tree.jpg"),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text(
              "Favourites",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            onTap: () => print("Tapping Favourites"),
          ),
          ListTile(
            leading: Icon(Icons.people),
            title: Text(
              "Friends",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            onTap: () => print("Tapping Favourites"),
            hoverColor: Colors.white,
          ),
          ListTile(
            leading: Icon(Icons.share),
            title: Text(
              "Share",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            onTap: () => print("Tapping Favourites"),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text(
              "Settings",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            onTap: () => print("Tapping Favourites"),
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text(
              "Exit",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            onTap: () => print("Tapping Favourites"),
          ),
        ],
      ),
    );
  }
}
