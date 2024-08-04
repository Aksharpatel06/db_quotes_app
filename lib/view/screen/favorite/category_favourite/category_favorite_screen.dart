import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/quotes_controller.dart';
import '../favourite_quotes/favorite_quotes_screen.dart';
import 'componects/favourite_quotes_category.dart';

class CategoryFavoriteScreen extends StatelessWidget {
  const CategoryFavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    QuotesController quotesController = Get.find();
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text("Favorite Category Quotes"),
        centerTitle: true,
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: quotesController.categoryFavoriteList.length,
          itemBuilder: (context, index) {
            return favoriteQuoteCategory(quotesController, index);
          },
        ),
      ),
    );
  }
}
