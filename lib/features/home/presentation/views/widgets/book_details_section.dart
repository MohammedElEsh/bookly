import 'package:bookly/core/utils/styles.dart';
import 'package:flutter/material.dart';

import 'book_rating.dart';
import 'books_action.dart';
import 'featured_list_view_item.dart';

class BookDetailsSection extends StatelessWidget {
  const BookDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.2),
          child: const FeaturedListViewItem(),
        ),
        const SizedBox(height: 43),
        Text(
          'The Jingle Book',
          style: Styles.textStyle30.copyWith(
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 6),
        Opacity(
          opacity: 0.7,
          child: Text(
            'Rudyard Kipling',
            style: Styles.textStyle18.copyWith(
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 18),
        const BookRating(
          mainAxisAlignment: MainAxisAlignment.center,
        ),


        const SizedBox(height: 40),
        const BooksAction(),

      ],
    );
  }
}


