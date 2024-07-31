import 'package:flutter/material.dart';

class QuotesModal {
  String quote, author, category;
  int  index;
  bool isLiked;
  GlobalKey imgKey;

  QuotesModal._({
    required this.quote,
    required this.author,
    required this.category,
    required this.isLiked,
    required this.imgKey,
    required this.index,
  });

  factory QuotesModal(Map json, int index) {
    return QuotesModal._(
      quote: json['quote'],
      author: json['author'],
      category: json['category'],
      isLiked: false,
      imgKey: GlobalKey(),
      index: index,
    );
  }
}
