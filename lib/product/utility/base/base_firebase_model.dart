//bundan türeyen bütün metottlarımda olmasını istediğim bir özellik var.İskelet olarak kullannacağımız için abstract dedik.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:news_app/product/utility/exception/custom_exception.dart';

//lesson 3 dk 57

abstract class IdModel {
  String? get id;
}

//%100 idsi olmak zoruunda olduğu için ekledik IdModeli
abstract class BaseFirebaseModel<T extends IdModel> {
  T fromJson(Map<String, dynamic> json);

  //
  T fromFirebase(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final value = snapshot.data();
    if (value == null) {
      //return null;
      throw FirebaseCustomException('Snapshow data is null');
    }
    //fixme
    value.addEntries([MapEntry('id', snapshot.id)]);
    return fromJson(value);
  }
}
