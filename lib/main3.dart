import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Customer Reviews',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ReviewPage(),
    );
  }
}

class ReviewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customer Reviews'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ReviewRow(stars: 1, reviewText: 'Not Satisfied'),
            ReviewRow(stars: 2, reviewText: 'Somewhat Dissatisfied'),
            ReviewRow(stars: 3, reviewText: 'Neutral'),
            ReviewRow(stars: 4, reviewText: 'Satisfied'),
            ReviewRow(stars: 5, reviewText: 'Highly Satisfied'),
          ],
        ),
      ),
    );
  }
}

class ReviewRow extends StatelessWidget {
  final int stars;
  final String reviewText;

  const ReviewRow({required this.stars, required this.reviewText});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        StarDisplay(stars: stars),
        SizedBox(width: 10),
        Text(
          reviewText,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class StarDisplay extends StatelessWidget {
  final int stars;

  const StarDisplay({required this.stars});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (index) {
        return Icon(
          index < stars ? Icons.star : Icons.star_border,
          color: Colors.amber,
        );
      }),
    );
  }
}
