import 'package:flutter/material.dart';
import 'package:mssql_connection/mssql_connection.dart';
import 'package:tooth_tech/screens/loginscreen.dart';
import 'package:tooth_tech/screens/registration.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late MssqlConnection mssqlConnection;

  @override
  void initState() {
    super.initState();
    _connectToDatabase();
  }

  void _connectToDatabase() async {
    mssqlConnection = MssqlConnection.getInstance();

    bool isConnected = await mssqlConnection.connect(
      ip: '192.168.60.19',
      port: '1433',
      databaseName: 'ToothTechDB',
      username: 'sa',
      password: 'cssh@12345',
      timeoutInSeconds: 15,
    );

    if (isConnected) {
      print('Connected to database');
    } else {
      print('Failed to connect to database');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToothTech',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: LoginScreen(mssqlConnection: mssqlConnection),
    );
  }
}
