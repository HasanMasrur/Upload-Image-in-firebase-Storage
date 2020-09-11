import 'package:ImageUpload/imageuploadpage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePage();
  }
}

class _HomePage extends State<HomePage> {
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return ImageUploadPage();
                }));
              },
            )
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
