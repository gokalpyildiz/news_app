// ignore_for_file: public_member_api_docs, sort_constructors_first
class FirebaseCustomException implements Exception {
  FirebaseCustomException(this.description);

  final String description;

  @override
  String toString() => '$this $description';
}

class VersionCustomException implements Exception {
  VersionCustomException(this.description);

  final String description;

  @override
  String toString() => '$this $description';
}
