import 'package:flutter/material.dart';

void main() {
  runApp(const ArchieBell());
}

class ArchieBell extends StatelessWidget {
  const ArchieBell({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Archie Bell',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SimpleImageTextPage(),
    );
  }
}

class SimpleImageTextPage extends StatelessWidget {
  const SimpleImageTextPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Archie Bell'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Image Widget (Ensure the asset path is correct)
            Image.asset('images/placeholder-img.jpg', height: 200),
            
            const SizedBox(height: 20),

            // Text Widget
            const Text(
              'Name',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const Text(
              'Location last seen',
              style: TextStyle(fontSize: 15),
            ),

            const Text(
              'Time last seen',
              style: TextStyle(fontSize: 15),
            ),
        
            const Text(
              'Additional info',
              style: TextStyle(fontSize: 15),
            )
          ],
        ),
      ),
    );
  }
}
