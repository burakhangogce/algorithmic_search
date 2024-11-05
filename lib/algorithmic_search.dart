library algorithmic_search;

import 'package:algorithmic_search/controller/algorithmic_search_controller.dart';
import 'package:algorithmic_search/enums/search_sheet_type.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchSheet<T> extends StatefulWidget {
  final List<T> items;
  final SearchSheetController<T> controller;
  final bool asDialog;
  final double height;
  final double width;
  final bool Function(T item, String query) searchCriteria;
  final Widget Function(BuildContext context, T item) itemBuilder;
  final void Function(T item)? onItemSelected;
  final InputDecoration? searchFieldDecoration;
  final String labelText;
  final EdgeInsets padding;
  final double spacing;
  final double runSpacing;
  final bool showSelectedItems; // Seçili öğeleri gösterme kontrolü

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
    this.labelText = "Arama",
    this.padding = const EdgeInsets.all(16.0),
    this.spacing = 8.0,
    this.runSpacing = 4.0,
    this.showSelectedItems = true, // Varsayılan olarak açık
  });

  @override
  SearchSheetState<T> createState() => SearchSheetState<T>();
}

class SearchSheetState<T> extends State<SearchSheet<T>> {
  List<T> filteredItems = [];
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    filteredItems = widget.items;
  }

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
            // Seçili öğelerin gösterimi sadece multiSelect modunda ve showSelectedItems true iken yapılır
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
