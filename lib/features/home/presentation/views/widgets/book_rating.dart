import 'package:bookly/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BookRating extends StatelessWidget {
  final dynamic mainAxisAlignment;

  const BookRating({
    super.key,
    this.mainAxisAlignment = MainAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        const Icon(FontAwesomeIcons.solidStar, color: Colors.amber),
        const SizedBox(width: 10),
        const Text('4.8', style: Styles.textStyle16),
        const SizedBox(width: 10),
        Opacity(
          opacity: 0.5,
          child: Text('(245)', style: Styles.textStyle14.copyWith()),
        ),
      ],
    );
  }
}
