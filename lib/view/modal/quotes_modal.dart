import 'package:flutter/material.dart';

class QuotesModal {
  String quote, author, category;
  int index;
  bool isLiked;
  String img;
  GlobalKey imgKey;

  QuotesModal._({
    required this.quote,
    required this.author,
    required this.category,
    required this.isLiked,
    required this.imgKey,
    required this.img,
    required this.index,
  });

  factory QuotesModal(Map json, int index) {
    return QuotesModal._(
      quote: json['quote'] ?? 'Love is a game that two can play and both win.',
      author: json['author'],
      category: json['category'],
      isLiked: false,
      imgKey: GlobalKey(),
      img:
          "asset/project/${json['category']}/image${index % 10 == 0 ? 10 : index % 10}.jpeg",
      index: index,
    );
  }
}
