import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/quotes_controller.dart';
import '../../favourite_quotes/favorite_quotes_screen.dart';

Padding favoriteQuoteCategory(QuotesController quotesController, int index) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Card(
      child: ListTile(
        leading: const Icon(Icons.format_quote_rounded),
        trailing: IconButton(
            onPressed: () {
              quotesController.categoryFavoriteListAdd(
                  quotesController.categoryFavoriteList[index]);

              Get.to(() => const FavouriteQuoteScreen(),
                  transition: Transition.upToDown,
                  duration: const Duration(milliseconds: 500));
            },
            icon: const Icon(Icons.navigate_next)),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(quotesController.categoryFavoriteList[index]),
          ],
        ),
      ),
    ),
  );
}
