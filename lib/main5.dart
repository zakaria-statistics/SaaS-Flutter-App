import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // Create a GlobalKey for the MyAppState
  final GlobalKey<MyAppState> _appKey = GlobalKey<MyAppState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GlobalKey Theme Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyAppWrapper(appKey: _appKey),
    );
  }
}

class MyAppWrapper extends StatefulWidget {
  final GlobalKey<MyAppState> appKey;

  MyAppWrapper({required this.appKey}) : super(key: appKey);

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyAppWrapper> {
  ThemeData _themeData = ThemeData.light();

  void changeTheme(ThemeData themeData) {
    setState(() {
      _themeData = themeData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GlobalKey Theme Demo',
      theme: _themeData,
      home: HomeScreen(appKey: widget.appKey),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final GlobalKey<MyAppState> appKey;

  HomeScreen({required this.appKey});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ThemeScreen(appKey: appKey),
                  ),
                );
              },
              child: Text('Go to Theme Screen'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                appKey.currentState?.changeTheme(ThemeData.light());
              },
              child: Text('Set Light Theme'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                appKey.currentState?.changeTheme(ThemeData.dark());
              },
              child: Text('Set Dark Theme'),
            ),
          ],
        ),
      ),
    );
  }
}

class ThemeScreen extends StatelessWidget {
  final GlobalKey<MyAppState> appKey;

  ThemeScreen({required this.appKey});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Theme Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                appKey.currentState?.changeTheme(ThemeData.light());
                Navigator.pop(context);
              },
              child: Text('Set Light Theme'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                appKey.currentState?.changeTheme(ThemeData.dark());
                Navigator.pop(context);
              },
              child: Text('Set Dark Theme'),
            ),
          ],
        ),
      ),
    );
  }
}
