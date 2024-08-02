import 'package:db_quotes_app/view/screen/favorite/favorite_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/quotes_controller.dart';

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
            print('hello');
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
          },
        ),
      ),
    );
  }
}
