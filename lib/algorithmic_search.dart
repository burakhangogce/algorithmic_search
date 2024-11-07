library algorithmic_search;

import 'package:algorithmic_search/controller/algorithmic_search_controller.dart';
import 'package:algorithmic_search/enums/search_sheet_type.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// `SearchSheet` is a widget for handling search and selection functionality.
/// Supports both single selection (`singleSelect`) and multiple selection (`multiSelect`) modes.
class SearchSheet<T> extends StatefulWidget {
  /// List of items to display and search through.
  final List<T> items;

  /// The controller managing selection actions.
  final SearchSheetController<T> controller;

  /// Determines if the widget should function as a dialog or a full page.
  final bool asDialog;

  /// The height of the widget when used as a dialog.
  final double height;

  /// The width of the widget when used as a dialog.
  final double width;

  /// Function defining the search criteria.
  final bool Function(T item, String query) searchCriteria;

  /// Builder function for each item widget.
  final Widget Function(BuildContext context, T item) itemBuilder;

  /// Callback when an item is selected.
  final void Function(T item)? onItemSelected;

  /// Decoration for the search field.
  final InputDecoration? searchFieldDecoration;

  /// Label text for the search field.
  final String labelText;

  /// Padding around the widget.
  final EdgeInsets padding;

  /// Horizontal spacing between selected items.
  final double spacing;

  /// Vertical spacing between selected items.
  final double runSpacing;

  /// Controls whether selected items are shown at the top.
  final bool showSelectedItems;

  /// Creates a new `SearchSheet`.
  const SearchSheet({
    super.key,
    required this.items,
    required this.controller,
    required this.searchCriteria,
    required this.itemBuilder,
    this.onItemSelected,
    this.asDialog = false,
    this.height = 500,
    this.width = double.infinity,
    this.searchFieldDecoration,
    this.labelText = "Search",
    this.padding = const EdgeInsets.all(16.0),
    this.spacing = 8.0,
    this.runSpacing = 4.0,
    this.showSelectedItems = true,
  });

  @override
  SearchSheetState<T> createState() => SearchSheetState<T>();
}

class SearchSheetState<T> extends State<SearchSheet<T>> {
  /// List of items filtered based on the search query.
  List<T> filteredItems = [];

  /// The current search query.
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    filteredItems = widget.items;
  }

  /// Updates the search query and filters the items accordingly.
  void _updateSearch(String query) {
    setState(() {
      searchQuery = query;
      filteredItems = widget.items.where((item) => widget.searchCriteria(item, query)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: widget.controller,
      child: Container(
        height: widget.asDialog ? widget.height : double.infinity,
        width: widget.asDialog ? widget.width : double.infinity,
        padding: widget.padding,
        child: Column(
          children: [
            TextField(
              onChanged: _updateSearch,
              decoration: widget.searchFieldDecoration ??
                  InputDecoration(labelText: widget.labelText, border: const OutlineInputBorder()),
            ),
            if (widget.controller.type == SearchSheetType.multiSelect && widget.showSelectedItems)
              Consumer<SearchSheetController<T>>(
                builder: (context, controller, child) {
                  return Wrap(
                    spacing: widget.spacing,
                    runSpacing: widget.runSpacing,
                    children: controller.selectedItems.map((item) {
                      return Chip(
                        label: Text(item.toString()),
                        deleteIcon: const Icon(Icons.close),
                        onDeleted: () => controller.toggleSelection(item),
                      );
                    }).toList(),
                  );
                },
              ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredItems.length,
                itemBuilder: (context, index) {
                  final item = filteredItems[index];
                  return Consumer<SearchSheetController<T>>(
                    builder: (context, controller, child) {
                      return GestureDetector(
                        onTap: () {
                          controller.toggleSelection(item);
                          if (widget.onItemSelected != null) {
                            widget.onItemSelected!(item);
                          }
                        },
                        child: widget.itemBuilder(context, item),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
