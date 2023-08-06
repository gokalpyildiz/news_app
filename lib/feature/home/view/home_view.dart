// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:news_app/feature/home/provider/home_provider.dart';
import 'package:news_app/feature/home/view/subview/home_news_card.dart';
import 'package:news_app/feature/home/view/subview/home_search_delegate.dart';
import 'package:news_app/feature/home_create/home_create_view.dart';
import 'package:news_app/product/constants/color_constants.dart';
import 'package:news_app/product/constants/string_constants.dart';
import 'package:news_app/product/models/tag.dart';
import 'package:news_app/product/widget/card/recommended_card.dart';
import 'package:news_app/product/widget/text/sub_title_text.dart';
import 'package:news_app/product/widget/text/title_text.dart';

part './subview/home_chips.dart';

//bunu splashde içeri yazmıştık burad dışarıya yazdık. neden olduğunu tam bilmiyor ama genelde dışarıya yazıyorlarmış emre altunbilekten bak
final _homeProvider = StateNotifierProvider<HomeNotifier, HomeState>((ref) {
  return HomeNotifier();
});

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(_homeProvider.notifier).fetchAndLoad();
    });
    //selectedtag değişince gel set et
    ref.read(_homeProvider.notifier).addListener((state) {
      if (state.selectedTag != null) {
        _controller.text = state.selectedTag?.name ?? '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('Build oldu');//mediaquey.ofsize kullan
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () async {
              final response = await context.navigateToPage<bool?>(
                const HomeCreateView(),
                type: SlideType.BOTTOM,
              );

              if (response ?? false) {
                await ref.read(_homeProvider.notifier).fetchAndLoad();
              }
            },
          ),
          body: SafeArea(
            child: Stack(
              children: [
                ListView(
                  padding: context.paddingNormal,
                  children: [
                    const _Header(),
                    _CustomField(_controller),
                    const _TagListView(),
                    const _BrowseHorizontalListView(),
                    const _RecommendedHeader(),
                    const _RecommendedListView(),
                  ],
                ),
                if (ref.watch(_homeProvider).isLoading ?? false) const Center(child: CircularProgressIndicator())
              ],
            ),
          ),
        );
      },
    );
  }
}

class _CustomField extends ConsumerWidget {
  const _CustomField(this.controller);
  final TextEditingController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
      controller: controller,
      onTap: () async {
        final response = await showSearch<Tag?>(
          context: context,
          delegate: HomeSearchDelegate(
            ref.read(_homeProvider.notifier).fullTagList,
          ),
        );
        ref.read(_homeProvider.notifier).updateSelectedTag(response);
      },
      decoration: const InputDecoration(
        suffixIcon: Icon(Icons.mic_outlined),
        prefixIcon: Icon(Icons.search_off_outlined),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: ColorConstants.grayLighter,
        hintText: StringConstants.homeSearchHint,
      ),
    );
  }
}

class _TagListView extends ConsumerWidget {
  const _TagListView();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newsItems = ref.watch(_homeProvider).tags ?? [];
    return SizedBox(
      height: context.dynamicHeight(.1),
      child: ListView.builder(
        itemCount: newsItems.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          final tagItem = newsItems[index];
          if (tagItem.active ?? false) {
            return _ActiveChip(tagItem);
          }
          return _PassiveChip(tagItem);
        },
      ),
    );
  }
}

//bu widget normalde stataless widgettı.refe erişemediğimiz için consumerwidgeta çevirdik. ConsumerStatefulWidget ın stateless hali gibi herhalde.
class _BrowseHorizontalListView extends ConsumerWidget {
  const _BrowseHorizontalListView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newsItems = ref.watch(_homeProvider).news;
    return SizedBox(
      height: context.dynamicHeight(.3),
      child: ListView.builder(
        itemCount: newsItems?.length ?? 0,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return HomeNewsCard(newsItem: newsItems?[index]);
        },
      ),
    );
  }
}

class _RecommendedHeader extends StatelessWidget {
  const _RecommendedHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.onlyTopPaddingLow,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Expanded(
            child: TitleText(value: StringConstants.homeTitle),
          ),
          TextButton(
            onPressed: () {},
            child: const SubTitleText(value: StringConstants.homeSeeAll),
          )
        ],
      ),
    );
  }
}

class _RecommendedListView extends ConsumerWidget {
  const _RecommendedListView();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final values = ref.watch(_homeProvider).recommended ?? [];
    return ListView.builder(
      itemCount: values.length,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return RecommendedCard(recommended: values[index]);
      },
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TitleText(
          value: StringConstants.homeBrowse,
        ),
        Padding(
          padding: context.onlyTopPaddingLow,
          child: const SubTitleText(
            value: StringConstants.homeMessage,
          ),
        ),
      ],
    );
  }
}
