import 'dart:io';

import 'package:flutter/material.dart';

import 'home_screen.dart';
import 'login_screen.dart';

class TipsScreen extends StatefulWidget {
  final File image;
  const TipsScreen({super.key, required this.image});

  @override
  State<TipsScreen> createState() => _TipsScreenState();
}

class _TipsScreenState extends State<TipsScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/bg2.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Results & Tips',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.grey.withOpacity(0.35),
          elevation: 0,
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.black
                      .withOpacity(0.75), // Set the background color
                ),
                child: Image.asset(
                  'assets/images/t_logo.png',
                  fit: BoxFit.cover,
                ),
              ),
              ListTile(
                leading: const Icon(
                  Icons.home,
                  color: Colors.black,
                ),
                title: const Text('Home'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()));
                  // Add navigation logic for the Home page here
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(
                  Icons.info,
                  color: Colors.black,
                ),
                title: const Text('About Us'),
                onTap: () {
                  // Add navigation logic for the About Us page here
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(
                  Icons.contact_mail,
                  color: Colors.black,
                ),
                title: const Text('Contact Us'),
                onTap: () {
                  // Add navigation logic for the Contact Us page here
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(
                  Icons.logout,
                  color: Colors.black,
                ),
                title: const Text('Logout'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
                  // Add logout logic here
                },
              ),
            ],
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Container(
                height: size.height * 0.45,
                width: size.width * 0.95,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.white,
                    width: 2.5,
                  ),
                ),
                child: Image.file(
                  widget.image,
                  alignment: Alignment.center,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Card(
              elevation: 5,
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.all(size.height * 0.015),
                child: Text(
                  'Imbalanced',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: size.height * 0.02,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: size.width * 0.05,
                right: size.width * 0.05,
                top: size.height * 0.01,
                bottom: size.height * 0.02,
              ),
              child: RichText(
                textAlign: TextAlign.justify,
                softWrap: true,
                text: TextSpan(
                  style: TextStyle(
                    fontSize: size.height * 0.02,
                    color: Colors.white,
                  ),
                  children: [
                    const TextSpan(
                        text: 'Tips for Improving Muscle Balance:\n\n',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(
                      text:
                          '1. Maintain a Balanced Diet: Consume a variety of foods rich in protein, vitamins, and minerals to support muscle health.\n\n',
                      style: TextStyle(
                        fontSize: size.height * 0.015,
                      ),
                    ),
                    TextSpan(
                      text:
                          '2. Regular Exercise: Incorporate a mix of strength and flexibility exercises to target all muscle groups.\n\n',
                      style: TextStyle(
                        fontSize: size.height * 0.015,
                      ),
                    ),
                    TextSpan(
                      text:
                          '3. Stay Hydrated: Proper hydration is essential for muscle function and recovery.\n\n',
                      style: TextStyle(
                        fontSize: size.height * 0.015,
                      ),
                    ),
                    TextSpan(
                      text:
                          '4. Consult a Professional: If you have concerns about muscle imbalances, seek guidance from a fitness expert or physical therapist.\n',
                      style: TextStyle(
                        fontSize: size.height * 0.015,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
