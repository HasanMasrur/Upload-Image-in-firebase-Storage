import 'package:ImageUpload/homepage.dart';
import 'package:ImageUpload/imageuploadpage.dart';
import 'package:ImageUpload/model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(HomePage());
}

// class HomePage extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return _HomePage();
//   }
// }

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return Modelclass();
      },
      child: MaterialApp(
        routes: {
          '/': (BuildContext context) => HomePagelist(),
          '/imagepage': (BuildContext context) => ImageUploadPage(),
        },
      ),
    );
  }
}
