import 'package:db_quotes_app/view/controller/quotes_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: ListTile(
                leading: const Icon(Icons.format_quote_rounded),
                trailing: IconButton(onPressed: () {
                  quotesController.categoryListAdd(quotesController.categoryList[index]);
                  Get.back();
                },icon: const Icon(Icons.navigate_next)),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(quotesController.categoryList[index]),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
