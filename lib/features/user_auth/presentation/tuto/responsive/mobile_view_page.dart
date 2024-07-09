import 'package:flutter/material.dart';
class MobileProductPage extends StatelessWidget {
  final List<String> entries = <String>[
    'assets/demo/tablet.jpeg',
    'assets/demo/tablet.jpeg',
    'assets/demo/tablet.jpeg'
  ];
  final List<int> colorCodes = <int>[600, 500, 100];

  MobileProductPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Center(
      child: Column(
         crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Mobile view'),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  double maxWidth = 800;
                  return SizedBox(
                    width: constraints.maxWidth > maxWidth ? maxWidth : constraints.maxWidth,
                    height: 300,
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: entries.length + 50,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey.shade50,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: Colors.grey,
                                    width: 1
                                )
                            ),
                            child: Row(
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
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
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
                                )
                              ],
                            ),
                          ),
                        );
                      },
                      //separatorBuilder: (BuildContext context, int index) => const Divider(),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}