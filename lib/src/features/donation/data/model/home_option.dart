import 'package:flutter/cupertino.dart';

class HomeOption {
  final String optionName;
  final String iconUrl;
  final VoidCallback function;

  HomeOption({
    required this.optionName,
    required this.iconUrl,
    required this.function,
  });
}
