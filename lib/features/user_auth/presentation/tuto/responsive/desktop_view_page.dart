import 'package:flutter/material.dart';

class DesktopProductPage extends StatelessWidget {
  List<String> entries = <String>[
    'assets/demo/tablet.jpeg',
    'assets/demo/tablet.jpeg',
    'assets/demo/tablet.jpeg',
    'assets/demo/tablet.jpeg',
    'assets/demo/tablet.jpeg',
    'assets/demo/tablet.jpeg',
    'assets/demo/tablet.jpeg'
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    List<String> duplicatedEntries = List.from(entries)..addAll(entries);
    List<String> quadraticEntries = [];
    duplicatedEntries.forEach((element) {
      quadraticEntries.add(element);
      quadraticEntries.add(element);
      quadraticEntries.add(element);
      quadraticEntries.add(element);
    });
    return SingleChildScrollView(
      child: Column(
        children: [
          for (int i = 0; i < quadraticEntries.length; i++)
            SingleChildScrollView(
              child: Row(
                children: [
                  for (int j = 0; j < quadraticEntries.length; j++)
                    Expanded(
                      child: Column(
                        children: [
                          Image(
                            image: AssetImage('assets/demo/tablet.jpeg'),
                            width: 100, // Set width and height as needed
                            height: 100,
                          ),
                          Text('data'),
                          Text('data'),
                          Text('data'),
                        ],
                      ),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
