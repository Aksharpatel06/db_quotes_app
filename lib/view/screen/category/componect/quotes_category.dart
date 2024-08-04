import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/quotes_controller.dart';

Padding quoteCategory(QuotesController quotesController, int index) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Card(
      child: ListTile(
        leading: const Icon(Icons.format_quote_rounded),
        trailing: IconButton(
            onPressed: () {
              quotesController
                  .categoryListAdd(quotesController.categoryList[index]);
              Get.back();
            },
            icon: const Icon(Icons.navigate_next)),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(quotesController.categoryList[index]),
          ],
        ),
      ),
    ),
  );
}
