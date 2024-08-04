import 'dart:async';
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
  }

  RxList<QuotesModal> quotesList = <QuotesModal>[].obs;
  RxList<String> categoryList = <String>[].obs;
  RxList<String> categoryFavoriteList = <String>[].obs;
  RxList<QuotesModal> categoryFavoriteDetailsList = <QuotesModal>[].obs;
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
      quotesList.value = jsonData
          .asMap()
          .entries
          .map(
            (e) => QuotesModal(e.value, e.key),
          )
          .toList();
      Set<String> catogerySet = {};

      for (var element in quotesList) {
        catogerySet.add(element.category);
      }
      categoryList.value = catogerySet.toList();

      getRandomQuotes();
      readDatabase();
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
    readDatabase();
  }

  void categoryFavoriteListAdd(String catogery) {
    categoryFavoriteDetailsList.clear();
    for (var element in quotesFavoriteList) {
      if (element.category == catogery) {
        categoryFavoriteDetailsList.add(element);
      }
    }
    categoryFavoriteDetailsList.refresh();
  }

  Future<void> readDatabase() async {
    quotesFavoriteList.clear();
    categoryFavoriteList.clear();
    List favoriteList = await DatabaseService.databaseService.readData();
    quotesFavoriteList.value = favoriteList
        .asMap()
        .entries
        .map((e) => QuotesModal(e.value, e.key))
        .toList();
    Set<String> catogeryFavoriteSet = {};
    quotesFavoriteList.refresh();
    print(quotesFavoriteList);

    for (var element in quotesFavoriteList) {
      catogeryFavoriteSet.add(element.category);
    }
    categoryFavoriteList.value = catogeryFavoriteSet.toList();
    print(categoryFavoriteList);
    categoryFavoriteList.refresh();
  }

  void removeLike(int index) {
    var quote = categoryFavoriteDetailsList[index];
    quote.isLiked = !quote.isLiked;
    categoryFavoriteDetailsList[index].isLiked = quote.isLiked;
    quotesList[quote.index].isLiked = quote.isLiked;
    for (var quotes in quotesFavoriteList) {
      if (quotes.quote == quote.quote) {
        quotes.isLiked = quote.isLiked;
        DatabaseService.databaseService.removeData(quote.quote);
        categoryFavoriteDetailsList.removeAt(index);
      }
    }

    for (var quotes in quotesRandomList) {
      if (quotes.quote == quote.quote) {
        quotes.isLiked = false;
        print(quotes.quote);
      }
    }
    update();

    readDatabase();

    quotesFavoriteList.refresh();
    categoryFavoriteDetailsList.refresh();
    quotesRandomList.refresh();
    quotesList.refresh();
  }

  void changeImage(int index) {
    quotesRandomList[screenIndex.value].img =
        "asset/project/${quotesRandomList[screenIndex.value].category}/image${index + 1}.jpeg";
    quotesRandomList.refresh();
  }
}
