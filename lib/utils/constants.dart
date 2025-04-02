import 'package:flutter/material.dart';

class AppConstants {
  static const String appName = "Elevate Quote Generator";
  static const String version = "1.0.0";
  static const String apiBaseUrl = "https://api.quotable.io";
  static const String translationApiUrl = "https://api-free.deepl.com/v2/translate";
  static const String motivationalQuotesUrl = "https://positivepsychology.com/motivational-quotes/";
  static const String inspirationalQuotesUrl = "https://www.psychologytoday.com/us/blog/click-here-happiness/202001/40-inspirational-quotes-to-motivate-you";
  static const String ncbiArticleUrl = "https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6124950/";
  static const Color favoriteBtn = Colors.yellow;
  static const Color dislikeBtn = Colors.red;
  static const Color likeBtn = Colors.green;
  static const Color urlDecoration = Colors.blue;
  static const TextStyle txtBase = TextStyle(
    fontSize: 16,
  );
  static const Color addQuoteBtnIconColorDark = Colors.white;
  static const Color addQuoteBtnIconColorLight = Colors.white; 
}