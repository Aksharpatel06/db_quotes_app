import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:stroke_text/stroke_text.dart';

import '../../../controller/quotes_controller.dart';
import 'componects/dislike_and_share.dart';

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
                  Align(
                    alignment: Alignment.topCenter,
                    child: RepaintBoundary(
                      key: quotesController
                          .categoryFavoriteDetailsList[index].imgKey,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: Container(
                            height: 400,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                image: DecorationImage(
                                    image: AssetImage(quotesController
                                        .categoryFavoriteDetailsList[index]
                                        .img),
                                    fit: BoxFit.cover),
                                borderRadius: BorderRadius.circular(15)),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  StrokeText(
                                    text: quotesController
                                        .categoryFavoriteDetailsList[index]
                                        .quote,
                                    strokeColor: Colors.black,
                                    maxLines: 4,
                                    textStyle: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  StrokeText(
                                    text:
                                        "- ${quotesController.categoryFavoriteDetailsList[index].author}",
                                    strokeColor: Colors.black,
                                    textStyle: const TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
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
