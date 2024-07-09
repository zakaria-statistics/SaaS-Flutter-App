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

  final instance = FirebaseFirestore.instance;
  late int counter = 0;
  late String field = '';

  void _fetchFirebase() async {


    var collectionRef = instance.collection('message');
    var allDocs = await collectionRef.get();
    var docId = allDocs.docs.first.id;
    var docIdField =  allDocs.docs.where((element) => element.id == "j9JBi6Fff328uybT4z0V").first.id;

    await collectionRef.doc(docIdField).set({
      "from_avatar": "https://docs.google.com",
      "from_name": "zack",
      "last_msg": "",
      "last_time" : Timestamp.now(),
      "msg_num": 0,
      "to_avatar": "https://docs.google.com",
      "to_name": "lord",
    });

    var subCollection = await collectionRef
        .doc(docId)
        .collection('msgList');

    await subCollection.doc("j0OyC5NquHvxyYz5nzkx").update({'type':'lolo'});




    var result = await subCollection.get();



    field = await result.docs.first.get('type');


    setState(() {
      counter = result.size;
    });

  }


  void _incrementCounter() async {

    _fetchFirebase();
    setState(() {

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
        child :Column(
          children: [
            Text(counter.toString()),
            Text(field),
          ],
        )
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
