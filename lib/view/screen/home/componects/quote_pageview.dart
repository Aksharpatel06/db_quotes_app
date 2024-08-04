import 'package:flutter/material.dart';
import 'package:stroke_text/stroke_text.dart';

import '../../../controller/quotes_controller.dart';

PageView quotePageView(QuotesController quotesController, PageController pageController) {
  return PageView.builder(
    scrollDirection: Axis.vertical,
    itemCount: quotesController.quotesRandomList.length,
    controller: pageController,
    onPageChanged: (index) {
      quotesController.changeIndex(index);
    },
    itemBuilder: (context, index) {
      return RepaintBoundary(
        key: quotesController.quotesRandomList[index].imgKey,
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            image: quotesController
                .quotesRandomList[index].category ==
                "Kindness"
                ? null
                : DecorationImage(
                image: AssetImage(quotesController
                    .quotesRandomList[index].img),
                fit: BoxFit.cover),
            color: quotesController
                .quotesRandomList[index].category ==
                "Kindness"
                ? Colors.red
                : null,
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StrokeText(
                  text: quotesController
                      .quotesRandomList[index].quote,
                  strokeColor: Colors.black,
                  textStyle: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                const SizedBox(
                  height: 10,
                ),
                StrokeText(
                  text:
                  "- ${quotesController.quotesRandomList[index].author}",
                  strokeColor: Colors.black,
                  textStyle: const TextStyle(
                      fontSize: 22, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
