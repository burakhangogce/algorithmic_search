import 'package:algorithmic_search/enums/search_sheet_type.dart';
import 'package:flutter/material.dart';

class SearchSheetController<T> extends ChangeNotifier {
  final SearchSheetType type;
  List<T> selectedItems = [];

  SearchSheetController({this.type = SearchSheetType.singleSelect});

  void toggleSelection(T item) {
    if (type == SearchSheetType.singleSelect) {
      selectedItems = [item];
    } else {
      if (selectedItems.contains(item)) {
        selectedItems.remove(item);
      } else {
        selectedItems.add(item);
      }
    }
    notifyListeners();
  }

  void clearSelections() {
    selectedItems.clear();
    notifyListeners();
  }
}
