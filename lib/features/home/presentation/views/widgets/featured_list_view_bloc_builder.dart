import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../manager/featured_books_cubit/featured_books_cubit.dart';
import 'featured_list_view.dart';

class FeaturedBooksListViewBlocBuilder extends StatelessWidget {
  const FeaturedBooksListViewBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeaturedBooksCubit, FeaturedBooksState>(
      builder: (context, state) {
        if (state is FeaturedBooksSuccess ||
            state is FeaturedBooksPaginationLoading) {
          final books = state is FeaturedBooksSuccess
              ? state.books
              : (state as FeaturedBooksPaginationLoading).books;
          return FeaturedBooksListView(books: books);
        } else if (state is FeaturedBooksFailure) {
          return Text(state.errMessage);
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
