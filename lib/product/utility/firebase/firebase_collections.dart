// ignore_for_file: lines_longer_than_80_chars

import 'package:cloud_firestore/cloud_firestore.dart';

enum FirebaseCollections {
  version;

  CollectionReference get reference => FirebaseFirestore.instance.collection(name);
}
