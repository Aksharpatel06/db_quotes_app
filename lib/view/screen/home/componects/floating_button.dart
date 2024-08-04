import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';

import '../../../controller/quotes_controller.dart';
import '../../category/category_screen.dart';
import '../../favorite/category_favourite/category_favorite_screen.dart';

Padding floatingTopButton(QuotesController quotesController, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      shape: const CircleBorder(),
      direction: SpeedDialDirection.down,
      spacing: 12,
      curve: Curves.easeInCubic,
      animationDuration: const Duration(milliseconds: 500),
      gradientBoxShape: BoxShape.circle,
      children: [
        SpeedDialChild(
          shape: const CircleBorder(),
          onTap: () {
            Get.to(() => const CategoryFavoriteScreen(),
                duration: const Duration(milliseconds: 500),
                transition: Transition.upToDown);
          },
          child: const Icon(Icons.favorite_border),
        ),
        SpeedDialChild(
          shape: const CircleBorder(),
          onTap: () {
            Get.to(() => const CategoryScreen(),
                duration: const Duration(milliseconds: 500),
                transition: Transition.downToUp);
          },
          child: const Icon(Icons.category),
        ),
        SpeedDialChild(
          shape: const CircleBorder(),
          onTap: () {
            quotesController.getRandomQuotes();
          },
          child: const Icon(Icons.refresh),
        ),
        SpeedDialChild(
          shape: const CircleBorder(),
          onTap: () {
            showModalBottomSheet(
              context: context,
              builder: (context) => SizedBox(
                height: 500,
                width: 500,
                child: Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: 10,
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, childAspectRatio: 9 / 13),
                    itemBuilder: (context, index) => CupertinoButton(
                      onPressed: () {
                        quotesController.changeImage(index);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 150,
                          width: 100,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                  image: AssetImage(
                                      "asset/project/${quotesController.quotesRandomList[quotesController.screenIndex.value].category}/image${index + 1}.jpeg"),
                                  fit: BoxFit.cover)),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
          child: const Icon(Icons.image),
        ),
      ],
    ),
  );
}
