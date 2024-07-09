import 'package:fancy_button_flutter/fancy_button_flutter.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Row(
            children: [
              FancyButton(
                  button_text: "Button",
                  button_height: 40,
                  button_width: 100,
                  button_radius: 0,
                  button_color: Colors.red,
                  button_outline_color: Colors.yellow,
                  button_outline_width: 1,
                  button_text_color: Colors.white,
                  button_icon_color: Colors.white,
                  icon_size: 22,
                  button_text_size: 15,
                  onClick: (){
                    print("Button clicked");
                  })
              ,
              SizedBox(width: 10,),
              FancyButton(
                  button_text: "Button",
                  button_height: 40,
                  button_width: 100,
                  button_radius: 50,
                  button_color: Colors.red,
                  button_outline_color: Colors.yellow,
                  button_outline_width: 1,
                  button_text_color: Colors.white,
                  button_icon_color: Colors.white,
                  icon_size: 22,
                  button_text_size: 15,
                  onClick: (){
                    print("Button clicked");
                  }),
              SizedBox(width: 10,),
              FancyButton(
                  button_icon: Icons.account_circle_rounded,
                  button_text: "Button",
                  button_height: 40,
                  button_width: 150,
                  button_radius: 50,
                  button_color: Colors.red,
                  button_outline_color: Colors.yellow,
                  button_outline_width: 1,
                  button_text_color: Colors.white,
                  button_icon_color: Colors.white,
                  icon_size: 22,
                  button_text_size: 15,
                  onClick: (){
                    print("Button clicked");
                  })
            ],
          ),
          SizedBox(height: 10,),
          Row(
            children: [
              FancyButton(
                  button_text: "  Login  ",
                  button_height: 40,
                  button_width: 100,
                  button_radius: 0,
                  button_color: Colors.blue,
                  button_outline_color: Colors.blue,
                  button_outline_width: 1,
                  button_text_color: Colors.white,
                  button_icon_color: Colors.white,
                  icon_size: 22,
                  button_text_size: 15,
                  onClick: (){
                    print("Button clicked");
                  }),

              SizedBox(width: 10,),

              FancyButton(
                  button_text: "  Login  ",
                  button_height: 40,
                  button_width: 100,
                  button_radius: 50,
                  button_color: Colors.blue,
                  button_outline_color: Colors.blue,
                  button_outline_width: 1,
                  button_text_color: Colors.white,
                  button_icon_color: Colors.white,
                  icon_size: 22,
                  button_text_size: 15,
                  onClick: (){
                    print("Button clicked");
                  })
              ,
              SizedBox(width: 10,),

              FancyButton(
                  button_icon: Icons.facebook,
                  button_text: "  Login  ",
                  button_height: 40,
                  button_width: 150,
                  button_radius: 50,
                  button_color: Colors.blue,
                  button_outline_color: Colors.blue,
                  button_outline_width: 1,
                  button_text_color: Colors.white,
                  button_icon_color: Colors.white,
                  icon_size: 22,
                  button_text_size: 15,
                  onClick: (){
                    print("Button clicked");
                  })
            ],
          ),
          SizedBox(height: 10,),
          Row(
            children: [
              FancyButton(
                  button_text: "  Logout  ",
                  button_height: 40,
                  button_width: 100,
                  button_radius: 0,
                  button_color: Colors.black,
                  button_outline_color: Colors.black,
                  button_outline_width: 1,
                  button_text_color: Colors.white,
                  button_icon_color: Colors.white,
                  icon_size: 22,
                  button_text_size: 15,
                  onClick: (){
                    print("Button clicked");
                  }),

              SizedBox(width: 10,),

              FancyButton(
                  button_text: "  Logout  ",
                  button_height: 40,
                  button_width: 100,
                  button_radius: 50,
                  button_color: Colors.black,
                  button_outline_color: Colors.black,
                  button_outline_width: 1,
                  button_text_color: Colors.white,
                  button_icon_color: Colors.white,
                  icon_size: 22,
                  button_text_size: 15,
                  onClick: (){
                    print("Button clicked");
                  }),

              SizedBox(width: 10,),

              FancyButton(
                  button_icon: Icons.logout,
                  button_text: "  Logout  ",
                  button_height: 40,
                  button_width: 150,
                  button_radius: 50,
                  button_color: Colors.black,
                  button_outline_color: Colors.black,
                  button_outline_width: 1,
                  button_text_color: Colors.white,
                  button_icon_color: Colors.white,
                  icon_size: 22,
                  button_text_size: 15,
                  onClick: (){
                    print("Button clicked");
                  })
            ],
          ),
          SizedBox(height: 10,),
          Row(
            children: [
              FancyButton(
                  button_text: "  Chart  ",
                  button_height: 40,
                  button_width: 100,
                  button_radius: 0,
                  button_color: Colors.deepOrange,
                  button_outline_color: Colors.deepOrange,
                  button_outline_width: 1,
                  button_text_color: Colors.white,
                  button_icon_color: Colors.white,
                  icon_size: 22,
                  button_text_size: 15,
                  onClick: (){
                    print("Button clicked");
                  }),
              SizedBox(width: 10,),

              FancyButton(
                  button_text: "  Chart  ",
                  button_height: 40,
                  button_width: 100,
                  button_radius: 50,
                  button_color: Colors.deepOrange,
                  button_outline_color: Colors.deepOrange,
                  button_outline_width: 1,
                  button_text_color: Colors.white,
                  button_icon_color: Colors.white,
                  icon_size: 22,
                  button_text_size: 15,
                  onClick: (){
                    print("Button clicked");
                  }),
              SizedBox(width: 10,),

              FancyButton(
                  button_icon: Icons.add_chart,
                  button_text: "  Chart  ",
                  button_height: 40,
                  button_width: 150,
                  button_radius: 50,
                  button_color: Colors.deepOrange,
                  button_outline_color: Colors.deepOrange,
                  button_outline_width: 1,
                  button_text_color: Colors.white,
                  button_icon_color: Colors.white,
                  icon_size: 22,
                  button_text_size: 15,
                  onClick: (){
                    print("Button clicked");
                  })
            ],
          ),
          SizedBox(height: 10,),
          Row(
            children: [
              FancyButton(
                  button_text: "Add",
                  button_height: 50,
                  button_width: 100,
                  button_radius: 0,
                  button_color: Colors.green,
                  button_outline_color: Colors.green,
                  button_outline_width: 1,
                  button_text_color: Colors.white,
                  button_icon_color: Colors.white,
                  icon_size: 22,
                  button_text_size: 15,
                  onClick: (){
                    print("Button clicked");
                  }),
              SizedBox(width: 10,),

              FancyButton(
                  button_text: "  Add  ",
                  button_height: 40,
                  button_width: 100,
                  button_radius: 50,
                  button_color: Colors.green,
                  button_outline_color: Colors.green,
                  button_outline_width: 1,
                  button_text_color: Colors.white,
                  button_icon_color: Colors.white,
                  icon_size: 22,
                  button_text_size: 15,
                  onClick: (){
                    print("Button clicked");
                  }),

              SizedBox(width: 10,),

              FancyButton(
                  button_icon: Icons.add_circle_outline,
                  button_text: "  Add  ",
                  button_height: 40,
                  button_width: 150,
                  button_radius: 50,
                  button_color: Colors.green,
                  button_outline_color: Colors.green,
                  button_outline_width: 1,
                  button_text_color: Colors.white,
                  button_icon_color: Colors.white,
                  icon_size: 22,
                  button_text_size: 15,
                  onClick: (){
                    print("Button clicked");
                  })
            ],
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}