import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:tree_detection/aerial/aerial_output.dart';
import 'package:tree_detection/services/device_endpoint_config.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

void _pickImage(BuildContext context, ImageSource source, String route) async {
  // Show loading spinner
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Center(
        child: CircularProgressIndicator(),
      );
    },
  );

  var ipadd = await getEndPoint();
  var url = Uri.parse("http://$ipadd:8081/$route");
  final picker = await ImagePicker();

  final XFile? img = await picker.pickImage(
    source: source, // alternatively, use ImageSource.gallery
    maxWidth: 400,
  );
  if (img != null) {
    // Prepare the image file to be sent
    var request = http.MultipartRequest('POST', url);

    // Attach the image file to the request
    request.files.add(await http.MultipartFile.fromPath('image', img.path));

    // Send the request
    var response = await request.send();

    // Check the response status
    if (response.statusCode == 200) {
      // Hide loading spinner
      Navigator.of(context).pop();
      print('Image uploaded successfully');

      // Decode the response body
      var responseBody = await response.stream.bytesToString();
      var jsonResponse = json.decode(responseBody);

      // Print individual fields from the JSON response
      print('Image URL: ${jsonResponse['ImageUrl']}');
      print('Description: ${jsonResponse['Description']}');

      String type = "";
      if (route == "aerial") {
        type = "Aerial";
      } else {
        type = "Ground";
      }
      // Navigate to ImagePage with imageUrl and description
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ImagePage(
            imageUrl: jsonResponse['ImageUrl'],
            description: jsonResponse['Description'],
            type: type,
          ),
        ),
      );
    } else {
      // Hide loading spinner
      Navigator.of(context).pop();
      print('Failed to upload image. Error: ${response.reasonPhrase}');
    }
  } else {
    // Hide loading spinner
    Navigator.of(context).pop();
  }
}

class _DashboardPageState extends State<DashboardPage> {
  File? _selected_image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard",
            style: GoogleFonts.audiowide(color: Colors.black)),
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green,
        centerTitle: true,
        leading: Image.asset(
          'images/tree.png',
          height: 65,
          width: 65,
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back,
              )),
        ],
      ),
      backgroundColor: Colors.green[100],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 90,
              backgroundColor: Colors.transparent,
              backgroundImage: AssetImage('images/tree.png'),
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 50,
              width: 250,
              child: ElevatedButton(
                onPressed: () {
                  _pickImage(context, ImageSource.gallery,
                      "aerial"); // Upload photo from gallery
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(10), // Button border radius
                  ),
                ),
                child: Text('Upload Aerial Image',
                    style: GoogleFonts.audiowide(fontSize: 15)),
              ),
            ),
            SizedBox(height: 25),
            SizedBox(
              height: 50,
              width: 250,
              child: ElevatedButton(
                onPressed: () {
                  _pickImage(context, ImageSource.gallery,
                      "ground"); // Take a photo using the camera
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(10), // Button border radius
                  ),
                ),
                child: Text('Upload Ground Image',
                    style: GoogleFonts.audiowide(fontSize: 15)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
