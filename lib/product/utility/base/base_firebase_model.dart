//bundan türeyen bütün metottlarımda olmasını istediğim bir özellik var.İskelet olarak kullanacağımız için abstract dedik.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:news_app/product/utility/exception/custom_exception.dart';

//lesson 3 dk 57

abstract class IdModel {
  String? get id;
}

//%100 idsi olmak zoruunda olduğu için ekledik IdModeli. Basefirebasemodelden türeyen bütün modellerde id olmak zorunda
abstract class BaseFirebaseModel<T extends IdModel> {
  T fromJson(Map<String, dynamic> json);

  //
  T fromFirebase(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final value = snapshot.data();
    if (value == null) {
      //return null;
      throw FirebaseCustomException('Snapshow data is null');
    }
    //addEntries ile value mapine başka bir map itemı ekliyoruz.
    //fixme-bu haliyle de gayet kullanışlı ama nasıl bir geliştirme yaparız bilemem.
    value.addEntries([MapEntry('id', snapshot.id)]);
    return fromJson(value);
  }
}
