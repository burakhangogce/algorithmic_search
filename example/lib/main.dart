import 'package:algorithmic_search/algorithmic_search.dart';
import 'package:algorithmic_search/controller/algorithmic_search_controller.dart';
import 'package:algorithmic_search/enums/search_sheet_type.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> items = [
    "Apple",
    "Banana",
    "Cherry",
    "Date",
    "Elderberry"
  ];
  final SearchSheetController<String> controller =
      SearchSheetController(type: SearchSheetType.multiSelect);

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: SearchSheet<String>(
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
            print("Seçilen öğe: $item");
          },
          searchFieldDecoration: const InputDecoration(
            labelText: "Meyve Ara",
            border: OutlineInputBorder(),
          ),
          labelText: "Meyve Ara",
          padding: const EdgeInsets.all(12.0),
          spacing: 10.0,
          runSpacing: 6.0,
        ),
      ),
    );
  }
}
