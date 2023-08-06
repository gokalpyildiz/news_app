// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:news_app/feature/home/view/home_view.dart';
import 'package:news_app/feature/splash/splash_provider.dart';
import 'package:news_app/product/constants/index.dart';
import 'package:news_app/product/enums/image_constants.dart';
import 'package:news_app/product/widget/text/wavy_text.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView> with _SplashViewListenMixin {
  final splashProvider = StateNotifierProvider<SplashProvider, SplashState>((ref) {
    return SplashProvider();
  });
  @override
  void initState() {
    super.initState();
    //.notifier ile metotlara erişmiş oluyoruz.
    ref.read(splashProvider.notifier).checkApplicationVersion(''.version);
  }

  @override
  Widget build(BuildContext context) {
    // ref.listen(splashProvider, (previous, next) {
    //   if (next.isRequiredUpdate ?? false) {
    //     showAboutDialog(context: context);
    //     return;
    //   }

    //   if (next.isRedirectHome != null) {
    //     if (next.isRedirectHome!) {
    //       context.navigateToPage(const HomeView());
    //     } else {}
    //   }
    // });
    //mixine çevir
    listenAndNavigate(splashProvider);
    return Scaffold(
      backgroundColor: ColorConstants.purplePrimary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconConstants.appIcon.toImage,
            //Text(StringConstants.appName, style: context.textTheme.headlineSmall?.copyWith(color: ColorConstants.white, fontWeight: FontWeight.bold)),
            Padding(
              padding: context.onlyTopPaddingLow,
              child: const WavyBoldText(title: StringConstants.appName),
            ),
          ],
        ),
      ),
    );
  }
}


mixin _SplashViewListenMixin on ConsumerState<SplashView> {
  void listenAndNavigate(
    StateNotifierProvider<SplashProvider, SplashState> provider,
  ) {
    //state değişimini dinliyoruz herhalde. previous buygu ama artık o değil nextle gelen gibi birşey.Şimdilik previousla işimiz yok.
    ref.listen(provider, (previous, next) {
      if (next.isRequiredForceUpdate ?? false) {
        showAboutDialog(context: context);
        return;
      }
      if (next.isRedirectHome != null) {
        if (next.isRedirectHome!) {
          context.navigateToPage(const HomeView());
        } else {
          // false
        }
      }
    });
  }
}
