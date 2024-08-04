import 'package:db_quotes_app/view/controller/quotes_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'componects/floating_button.dart';
import 'componects/like_and_share.dart';
import 'componects/quote_pageview.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    QuotesController quotesController = Get.put(QuotesController());
    PageController pageController = PageController();

    return Scaffold(
      floatingActionButton: floatingTopButton(quotesController, context),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: Obx(
        () => quotesController.quotesRandomList.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Stack(
                children: [
                  quotePageView(quotesController, pageController),
                  likeAndShareButton(quotesController),
                ],
              ),
      ),
    );
  }
}
