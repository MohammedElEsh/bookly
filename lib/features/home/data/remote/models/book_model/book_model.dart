import 'access_info.dart';
import 'sale_info.dart';
import 'volume_info.dart';
import '../../../../domain/entities/book_entity.dart';

class BookModel extends BookEntity {
  final String? kind;
  final String? id;
  final String? etag;
  final String? selfLink;
  final VolumeInfo? volumeInfo;
  final SaleInfo? saleInfo;
  final AccessInfo? accessInfo;

  BookModel({
    this.kind,
    this.id,
    this.etag,
    this.selfLink,
    this.volumeInfo,
    this.saleInfo,
    this.accessInfo,
  }) : super(
         bookId: id ?? '',
         title: volumeInfo?.title ?? 'Unknown Title',
         image: volumeInfo?.imageLinks?.thumbnail ?? '',
         authorName: volumeInfo?.authors?.isNotEmpty == true
             ? volumeInfo!.authors?.first
             : 'Unknown Author',
         price: 0.0,
         rating: volumeInfo?.averageRating ?? 0.0,
       );

  factory BookModel.fromJson(Map<String, dynamic> json) => BookModel(
    kind: json['kind'] as String?,
    id: json['id'] as String?,
    etag: json['etag'] as String?,
    selfLink: json['selfLink'] as String?,
    volumeInfo: json['volumeInfo'] != null
        ? VolumeInfo.fromJson(json['volumeInfo'])
        : null,
    saleInfo: json['saleInfo'] != null
        ? SaleInfo.fromJson(json['saleInfo'])
        : null,
    accessInfo: json['accessInfo'] != null
        ? AccessInfo.fromJson(json['accessInfo'])
        : null,
  );

  Map<String, dynamic> toJson() => {
    'kind': kind,
    'id': id,
    'etag': etag,
    'selfLink': selfLink,
    'volumeInfo': volumeInfo?.toJson(),
    'saleInfo': saleInfo?.toJson(),
    'accessInfo': accessInfo?.toJson(),
  };

  BookModel copyWith({
    String? kind,
    String? id,
    String? etag,
    String? selfLink,
    VolumeInfo? volumeInfo,
    SaleInfo? saleInfo,
    AccessInfo? accessInfo,
  }) {
    return BookModel(
      kind: kind ?? this.kind,
      id: id ?? this.id,
      etag: etag ?? this.etag,
      selfLink: selfLink ?? this.selfLink,
      volumeInfo: volumeInfo ?? this.volumeInfo,
      saleInfo: saleInfo ?? this.saleInfo,
      accessInfo: accessInfo ?? this.accessInfo,
    );
  }

  @override
  String toString() => 'BookModel(id: $id, title: ${volumeInfo?.title})';
}
