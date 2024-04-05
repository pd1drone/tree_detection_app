import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ImagePage extends StatefulWidget {
  final String imageUrl;
  final String description;
  final String type;

  ImagePage(
      {required this.imageUrl, required this.description, required this.type});

  @override
  _ImagePageState createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.type} Image Output',
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
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 50),
            Image.network(
              widget.imageUrl,
              width: 350,
              height: 350,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            Text(
              widget.description,
              style: GoogleFonts.audiowide(color: Colors.black, fontSize: 20),
              textAlign: TextAlign.center,
            ),
            // SizedBox(height: 20),
            // ElevatedButton(
            //   onPressed: _saveImageToDevice,
            //   child: Text('Save Image'),
            // ),
          ],
        ),
      ),
    );
  }

  // Future<void> _saveImageToDevice() async {
  //   // Implement the logic to save the image to the device's gallery
  // }
}
