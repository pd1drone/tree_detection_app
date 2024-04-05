import 'package:flutter/material.dart';
import 'package:tree_detection/dashboard/dashboard.dart';
import 'package:tree_detection/home/homepage.dart';
import 'package:tree_detection/services/device_endpoint_config.dart';
import 'package:tree_detection/settings/device_config.dart';

Future<void> main() async {
  runApp(const MyApp());
  var endpoint = await getEndPoint();
  if (endpoint == "") {
    saveEndPoint("192.168.254.170");
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: HomePage(),
      routes: {
        'home': (context) => HomePage(),
        'configureip': (context) => DeviceConfigPage(),
        'dashboard': (context) => DashboardPage(),
      },
    );
  }
}
