import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:icon_decoration/icon_decoration.dart';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:path_provider/path_provider.dart';
import 'package:share_extend/share_extend.dart';
import '../../../controller/quotes_controller.dart';

Padding likeAndShareButton(QuotesController quotesController) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 150.0),
    child: Align(
      alignment: Alignment.bottomCenter,
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
                  size: 40,
                ),
                decoration: const IconDecoration(
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

                  await ShareExtend.share(
                      fileImg.path, 'image');
                }
              }
            },
            icon: const DecoratedIcon(
              icon: Icon(
                Icons.share,
                color: Colors.white,
                size: 40,
              ),
              decoration: IconDecoration(
                  border: IconBorder(
                      color: Colors.black, width: 2)),
            ),
          ),
        ],
      ),
    ),
  );
}
