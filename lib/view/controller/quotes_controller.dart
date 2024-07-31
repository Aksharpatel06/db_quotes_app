
import 'dart:convert';
import 'dart:math';

import 'package:db_quotes_app/view/helper/api_sarvice.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../modal/quotes_modal.dart';

class QuotesController extends GetxController{

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getDataToApi();
  }

  RxList<QuotesModal> quotesList = <QuotesModal>[].obs;
  RxList<QuotesModal> quotesRandomList = <QuotesModal>[].obs;
  RxList<QuotesModal> quotesFavoriteList = <QuotesModal>[].obs;

  GlobalKey imgKey = GlobalKey();
  RxInt screenIndex =0.obs;

  void changeIndex(int index)
  {
    screenIndex.value = index;
  }


  Future<void> getDataToApi()
  async {
    String? json = await ApiSarvice.apiSarvice.fetchData();
    List jsonData = jsonDecode(json!);

    if(jsonData.isNotEmpty)
      {
        quotesList.value = jsonData.asMap()
            .entries
        .map((e) => QuotesModal(e.value,e.key),).toList();
        getRandomQuotes();
        print(quotesRandomList);
      }
  }

  void getRandomQuotes() {
    Random random = Random();
    Set<int> selectedIndices = {};
    while (selectedIndices.length < 20) {
      selectedIndices.add(random.nextInt(quotesList.length));
    }
    quotesRandomList.value = selectedIndices.map((index) => quotesList[index]).toList();
  }


  void favoriteQuotes() {
    var quote = quotesRandomList[screenIndex.value];
    quote.isLiked = !quote.isLiked;
    quotesList[quote.index].isLiked = quote.isLiked;

    if (quote.isLiked) {
      quotesFavoriteList.add(quote);
    } else {
      quotesFavoriteList.remove(quote);
    }

    quotesRandomList.refresh();
    quotesList.refresh();
  }

}