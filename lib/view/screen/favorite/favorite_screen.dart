import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_extend/share_extend.dart';
import 'package:stroke_text/stroke_text.dart';

import '../../controller/quotes_controller.dart';

class FavouriteQuoteScreen extends StatelessWidget {
  const FavouriteQuoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    QuotesController quotesController = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Category Name"),
        centerTitle: true,
      ),
      body: Obx(
        ()=> ListView.builder(
          itemCount: quotesController.quotesFavoriteList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Container(
                  height: 300,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      image: DecorationImage(
                          image: AssetImage(
                              quotesController.quotesFavoriteList[index].img),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(15)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            StrokeText(
                              text: quotesController.quotesRandomList[index].quote,
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
                                  "- ${quotesController.quotesRandomList[index].author}",
                              strokeColor: Colors.black,
                              textStyle:
                                  const TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                          const Spacer(),
                      Container(
                        height: 60,
                        decoration: const BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Obx(
                              ()=> CupertinoButton(
                                onPressed: () {
                                  quotesController.removeLike(index);
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      quotesController
                                              .quotesRandomList[quotesController
                                                  .screenIndex.value]
                                              .isLiked
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: quotesController
                                              .quotesRandomList[quotesController
                                                  .screenIndex.value]
                                              .isLiked
                                          ? Colors.redAccent
                                          : Colors.white,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    const Text('Like',
                                        style: TextStyle(color: Colors.white)),
                                  ],
                                ),
                              ),
                            ),
                            CupertinoButton(
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

                                    await ShareExtend.share(
                                        fileImg.path, 'image');
                                  }
                                }
                              },
                              child: const Row(
                                children: [
                                  Icon(
                                    Icons.share,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text('Like',
                                      style: TextStyle(color: Colors.white)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
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
