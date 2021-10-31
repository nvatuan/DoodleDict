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
                image: AssetImage('assets/logo.png'),
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
                TextSpan(
                  text: '     Home Page',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ]),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            },
          ),
          ListTile(
            title: RichText(
              text: const TextSpan(children: [
                WidgetSpan(child: Icon(Icons.history)),
                TextSpan(
                  text: '     History',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500),
                ),
              ]),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const History()),
              );
            },
          ),
          ListTile(
            title: RichText(
              text: const TextSpan(children: [
                WidgetSpan(child: Icon(Icons.info)),
                TextSpan(
                  text: '     Introduction',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ]),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const OnBoardingPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
