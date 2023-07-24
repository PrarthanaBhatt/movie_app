import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class NetworkImageStorageExample extends StatelessWidget {
  // Function to download the image and store it in the database
  Future<void> downloadAndStoreImage() async {
    final imageUrl = 'https://example.com/your_network_image_url.jpg';
    final response = await http.get(Uri.parse(imageUrl));

    if (response.statusCode == 200) {
      // Convert the image to Uint8List
      final imageBytes = response.bodyBytes;

      // Store the imageBytes in the database
      await _storeImageInDatabase(imageBytes);
    } else {
      print('Failed to download the image.');
    }
  }

  // Function to store the Uint8List data in the database
  Future<void> _storeImageInDatabase(Uint8List imageBytes) async {
    // Get a reference to the database
    final databasePath = await getDatabasesPath();
    final database = await openDatabase(
      join(databasePath, 'your_database_name.db'),
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
            'CREATE TABLE IF NOT EXISTS images (id INTEGER PRIMARY KEY, image BLOB)');
      },
    );

    // Insert the imageBytes into the database
    await database.insert('images', {'image': imageBytes});

    // Close the database when you're done with it
    await database.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Network Image Storage')),
      body: Center(
        child: ElevatedButton(
          onPressed: downloadAndStoreImage,
          child: Text('Download and Store Image'),
        ),
      ),
    );
  }
}
