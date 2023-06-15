// ignore_for_file: lines_longer_than_80_chars

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:news_app/feature/home/model/news.dart';
import 'package:news_app/product/utility/exception/custom_exception.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  //1 Future builder
  //2 datayı init olduğu anda çekip setstate ile göstermek
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const _HomeListView(),
    );
  }
}

class _HomeListView extends StatelessWidget {
  const _HomeListView();

  @override
  Widget build(BuildContext context) {
    // ignore: lines_longer_than_80_chars
    final CollectionReference news = FirebaseFirestore.instance.collection('news');
    final response = news.withConverter(
      fromFirestore: (snapshot, options) {
        //final jsonBody = snapshot.data();
        // if (jsonBody != null) {
        //   //.. ne işe yarıyor anlamadım herhalde geri döndürüyoe debug modda bakarsın.
        //   return News.fromJson(jsonBody)..copyWith();
        // }
        // return null;
        //üstteki kullanımın temiz hali-copyWith() içinen id falan da girmemiz lazımdı
        //yukakrısı tamamlanmış hali değil
        return const News().fromFirebase(snapshot);
      },
      toFirestore: (value, options) {
        if (value == null) FirebaseCustomException('Value not null');
        return value.toJson();
      },
    ).get();
    return FutureBuilder(
      //future: news.get(),
      future: response,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return const Placeholder();
          case ConnectionState.waiting:
          case ConnectionState.active:
            return const LinearProgressIndicator();
          case ConnectionState.done:
            if (snapshot.hasData) {
              // ignore: lines_longer_than_80_chars
              final values = snapshot.data!.docs.map((e) => e.data()).toList();
              return ListView.builder(
                itemCount: values.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Column(
                      children: [
                        Image.network(
                          values[index].backgroundImage ?? '',
                          height: context.dynamicHeight(0.1),
                        ),
                        Text(values[index].title ?? '', style: context.textTheme.labelLarge)
                      ],
                    ),
                  );
                },
              );
            } else {
              return const SizedBox();
            }
        }
      },
    );
  }
}
