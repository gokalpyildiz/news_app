// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:news_app/feature/home_create/home_logic.dart';
import 'package:news_app/product/constants/color_constants.dart';
import 'package:news_app/product/constants/string_constants.dart';
import 'package:news_app/product/enums/widget_size.dart';

import 'package:news_app/product/models/category.dart';

class HomeCreateView extends StatefulWidget {
  const HomeCreateView({super.key});
  @override
  State<HomeCreateView> createState() => _HomeCreateViewState();
}

class _HomeCreateViewState extends State<HomeCreateView> with Loading {
  late final HomeLogic _homeLogic;
  @override
  void initState() {
    super.initState();
    _homeLogic = HomeLogic();
    _fetchInitialCategory();
  }

  Future<void> _fetchInitialCategory() async {
    await _homeLogic.fetchAllCategory();
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    _homeLogic.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(StringConstants.addItemTitle),
        centerTitle: false,
        actions: [
          if (isLoading)
            const Center(
              child: CircularProgressIndicator(
                color: ColorConstants.white,
              ),
            )
        ],
      ),
      body: Form(
        key: _homeLogic.formKey,
        onChanged: () {
          _homeLogic.checkValidateAndSave(
            (value) {
              setState(() {});
            },
          );
        },
        autovalidateMode: AutovalidateMode.always,
        child: Padding(
          padding: context.paddingLow,
          child: ListView(
            children: [
              _HomeCategoryDropDown(
                categories: _homeLogic.categories,
                onSelected: _homeLogic.updateCategory,
              ),
              const _EmptySizeBox(),
              TextFormField(
                controller: _homeLogic.titleController,
                validator: (value) => value.isNullOrEmpty ? 'Not empty' : null,
                decoration: const InputDecoration(
                  hintText: StringConstants.addItemTitle,
                  border: OutlineInputBorder(),
                ),
              ),
              const _EmptySizeBox(),
              InkWell(
                onTap: () async {
                  await _homeLogic.pickAndCheck(
                    (value) {
                      setState(() {});
                    },
                  );
                },
                child: SizedBox(
                  height: context.dynamicHeight(0.2),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: ColorConstants.grayPrimary,
                      ),
                    ),
                    child:
                        _homeLogic.selectedFileBytes != null ? Image.memory(_homeLogic.selectedFileBytes!) : const Icon(Icons.add_a_photo_outlined),
                  ),
                ),
              ),
              const _EmptySizeBox(),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size.fromHeight(WidgetSize.buttonNormal.value.toDouble()),
                ),
                onPressed: !_homeLogic.isValidateAllForm
                    ? null
                    : () async {
                        changeLoading();
                        final response = await _homeLogic.save();
                        changeLoading();
                        if (!mounted) return;
                        //response döndürmesi ne anlama geliyor ne işe yarıyor anlamadım. Buraya gelen navigatein respose una bu değer gidiyor bool değil başka değer
                        //de olabilirdi. Hiç kullandığım bir yöntem değil.Ama güzel kullanım.
                        await context.pop<bool>(response);
                      },
                icon: const Icon(Icons.send),
                label: const Text(StringConstants.buttonSave),
              )
            ],
          ),
        ),
      ),
    );
  }
}

//sayfadaki emtysizedboxların yönetimini kolaylaştırmak için.
class _EmptySizeBox extends StatelessWidget {
  const _EmptySizeBox();

  @override
  Widget build(BuildContext context) {
    return context.emptySizedHeightBoxLow;
  }
}

class _HomeCategoryDropDown extends StatelessWidget {
  const _HomeCategoryDropDown({
    required this.categories,
    required this.onSelected,
  });
  final List<CategoryModel> categories;
  //CategoryModel vericem
  final ValueSetter<CategoryModel> onSelected;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<CategoryModel>(
      validator: (value) => value == null ? 'Not empty' : null,
      items: categories.map((e) {
        return DropdownMenuItem<CategoryModel>(
          value: e,
          child: Text(e.name ?? ''),
        );
      }).toList(),
      hint: const Text(StringConstants.dropdownHint),
      onChanged: (value) {
        if (value == null) return;
        onSelected.call(value);
      },
    );
  }
}

mixin Loading on State<HomeCreateView> {
  bool isLoading = false;
  void changeLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }
}
