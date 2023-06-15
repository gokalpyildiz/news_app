// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:news_app/product/utility/base/base_firebase_model.dart';

class Number extends Equatable with IdModel, BaseFirebaseModel<Number> {
  final String? number;

  Number({
    this.number,
  });
  @override
  // id set etme zorunluluğu olmadığı için böyle yazdık.
  //String? get id => '';
  //altaki gibi dezabiliriz önemli değil
  String? id = '';
  Number copyWith({
    String? number,
  }) {
    return Number(
      number: number ?? this.number,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'number': number,
    };
  }

  //alttakini aldık zaten buna gerek kalmadı
  // factory Number.fromJson(Map<String, dynamic> json) {
  //   return Number(
  //     number: json['number'] as String?,
  //   );
  // }

  @override
  Number fromJson(Map<String, dynamic> json) {
    // TODO: üstteki fromjsondan aldık.
    return Number(
      number: json['number'] as String?,
    );
  }

  @override
  List<Object?> get props => [number];
}
