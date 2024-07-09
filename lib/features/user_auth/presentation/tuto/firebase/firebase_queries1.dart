import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (_) => const FirebaseQueries(),
      },
    );
  }
}

class FirebaseQueries extends StatefulWidget {
  const FirebaseQueries({super.key});

  @override
  State<FirebaseQueries> createState() => _FirebaseQueriesState();
}

class _FirebaseQueriesState extends State<FirebaseQueries> {


  int _counter = 0;
  final _collection = FirebaseFirestore.instance.collection('people');

  Future<void> _incrementData() async {
    /*_collection.add({
      "name": "adam",
      "age": 31,
      "country": "morocco"
    });*/

    print('----------------------------');
    var allDocs = await _collection.get();
    var FirstDocID = allDocs.docs.first.id;
    print(FirstDocID);
    var LastDocID = allDocs.docs.last.id;
    print(LastDocID);
    print('----------------------------');

    await _collection.doc(FirstDocID).set({
      "name": "adam",
      "age": 35,
      "country": "morocco",
      "job": "coder",
      'state': 'single'
    });

    await _collection.add({
      "name": "adam",
      "age": 35,
      "country": "morocco",
      "job": "coder",
      'state': 'single'
    });

    var firebaseObj = await _collection.where('age', isNotEqualTo: 30).get();
    print(firebaseObj.size);

    setState(() {
      _counter = allDocs.size;
    });
  }

  @override
  void initState() {
    _incrementData();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('appBar'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            color: Colors.blue,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'This time add data:',
                        style: TextStyle(fontSize: 33),
                      ),
                      Text(
                        '$_counter',
                        style: const TextStyle(fontSize: 33),
                      ),
                    ],
                  ),
                ),
              ],
            ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _incrementData();
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
  @override
  void dispose() {
    // Dispose Firestore instance
    FirebaseFirestore.instance.terminate();
    super.dispose();
  }

}
