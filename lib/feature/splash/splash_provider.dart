// ignore_for_file: public_member_api_docs, sort_constructors_first, lines_longer_than_80_chars
//snippedı stano
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/product/enums/platform_enum.dart';
import 'package:news_app/product/models/number_model.dart';
import 'package:news_app/product/utility/firebase/firebase_collections.dart';
import 'package:news_app/product/utility/version_manager.dart';

class SplashProvider extends StateNotifier<SplashState> {
  SplashProvider() : super(const SplashState());

  Future<void> checkApplicationVersion(String clientVersion) async {
    final databaseValue = await getVersionNumberFromDatabase();
    if (databaseValue == null || databaseValue.isEmpty) {
      //webde null geliyor.Bunun için de hata sayfasına falan yönlendirebiliriz
      state = state.copyWith(isRedirectHome: false);
      return;
    }
    final checkIsNeedForceUpdate = VersionManager(deviceValue: clientVersion, databaseValue: databaseValue);
    if (checkIsNeedForceUpdate.isNeedUpdate()) {
      state = state.copyWith(isRequiredForceUpdate: true);
      return;
    }
    state = state.copyWith(isRedirectHome: true);
  }

  Future<String?> getVersionNumberFromDatabase() async {
    if (kIsWeb) return null;
    final response = await FirebaseCollections.version.reference
        .withConverter<NumberModel>(
          fromFirestore: (snapshot, options) => NumberModel().fromFirebase(snapshot),
          toFirestore: (value, options) => value.toJson(),
        )
        .doc(PlatformEnum.versionName)
        .get();

    return response.data()?.number;
  }
}

//aynı stateler gelmesi ve koruması adınan equatable ile sardık, referans eşitliğini kurtardık. Aynı statelerde değişen bir şey olmadığının farklı bunu
//değiştirmesi gerektiğini sağlıyor.
class SplashState extends Equatable {
  const SplashState({this.isRedirectHome, this.isRequiredForceUpdate});

  final bool? isRequiredForceUpdate;
  final bool? isRedirectHome;

  @override
  List<Object?> get props => [isRequiredForceUpdate, isRedirectHome];

  SplashState copyWith({
    bool? isRequiredForceUpdate,
    bool? isRedirectHome,
  }) {
    return SplashState(
      isRequiredForceUpdate: isRequiredForceUpdate ?? this.isRequiredForceUpdate,
      isRedirectHome: isRedirectHome ?? this.isRedirectHome,
    );
  }
}
