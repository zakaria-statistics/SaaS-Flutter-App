import 'package:flutter/material.dart';

class ReviewPage extends StatefulWidget {
  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  int selectedStars = 0; // Default to 3 stars (Neutral)

  String getReviewText(int stars) {
    switch (stars) {
      case 1:
        return 'Not Satisfied';
      case 2:
        return 'Somewhat Dissatisfied';
      case 3:
        return 'Neutral';
      case 4:
        return 'Satisfied';
      case 5:
        return 'Highly Satisfied';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('Add review : ', style: TextStyle(color: Colors.grey.shade600, fontSize: 33)),
        StarRating(
          rating: selectedStars,
          onRatingChanged: (rating) {
            setState(() {
              selectedStars = rating;
            });
          },
        ),
        SizedBox(width: 50),
        Text(
          getReviewText(selectedStars),
          style: TextStyle(fontSize: 22),
        ),
      ],
    );
  }
}

class StarRating extends StatelessWidget {
  final int rating;
  final Function(int) onRatingChanged;

  StarRating({required this.rating, required this.onRatingChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (index) {
        return GestureDetector(
          onTap: () {
            onRatingChanged(index + 1);
          },
          child: Icon(
            index < rating ? Icons.star : Icons.star_border,
            color: Colors.amber,
            size: 28,
          ),
        );
      }),
    );
  }
}