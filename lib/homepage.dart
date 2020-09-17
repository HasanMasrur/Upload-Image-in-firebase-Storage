import 'package:flutter/material.dart';

class HomePagelist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Text("added picture"),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Upload pic'),
              onTap: () {
                return Navigator.pushReplacementNamed(context, '/imagepage');
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Homepage'),
      ),
      body: Container(
          // height: MediaQuery.of(context).size.height * .20,
          ),
    );
  }
}
