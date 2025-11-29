import 'package:bookly/constants.dart';
import 'package:bookly/features/home/data/remote/models/book_model/book_model.dart';
import '../../../../../core/functions/save_books.dart';
import '../../../../../core/utils/api_service.dart';
import '../../../domain/entities/book_entity.dart';

abstract class HomeRemoteDataSource {
  Future<List<BookEntity>> fetchFeaturedBooks({int? pageNumber = 0});
  Future<List<BookEntity>> fetchNewestBooks({int? pageNumber = 0});
  Future<List<BookEntity>> fetchSimilarBooks({required String category});
}

class HomeRemoteDataSourceImpl extends HomeRemoteDataSource {
  final ApiService apiService;

  HomeRemoteDataSourceImpl(this.apiService);
  @override
  Future<List<BookEntity>> fetchFeaturedBooks({int? pageNumber = 0}) async {
    var data = await apiService.get(
      endpoint:
          'volumes?filter=free-ebooks&q=programming&startIndex=${pageNumber! * 10}',
    );

    List<BookEntity> books = getBooksList(data);

    // Use different save strategies based on page number
    if (pageNumber == 0) {
      saveBooksData(books, kFeaturedBox); // Clear and save for first page
    } else {
      saveBooksDataPaginated(
        books,
        kFeaturedBox,
      ); // Append for subsequent pages
    }

    return books;
  }

  @override
  Future<List<BookEntity>> fetchNewestBooks({int? pageNumber = 0}) async {
    var data = await apiService.get(
      endpoint:
          'volumes?filter=free-ebooks&orderBy=newest&q=programming&startIndex=${pageNumber! * 10}',
    );

    List<BookEntity> books = getBooksList(data);

    // Use different save strategies based on page number
    if (pageNumber == 0) {
      saveBooksData(books, kNewestBox); // Clear and save for first page
    } else {
      saveBooksDataPaginated(books, kNewestBox); // Append for subsequent pages
    }

    return books;
  }

  @override
  Future<List<BookEntity>> fetchSimilarBooks({required String category}) async {
    var data = await apiService.get(
      endpoint:
          'volumes?filter=free-ebooks&Sorting=relevance&q=subject:programming',
    );

    List<BookEntity> books = getBooksList(data);
    return books;
  }

  List<BookEntity> getBooksList(Map<String, dynamic> data) {
    List<BookEntity> books = [];

    for (var bookMap in data['items']) {
      books.add(BookModel.fromJson(bookMap));
    }
    return books;
  }
}
