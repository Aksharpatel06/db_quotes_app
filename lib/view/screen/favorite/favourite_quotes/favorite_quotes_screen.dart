import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../../controller/quotes_controller.dart';
import 'componects/dislike_and_share.dart';
import 'componects/favorite_quotes_author.dart';

class FavouriteQuoteScreen extends StatelessWidget {
  const FavouriteQuoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    QuotesController quotesController = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite"),
        centerTitle: true,
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: quotesController.categoryFavoriteDetailsList.length,
          itemBuilder: (context, index) {
            return SizedBox(
              height: 400,
              child: Stack(
                children: [
                  favoriteQuoteAndAuthor(quotesController, index),
                  dislikeAndShare(quotesController, index),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
