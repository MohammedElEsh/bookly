import 'package:bookly/constants.dart';
import 'package:hive/hive.dart';
import '../../../domain/entities/book_entity.dart';

abstract class HomeLocalDataSource {
  List<BookEntity> fetchFeaturedBooks({int? pageNumber = 0});
  List<BookEntity> fetchNewestBooks({int? pageNumber = 0});
}

class HomeLocalDataSourceImpl extends HomeLocalDataSource {
  @override
  List<BookEntity> fetchFeaturedBooks({int? pageNumber = 0}) {
    const int pageSize = 10;
    var box = Hive.box<BookEntity>(kFeaturedBox);

    int startIndex = (pageNumber ?? 0) * pageSize;
    int endIndex = startIndex + pageSize;

    List<BookEntity> allBooks = box.values.toList();

    // Return empty list if startIndex is beyond available books
    if (startIndex >= allBooks.length) {
      return [];
    }

    // Adjust endIndex if it exceeds the list length
    if (endIndex > allBooks.length) {
      endIndex = allBooks.length;
    }

    return allBooks.sublist(startIndex, endIndex);
  }

  @override
  List<BookEntity> fetchNewestBooks({int? pageNumber = 0}) {
    const int pageSize = 10;
    var box = Hive.box<BookEntity>(kNewestBox);

    int startIndex = (pageNumber ?? 0) * pageSize;
    int endIndex = startIndex + pageSize;

    List<BookEntity> allBooks = box.values.toList();

    // Return empty list if startIndex is beyond available books
    if (startIndex >= allBooks.length) {
      return [];
    }

    // Adjust endIndex if it exceeds the list length
    if (endIndex > allBooks.length) {
      endIndex = allBooks.length;
    }

    return allBooks.sublist(startIndex, endIndex);
  }
}
