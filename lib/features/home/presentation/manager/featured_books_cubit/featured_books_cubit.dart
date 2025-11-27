// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:bookly/features/home/domain/entities/book_entity.dart';
import 'package:bookly/features/home/domain/use_cases/fetch_featured_books_use_case.dart';
import 'package:flutter/material.dart';
part 'featured_books_state.dart';

class FeaturedBooksCubit extends Cubit<FeaturedBooksState> {
  FeaturedBooksCubit(this.featuredBooksUseCase) : super(FeaturedBooksInitial());

  final FetchFeaturedBooksUseCase featuredBooksUseCase;
  int _currentPage = 0;

  Future<void> getFeaturedBooks({int pageNumber = 0}) async {
    if (pageNumber == 0) {
      emit(FeaturedBooksLoading());
    } else {
      emit(
        FeaturedBooksPaginationLoading(
          state is FeaturedBooksSuccess
              ? (state as FeaturedBooksSuccess).books
              : [],
        ),
      );
    }

    var result = await featuredBooksUseCase.call(pageNumber);

    result.fold(
      (failure) {
        emit(FeaturedBooksFailure(failure.errMessage));
      },
      (books) {
        if (pageNumber == 0) {
          _currentPage = 0;
          emit(FeaturedBooksSuccess(books));
        } else {
          _currentPage = pageNumber;
          final currentBooks = state is FeaturedBooksSuccess
              ? (state as FeaturedBooksSuccess).books
              : (state is FeaturedBooksPaginationLoading
                    ? (state as FeaturedBooksPaginationLoading).books
                    : <BookEntity>[]);
          emit(FeaturedBooksSuccess([...currentBooks, ...books]));
        }
      },
    );
  }

  Future<void> fetchNextPage() async {
    await getFeaturedBooks(pageNumber: _currentPage + 1);
  }
}
