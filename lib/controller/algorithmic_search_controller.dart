import 'package:algorithmic_search/enums/search_sheet_type.dart';
import 'package:flutter/material.dart';

/// `SearchSheetController` manages selected items for both single and multi-select modes.
/// It notifies listeners when the selection changes.
class SearchSheetController<T> extends ChangeNotifier {
  /// The selection mode of the search sheet (singleSelect or multiSelect).
  final SearchSheetType type;

  /// List of selected items.
  List<T> selectedItems = [];

  /// Creates a new `SearchSheetController`.
  /// [type] defaults to `singleSelect`.
  SearchSheetController({this.type = SearchSheetType.singleSelect});

  /// Toggles the selection of the specified [item].
  /// In `singleSelect` mode, only one item can be selected at a time.
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

  /// Clears all selected items and notifies listeners.
  void clearSelections() {
    selectedItems.clear();
    notifyListeners();
  }
}
