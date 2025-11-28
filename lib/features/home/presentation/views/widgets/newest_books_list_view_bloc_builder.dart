import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../manager/newest_books_cubit/newest_books_cubit.dart';
import 'best_seller_list_view.dart';

class NewestBooksListViewBlocBuilder extends StatelessWidget {
  const NewestBooksListViewBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewestBooksCubit, NewestBooksState>(
      builder: (context, state) {
        if (state is NewestBooksSuccess ||
            state is NewestBooksPaginationLoading) {
          final books = state is NewestBooksSuccess
              ? state.books
              : (state as NewestBooksPaginationLoading).books;
          return BestSellerListView(books: books);
        } else if (state is NewestBooksFailure) {
          return SliverToBoxAdapter(
            child: Center(child: Text(state.errMessage)),
          );
        } else {
          return const SliverToBoxAdapter(
            child: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }
}
