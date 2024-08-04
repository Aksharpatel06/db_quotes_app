import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:share_extend/share_extend.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import '../../../../controller/quotes_controller.dart';

Align dislikeAndShare(QuotesController quotesController, int index) {
  return Align(
    alignment: Alignment.bottomCenter,
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        height: 60,
        decoration: const BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CupertinoButton(
              onPressed: () {
                quotesController.removeLike(index);
              },
              child: const Row(
                children: [
                  Icon(
                    Icons.favorite,
                    color: Colors.redAccent,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text('Like', style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
            CupertinoButton(
              onPressed: () async {
                final boundary = quotesController
                    .categoryFavoriteDetailsList[index].imgKey.currentContext!
                    .findRenderObject() as RenderRepaintBoundary?;

                if (boundary != null) {
                  ui.Image image = await boundary.toImage();

                  ByteData? byteData =
                      await image.toByteData(format: ui.ImageByteFormat.png);

                  if (byteData != null) {
                    final imgData = byteData.buffer.asUint8List();

                    final directory = await getApplicationDocumentsDirectory();

                    File fileImg = File(
                        "${directory.path}/flutter/${DateTime.now().millisecondsSinceEpoch}.png");
                    fileImg.createSync(recursive: true);

                    fileImg.writeAsBytesSync(imgData);

                    await ShareExtend.share(fileImg.path, 'image');
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
                  Text('Like', style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
