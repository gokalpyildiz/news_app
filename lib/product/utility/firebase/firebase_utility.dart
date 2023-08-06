// ignore_for_file: lines_longer_than_80_chars

import 'package:news_app/product/utility/base/base_firebase_model.dart';

import 'package:news_app/product/utility/firebase/firebase_collections.dart';

mixin FirebaseUtility {
  //T idmodelten türeyecek.T parse etmek istediğim data tipi.
  //sonuç olarak önce T diye bir generic tip ver.İkinci olarak bir tane daha tip ver R adında
  //Kullanacağımız generic tiplerin ne olduğunu <> içinde belirtmiş oluyoruz gibi anladım.
  Future<List<T>?> fetchList<T extends IdModel, R extends BaseFirebaseModel<T>>(
    R data,
    FirebaseCollections collections,
  ) async {
    final newsCollectionReference = collections.reference;
    final response = await newsCollectionReference.withConverter<T>(
      fromFirestore: (snapshot, options) {
        return data.fromFirebase(snapshot);
      },
      toFirestore: (value, options) {
        //kullanmadığımız için bu şekilde bıraktık.fromfirebasede olduğu gibi tosjon da ekleneblir
        //return value.toJson();
        return {};
      },
    ).get();

    if (response.docs.isNotEmpty) {
      final values = response.docs.map((e) => e.data()).toList();
      return values;
    }
    return null;
  }
}
