import 'package:db_quotes_app/view/controller/quotes_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'componect/quotes_category.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

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
        title: const Text("Category"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: quotesController.categoryList.length,
        itemBuilder: (context, index) {
          return quoteCategory(quotesController, index);
        },
      ),
    );
  }
}
