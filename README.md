
# Algorithmic Search

`algorithmic_search` is a Flutter package that provides a flexible, customizable search sheet widget. The `SearchSheet` widget supports both single and multi-select modes, making it suitable for various search and selection use cases in mobile applications.

## Features

- **Single and Multi-Select Modes**: Easily switch between `singleSelect` and `multiSelect` modes using the `SearchSheetController`.
- **Customizable UI**: Modify padding, spacing, search field decoration, and more to fit your app's design.
- **Selected Items Display**: Optionally show selected items at the top in `multiSelect` mode.
- **Generic Search Functionality**: Define custom search criteria to filter items based on user input.
- **Example App**: Example code is included to demonstrate how to implement and use the `SearchSheet` widget in a Flutter application.

## Getting Started

To use this package, add `algorithmic_search` as a dependency in your `pubspec.yaml` file:

```yaml
dependencies:
  algorithmic_search: ^0.0.1
```

## Usage

### Basic Setup

Import the package and create a `SearchSheetController` to manage selected items.

```dart
import 'package:algorithmic_search/algorithmic_search.dart';

// Initialize the controller with the desired selection type
final controller = SearchSheetController<String>(type: SearchSheetType.multiSelect);
```

### Example Usage

Here's an example of how to use the `SearchSheet` widget in a Flutter app:

```dart
import 'package:flutter/material.dart';
import 'package:algorithmic_search/algorithmic_search.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Search Sheet Example',
      home: const SearchExamplePage(),
    );
  }
}

class SearchExamplePage extends StatelessWidget {
  const SearchExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> items = ["Apple", "Banana", "Cherry", "Date", "Elderberry"];
    final controller = SearchSheetController<String>(type: SearchSheetType.multiSelect);

    return Scaffold(
      appBar: AppBar(title: const Text("Search Sheet Example")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (_) {
                return SearchSheet<String>(
                  items: items,
                  controller: controller,
                  searchCriteria: (item, query) => item.toLowerCase().contains(query.toLowerCase()),
                  itemBuilder: (context, item) => ListTile(
                    title: Text(item),
                    trailing: Consumer<SearchSheetController<String>>(
                      builder: (context, controller, child) {
                        return Icon(
                          Icons.check_circle,
                          color: controller.selectedItems.contains(item) ? Colors.green : Colors.grey,
                        );
                      },
                    ),
                  ),
                  onItemSelected: (item) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Selected item: $item")),
                    );
                  },
                  searchFieldDecoration: const InputDecoration(
                    labelText: "Search",
                    border: OutlineInputBorder(),
                  ),
                  showSelectedItems: true,
                );
              },
            );
          },
          child: const Text("Open Search Sheet"),
        ),
      ),
    );
  }
}
```

### Parameters

- **items**: List of items to display and search.
- **controller**: The `SearchSheetController` that manages selection state.
- **searchCriteria**: Function that filters items based on user input.
- **itemBuilder**: Function that builds each item widget.
- **onItemSelected**: Callback when an item is selected.
- **searchFieldDecoration**: Custom decoration for the search field.
- **labelText**: Label for the search field.
- **padding**: Padding around the widget.
- **spacing** and **runSpacing**: Spacing options for selected items in `multiSelect` mode.
- **showSelectedItems**: Controls whether selected items are shown at the top.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
