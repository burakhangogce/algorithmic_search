import 'package:algorithmic_search/controller/algorithmic_search_controller.dart';
import 'package:algorithmic_search/enums/search_sheet_type.dart';
import 'package:flutter/material.dart';
import 'package:algorithmic_search/algorithmic_search.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Search Sheet Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SearchExamplePage(),
    );
  }
}

class SearchExamplePage extends StatelessWidget {
  const SearchExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Search Sheet Example")),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                _openSearchSheet(
                  context,
                  SearchSheetType.singleSelect,
                  'Single Select Search',
                );
              },
              child: const Text("Open Single Select Search Sheet"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _openSearchSheet(
                  context,
                  SearchSheetType.multiSelect,
                  'Multi Select Search',
                  showSelectedItems: true,
                );
              },
              child: const Text("Open Multi Select Search Sheet"),
            ),
          ],
        ),
      ),
    );
  }

  void _openSearchSheet(
    BuildContext context,
    SearchSheetType type,
    String title, {
    bool showSelectedItems = false,
  }) {
    final List<String> items = [
      "Apple",
      "Banana",
      "Cherry",
      "Date",
      "Elderberry"
    ];
    final controller = SearchSheetController<String>(type: type);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return SearchSheet<String>(
          items: items,
          controller: controller,
          searchCriteria: (item, query) =>
              item.toLowerCase().contains(query.toLowerCase()),
          itemBuilder: (context, item) => ListTile(
            title: Text(item),
            trailing: Consumer<SearchSheetController<String>>(
              builder: (context, controller, child) {
                return Icon(
                  Icons.check_circle,
                  color: controller.selectedItems.contains(item)
                      ? Colors.green
                      : Colors.grey,
                );
              },
            ),
          ),
          onItemSelected: (item) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Selected item: $item")),
            );
          },
          searchFieldDecoration: InputDecoration(
            labelText: title,
            border: const OutlineInputBorder(),
          ),
          labelText: title,
          padding: const EdgeInsets.all(16.0),
          spacing: 10.0,
          runSpacing: 6.0,
          showSelectedItems: showSelectedItems,
        );
      },
    );
  }
}
