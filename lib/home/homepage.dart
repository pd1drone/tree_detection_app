import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tree_detection/services/device_endpoint_config.dart';

// DateTime lastTemperatureNotificationTime = DateTime(2018);
// DateTime lastFrontNotificationTime= DateTime(2018);
// DateTime lastRearNotificationTime= DateTime(2018);
// DateTime lastRightNotificationTime= DateTime(2018);
// DateTime lastLeftNotificationTime= DateTime(2018);
// int id = 0;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> _handleConnect() async {
    var ipadd = await getEndPoint();
    var url = Uri.parse("http://$ipadd:8081/check");
    print(url);

    try {
      print("try");
      final response = await http.get(url, headers: {
        'Access-Control-Allow-Origin': "*",
        'Content-Type': "application/json",
      }).timeout(const Duration(seconds: 2));

      if (response.statusCode == 200) {
        // Timer.periodic(Duration(seconds: 1), (Timer timer) {
        //     GetSensorValues();
        // });
        Navigator.of(context)
            .pushNamed("dashboard")
            .then((_) => setState(() {}));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Please enter the correct IP and connect to the device first before going to the dashboard',
                style:
                    GoogleFonts.audiowide(color: Colors.white, fontSize: 15)),
            duration: Duration(seconds: 3),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red,
          ),
        );
      }
    } on SocketException catch (e) {
      print("catch");
      print('Error fetching data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Please enter the correct IP and connect to the device first before going to the dashboard',
              style: GoogleFonts.audiowide(color: Colors.white, fontSize: 15)),
          duration: Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
        ),
      );
    } catch (e) {
      print('Error fetching data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Please enter the correct IP and connect to the device first before going to the dashboard',
              style: GoogleFonts.audiowide(color: Colors.white, fontSize: 15)),
          duration: Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'PicTree',
              style: GoogleFonts.audiowide(color: Colors.black, fontSize: 72),
            ),
            SizedBox(
              height: 140,
              child: Image.asset(
                'images/tree.png', // Replace 'your_image.png' with the path to your image file
                height: 100, // Adjust the height as needed
                width: 100, // Adjust the width as needed
              ),
            ),
            SizedBox(
              height: 50,
              width: 250,
              child: ElevatedButton(
                onPressed: () {
                  //Navigator.of(context).pushNamed("dashboard").then((_) => setState(() {}));
                  _handleConnect();
                },
                child: Text('Dashboard',
                    style: GoogleFonts.audiowide(
                        color: Colors.black, fontSize: 18)),
              ),
            ),
            SizedBox(height: 16),
            SizedBox(
              height: 50,
              width: 250,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed("configureip")
                      .then((_) => setState(() {}));
                },
                child: Text('Connect to Device',
                    style: GoogleFonts.audiowide(
                        color: Colors.black, fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
