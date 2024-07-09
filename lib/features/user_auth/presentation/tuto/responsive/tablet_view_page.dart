import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class TabletProductPage extends StatelessWidget {

  final List<String> entries = <String>[
    'assets/demo/tablet.jpeg',
    'assets/demo/tablet.jpeg',
    'assets/demo/tablet.jpeg'
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Tablet view'),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 500,
                    height: 500,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.all(8),
                      itemCount: entries.length + 50,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: Colors.grey,
                                    width: 1
                                )
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 300,
                                  height: 300,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      entries[index % 3],
                                    ),
                                  ),
                                ),
                                Text('Tablet ipad for design ${index + 1}'),
                                Row(
                                  children: [
                                    Text('200\$'),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text('250\$', style: TextStyle(decoration: TextDecoration.lineThrough),),
                                  ],
                                ),
                                Row(
                                  children: List.generate(
                                    index % 5 + 1,
                                        (index) {
                                      return Icon(Icons.star, color: Colors.yellow,);
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                      //separatorBuilder: (BuildContext context, int index) => const Divider(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}