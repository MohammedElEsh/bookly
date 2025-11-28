import 'package:bookly/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BookRating extends StatelessWidget {
  final dynamic mainAxisAlignment;
  final num rating;
  final int count;

  const BookRating({
    super.key,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.rating = 0,
    this.count = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        const Icon(FontAwesomeIcons.solidStar, color: Colors.amber, size: 14),
        const SizedBox(width: 6.3),
        Text(rating.toStringAsFixed(1), style: Styles.textStyle16),
        const SizedBox(width: 5),
        Opacity(
          opacity: 0.5,
          child: Text('($count)', style: Styles.textStyle14.copyWith()),
        ),
      ],
    );
  }
}
