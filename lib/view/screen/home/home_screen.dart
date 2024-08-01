import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:db_quotes_app/view/controller/quotes_controller.dart';
import 'package:db_quotes_app/view/screen/category/category_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:icon_decoration/icon_decoration.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_extend/share_extend.dart';
import 'package:stroke_text/stroke_text.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    QuotesController quotesController = Get.put(QuotesController());
    PageController pageController = PageController();

    return Scaffold(
      floatingActionButton: Padding(
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
              onTap: () {},
              child: const Icon(Icons.favorite_border),
            ),
            SpeedDialChild(
              shape: const CircleBorder(),
              onTap: () {
                Get.to(() => const CategoryScreen(),
                    duration: const Duration(milliseconds: 500),
                    transition: Transition.leftToRight);
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
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: Obx(
        () => quotesController.quotesRandomList.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Stack(
                children: [
                  PageView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: quotesController.quotesRandomList.length,
                    controller: pageController,
                    onPageChanged: (index) {
                      quotesController.changeIndex(index);
                    },
                    itemBuilder: (context, index) {
                      Random random = Random();
                      int randomNumber = random.nextInt(10) + 1;
                      print(quotesController.quotesRandomList[index].img);
                      print(
                          'asset/project/${quotesController.quotesRandomList[index].category}/image$randomNumber.jpeg');
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
                  ),
                  Positioned(
                    bottom: 50, // Adjust this value as needed
                    left: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              quotesController.favoriteQuotes();
                            },
                            icon: DecoratedIcon(
                              icon: Icon(
                                quotesController
                                        .quotesRandomList[
                                            quotesController.screenIndex.value]
                                        .isLiked
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: quotesController
                                        .quotesRandomList[
                                            quotesController.screenIndex.value]
                                        .isLiked
                                    ? Colors.redAccent
                                    : Colors.white,
                                size: 40,
                              ),
                              decoration: IconDecoration(
                                  border: IconBorder(
                                      color: Colors.black, width: 2)),
                            )),
                        IconButton(
                          onPressed: () async {
                            final boundary = quotesController
                                .quotesRandomList[
                                    quotesController.screenIndex.value]
                                .imgKey
                                .currentContext!
                                .findRenderObject() as RenderRepaintBoundary?;

                            if (boundary != null) {
                              ui.Image image = await boundary.toImage();

                              ByteData? byteData = await image.toByteData(
                                  format: ui.ImageByteFormat.png);

                              if (byteData != null) {
                                final imgData = byteData.buffer.asUint8List();

                                final directory =
                                    await getApplicationDocumentsDirectory();

                                File fileImg = File(
                                    "${directory.path}/flutter/${DateTime.now().millisecondsSinceEpoch}.png");
                                fileImg.createSync(recursive: true);

                                fileImg.writeAsBytesSync(imgData);

                                await ShareExtend.share(fileImg.path, 'image');
                              }
                            }
                          },
                          icon: DecoratedIcon(
                            icon: Icon(
                              Icons.share,
                              color: Colors.white,
                              size: 40,
                            ),
                            decoration: IconDecoration(
                                border:
                                    IconBorder(color: Colors.black, width: 2)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
