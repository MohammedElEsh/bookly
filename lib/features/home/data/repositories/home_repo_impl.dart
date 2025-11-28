import 'package:bookly/core/errors/failure.dart';
import 'package:bookly/features/home/data/local/data_sources/home_local_data_source.dart';
import 'package:bookly/features/home/data/remote/data_sources/home_remote_data_source.dart';
import 'package:bookly/features/home/domain/entities/book_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../domain/repositories/home_repo.dart';

class HomeRepoImpl extends HomeRepo {
  final HomeRemoteDataSource homeRemoteDataSource;
  final HomeLocalDataSource homeLocalDataSource;

  HomeRepoImpl({
    required this.homeRemoteDataSource,
    required this.homeLocalDataSource,
  });
  @override
  Future<Either<Failure, List<BookEntity>>> fetchFeaturedBooks({
    int? pageNumber = 0,
  }) async {
    try {
      List<BookEntity> books;

      // Only check local cache for the first page
      if (pageNumber == 0) {
        books = homeLocalDataSource.fetchFeaturedBooks(pageNumber: pageNumber);

        if (books.isNotEmpty) {
          return right(books);
        }
      }

      // Fetch from remote for first page (if cache empty) or any subsequent page
      books = await homeRemoteDataSource.fetchFeaturedBooks(
        pageNumber: pageNumber,
      );

      return right(books);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    } catch (e) {
      return left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<BookEntity>>> fetchNewestBooks({
    int? pageNumber = 0,
  }) async {
    try {
      List<BookEntity> books;

      // Only check local cache for the first page
      if (pageNumber == 0) {
        books = homeLocalDataSource.fetchNewestBooks(pageNumber: pageNumber);

        if (books.isNotEmpty) {
          return right(books);
        }
      }

      // Fetch from remote for first page (if cache empty) or any subsequent page
      books = await homeRemoteDataSource.fetchNewestBooks(
        pageNumber: pageNumber,
      );

      return right(books);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    } catch (e) {
      return left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }
}
