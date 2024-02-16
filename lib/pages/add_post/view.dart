import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Post Screen',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: PostScreen(),
    );
  }
}

class PostScreen extends StatefulWidget {
  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post'),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            // Handle back action
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.wifi),
            onPressed: () {
              // Handle wifi action
            },
          ),
          IconButton(
            icon: Icon(Icons.battery_full),
            onPressed: () {
              // Handle battery action
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                // Handle add photo action
              },
              child: Container(
                height: 200,
                color: Colors.black12,
                child: Icon(Icons.add_photo_alternate, size: 50),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Category',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Price (optional)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              maxLines: 6,
              decoration: InputDecoration(
                labelText: 'Description',
                alignLabelWithHint: true,
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                OutlinedButton(
                  child: Text('Save draft'),
                  onPressed: () {
                    // Handle save draft action
                  },
                ),
                ElevatedButton(
                  child: Text('Publish'),
                  onPressed: () {
                    // Handle publish action
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
