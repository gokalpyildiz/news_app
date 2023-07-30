import 'package:equatable/equatable.dart';
import 'package:news_app/product/utility/base/base_firebase_model.dart';

class News extends Equatable with IdModel, BaseFirebaseModel<News> {
  const News({
    this.id,
    this.category,
    this.categoryId,
    this.title,
    this.backgroundImage,
  });

  //en alta ekledik buna artık gerek yok
  // factory News.fromJson(Map<String, dynamic> json) {
  //   return News(
  //     id: json['id'] as String?,
  //     category: json['category'] as String?,
  //     categoryId: json['categoryId'] as String?,
  //     title: json['title'] as String?,
  //     backgroundImage: json['backgroundImage'] as String?,
  //   );
  // }
  @override
  final String? id;
  final String? category;
  final String? categoryId;
  final String? title;
  final String? backgroundImage;

  News copyWith({
    String? id,
    String? category,
    String? categoryId,
    String? title,
    String? backgroundImage,
  }) {
    return News(
      id: id ?? this.id,
      category: category ?? this.category,
      categoryId: categoryId ?? this.categoryId,
      title: title ?? this.title,
      backgroundImage: backgroundImage ?? this.backgroundImage,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category': category,
      'categoryId': categoryId,
      'title': title,
      'backgroundImage': backgroundImage,
    };
  }

  @override
  // ignore: lines_longer_than_80_chars
  String toString() => 'News(id: $id,category: $category,categoryId: $categoryId,title: $title,backgroundImage: $backgroundImage)';

  @override
  // ignore: lines_longer_than_80_chars
  int get hashCode => Object.hash(id, category, categoryId, title, backgroundImage);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is News &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          category == other.category &&
          categoryId == other.categoryId &&
          title == other.title &&
          backgroundImage == other.backgroundImage;

  @override
  List<Object?> get props => [id, category, categoryId, title, backgroundImage];

  //override a gerek var mı
  @override
  News fromJson(Map<String, dynamic> json) {
    return News(
      id: json['id'] as String?,
      category: json['category'] as String?,
      categoryId: json['categoryId'] as String?,
      title: json['title'] as String?,
      backgroundImage: json['backgroundImage'] as String?,
    );
  }
}
