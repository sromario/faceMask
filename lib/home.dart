import 'screens/augmented_faces.dart';
import 'package:flutter/material.dart';
import 'screens/malha.dart';


class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ArCore Minitok'),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.amberAccent
        ), 
        child: ListView(
          children: <Widget>[
            ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AugmentedFacesScreen()));
              },
              title: Text("Filtros Faces"),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => FaceCoordinatesScreen()));
              },
              title: Text("Malha Faces"),
            ),
          ],
        ),
     )
    );
  }
}
