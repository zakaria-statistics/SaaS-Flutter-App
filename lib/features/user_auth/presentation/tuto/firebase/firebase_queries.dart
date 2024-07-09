import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyBZZNYh6IHjR1hQsbcJN44C3cYGkiX7tLg",
          authDomain: "firstapp-6a3b2.firebaseapp.com",
          projectId: "firstapp-6a3b2",
          storageBucket: "firstapp-6a3b2.appspot.com",
          messagingSenderId: "895108934473",
          appId: "1:895108934473:web:511aa7763d359bf3e94898",
          measurementId: "G-FEY8LE47TB"
        // Your web Firebase config options
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FirebaseQueries(),
    );
  }
}

class FirebaseQueries extends StatefulWidget {
  const FirebaseQueries({Key? key}) : super(key: key);

  @override
  _FirebaseQueriesState createState() => _FirebaseQueriesState();
}

class _FirebaseQueriesState extends State<FirebaseQueries> {

  int _counter = 0;
  var _collection = FirebaseFirestore.instance.collection("people");
  late List<Map<String, dynamic>> items;
  bool isLoaded = false;

  void _incrementCounter() async {
    List<Map<String, dynamic>> tempList = [];
    var data = await _collection.get();

    data.docs.forEach((element) {
      tempList.add(element.data());
    });

    setState(() {
      items = tempList;
      isLoaded = true;
    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AppBar'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: isLoaded ? ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.all(8.0),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  leading: CircleAvatar(
                    backgroundColor: Color(0xff6ae792),
                    child: Icon(Icons.person),
                  ),
                  title: Row(
                    children: [
                      Text(items[index]['name'] ?? 'no name'),
                      SizedBox(width: 10,),
                      Text(items[index]['age']?.toString() ?? 'no age')
                    ],
                  ),
                  subtitle: Text(items[index]['job'] ?? 'no job'),
                  trailing: Icon(Icons.more_vert),
                ),
              );
            },
        ) : Text('no data')
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:() {
            _incrementCounter();
           },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
