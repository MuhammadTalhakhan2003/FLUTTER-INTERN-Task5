import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SharedPreferences Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ItemListScreen(),
      debugShowCheckedModeBanner: false, // Remove debug banner
    );
  }
}

class ItemProvider extends ChangeNotifier {
  List<String> _items = [];

  List<String> get items => _items;

  ItemProvider() {
    _loadItems();
  }

  Future<void> _loadItems() async {
    final prefs = await SharedPreferences.getInstance();
    _items = prefs.getStringList('item_list') ?? [];
    notifyListeners();
  }

  Future<void> addItem(String item) async {
    _items.add(item);
    notifyListeners();
    await _saveItems();
  }

  Future<void> removeItem(String item) async {
    _items.remove(item);
    notifyListeners();
    await _saveItems();
  }

  Future<void> _saveItems() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('item_list', _items);
  }
}

class ItemListScreen extends StatefulWidget {
  @override
  _ItemListScreenState createState() => _ItemListScreenState();
}

class _ItemListScreenState extends State<ItemListScreen> {
  late ItemProvider _itemProvider;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _itemProvider = ItemProvider();
    _itemProvider.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _itemProvider.removeListener(() {});
    super.dispose();
  }

  void _showAddDialog() {
    _controller.clear();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add Item'),
        content: TextField(
          controller: _controller,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              _itemProvider.addItem(_controller.text);
              Navigator.of(context).pop();
            },
            child: Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Item List'),
      ),
      body: ListView.builder(
        itemCount: _itemProvider.items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_itemProvider.items[index]),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                _itemProvider.removeItem(_itemProvider.items[index]);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddDialog,
        child: Icon(Icons.add),
      ),
    );
  }
}
