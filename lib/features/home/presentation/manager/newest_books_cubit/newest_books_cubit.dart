// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:bookly/features/home/domain/entities/book_entity.dart';
import 'package:bookly/features/home/domain/use_cases/fetch_newest_books_use_case.dart';
import 'package:flutter/material.dart';

part 'newest_books_state.dart';

class NewestBooksCubit extends Cubit<NewestBooksState> {
  NewestBooksCubit(this.fetchNewestBooksUseCase) : super(NewestBooksInitial());

  final FetchNewestBooksUseCase fetchNewestBooksUseCase;
  int _currentPage = 0;

  Future<void> getNewestBooks({int pageNumber = 0}) async {
    if (pageNumber == 0) {
      emit(NewestBooksLoading());
    } else {
      emit(
        NewestBooksPaginationLoading(
          state is NewestBooksSuccess
              ? (state as NewestBooksSuccess).books
              : [],
        ),
      );
    }

    var result = await fetchNewestBooksUseCase.call(pageNumber);

    result.fold(
      (failure) {
        emit(NewestBooksFailure(failure.errMessage));
      },
      (books) {
        if (pageNumber == 0) {
          _currentPage = 0;
          emit(NewestBooksSuccess(books));
        } else {
          _currentPage = pageNumber;
          final currentBooks = state is NewestBooksSuccess
              ? (state as NewestBooksSuccess).books
              : (state is NewestBooksPaginationLoading
                    ? (state as NewestBooksPaginationLoading).books
                    : <BookEntity>[]);
          emit(NewestBooksSuccess([...currentBooks, ...books]));
        }
      },
    );
  }

  Future<void> fetchNextPage() async {
    await getNewestBooks(pageNumber: _currentPage + 1);
  }
}
