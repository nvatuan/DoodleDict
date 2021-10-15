import 'package:flutter/material.dart';
import 'package:myapp/screens/home.dart';
import 'package:myapp/screens/intro.dart';
import 'package:myapp/screens/history.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(2),
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                fit: BoxFit.fitHeight,
                image: AssetImage('logo.png'),
              ),
            ),
            child: Text(
              "",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500),
            ),
          ),
          ListTile(
            title: RichText(
              text: const TextSpan(children: [
                WidgetSpan(child: Icon(Icons.home)),
                TextSpan(text: '     Home Page'),
              ]),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
          ),
          ListTile(
            title: RichText(
              text: const TextSpan(children: [
                WidgetSpan(child: Icon(Icons.history)),
                TextSpan(text: '     History'),
              ]),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => History()),
              );
            },
          ),
          ListTile(
            title: RichText(
              text: const TextSpan(children: [
                WidgetSpan(child: Icon(Icons.info)),
                TextSpan(text: '     Introduction'),
              ]),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => OnBoardingPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
