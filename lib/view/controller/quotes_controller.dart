import 'dart:convert';
import 'dart:math';

import 'package:db_quotes_app/view/helper/api_sarvice.dart';
import 'package:db_quotes_app/view/helper/database_sarvice.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../modal/quotes_modal.dart';

class QuotesController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getDataToApi();
    readDatabase();
  }

  RxList<QuotesModal> quotesList = <QuotesModal>[].obs;
  RxList<String> categoryList = <String>[].obs;
  RxList<QuotesModal> quotesRandomList = <QuotesModal>[].obs;
  RxList<QuotesModal> quotesFavoriteList = <QuotesModal>[].obs;

  GlobalKey imgKey = GlobalKey();
  RxInt screenIndex = 0.obs;

  void changeIndex(int index) {
    screenIndex.value = index;
  }

  Future<void> getDataToApi() async {
    String? json = await ApiSarvice.apiSarvice.fetchData();
    List jsonData = jsonDecode(json!);

    if (jsonData.isNotEmpty) {
      Set<String> catogerySet = {};
      quotesList.value = jsonData
          .asMap()
          .entries
          .map(
            (e) => QuotesModal(e.value, e.key),
          )
          .toList();

      for (var element in quotesList) {
        catogerySet.add(element.category);
      }
      categoryList.value = catogerySet.toList();

      getRandomQuotes();
    }
  }

  void getRandomQuotes() {
    quotesRandomList.clear();
    quotesRandomList.refresh();
    Random random = Random();
    Set<int> selectedIndices = {};
    while (selectedIndices.length < 16) {
      selectedIndices.add(random.nextInt(quotesList.length));
    }
    quotesRandomList.value =
        selectedIndices.map((index) => quotesList[index]).toList();
  }

  void favoriteQuotes() {
    var quote = quotesRandomList[screenIndex.value];
    quote.isLiked = !quote.isLiked;
    quotesList[quote.index].isLiked = quote.isLiked;

    if (quote.isLiked) {
      DatabaseService.databaseService.insertData(
          quotesList[quote.index].quote,
          quotesList[quote.index].author,
          quotesList[quote.index].isLiked,
          quotesList[quote.index].category,
          quotesList[quote.index].img,

      );
    } else {
      DatabaseService.databaseService.removeData(quote.quote);
    }
    readDatabase();
    print(quotesFavoriteList);

    quotesRandomList.refresh();
    quotesList.refresh();
  }

  void categoryListAdd(String catogery) {
    quotesRandomList.clear();
    quotesRandomList.refresh();

    for (var element in quotesList) {
      if (element.category == catogery) {
        quotesRandomList.add(element);
      }
    }
    quotesRandomList.refresh();
  }

  Future<void> readDatabase() async {
    List favoriteList = await DatabaseService.databaseService.readData();
    quotesFavoriteList.value = favoriteList
        .asMap()
        .entries
        .map((e) => QuotesModal(e.value, e.key))
        .toList();
    quotesFavoriteList.refresh();
  }

  void removeLike(int index)
  {
    var quote = quotesFavoriteList[index];
    quote.isLiked = !quote.isLiked;
    quotesFavoriteList[index].isLiked = quote.isLiked;
    quotesList[quote.index].isLiked = quote.isLiked;

    if (quote.isLiked) {
      DatabaseService.databaseService.insertData(
        quotesList[quote.index].quote,
        quotesList[quote.index].author,
        quotesList[quote.index].isLiked,
        quotesList[quote.index].category,
        quotesList[quote.index].img,
      );
    } else {
      DatabaseService.databaseService.removeData(quote.quote);
    }
    readDatabase();

    quotesFavoriteList.refresh();
    quotesRandomList.refresh();
    quotesList.refresh();
  }

}
