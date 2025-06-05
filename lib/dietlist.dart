import 'package:flutter/material.dart';
import 'search_screen.dart';

void main() => runApp(const DietListApp());

class DietListApp extends StatelessWidget {
  const DietListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Diet List',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        fontFamily: 'Roboto',
      ),
      home: const DietListScreen(), // Changed from FitnessDietPlannerApp1 to DietListScreen
    );
  }
}

class DietListScreen extends StatefulWidget {
  const DietListScreen({super.key});

  @override
  State<DietListScreen> createState() => _DietListScreenState();
}

class _DietListScreenState extends State<DietListScreen> {
  final List<Map<String, dynamic>> _dietItems = [
    {'title': 'Fruits', 'checked': false, 'id': UniqueKey().toString()},
    {'title': 'Vegetables', 'checked': true, 'id': UniqueKey().toString()},
    {'title': 'Grains', 'checked': false, 'id': UniqueKey().toString()},
    {'title': 'Meat, Egg', 'checked': false, 'id': UniqueKey().toString()},
    {'title': 'Milk, Shake', 'checked': false, 'id': UniqueKey().toString()},
  ];

  final TextEditingController _textFieldController = TextEditingController();

  void _addNewItem(String text) {
    if (text.isEmpty) return;
    setState(() {
      _dietItems.add({
        'title': text,
        'checked': false,
        'id': UniqueKey().toString()
      });
    });
  }

  void _deleteItem(String id) {
    setState(() {
      _dietItems.removeWhere((item) => item['id'] == id);
    });
  }

  void _editItem(String id, String newText) {
    setState(() {
      final index = _dietItems.indexWhere((item) => item['id'] == id);
      if (index != -1) {
        _dietItems[index]['title'] = newText;
      }
    });
  }

  Future<void> _showAddDialog() async {
    _textFieldController.clear();
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Food Item'),
        content: TextField(
          controller: _textFieldController,
          decoration: const InputDecoration(
            hintText: "Enter food category",
            border: OutlineInputBorder(),
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (_textFieldController.text.isNotEmpty) {
                _addNewItem(_textFieldController.text);
                _textFieldController.clear();
                Navigator.pop(context);
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
            child: const Text('Add Item'),
          ),
        ],
      ),
    );
  }

  Future<void> _showEditDialog(String id, String currentTitle) async {
    _textFieldController.text = currentTitle;
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Food Item'),
        content: TextField(
          controller: _textFieldController,
          decoration: const InputDecoration(
            hintText: "Update food category",
            border: OutlineInputBorder(),
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (_textFieldController.text.isNotEmpty) {
                _editItem(id, _textFieldController.text.trim());
                Navigator.pop(context);
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
            child: const Text('Save Changes'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diet List'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever),
            tooltip: 'Delete Checked Items',
            onPressed: () {
              setState(() {
                _dietItems.removeWhere((item) => item['checked'] == true);
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchScreen()),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _dietItems.length,
        itemBuilder: (context, index) {
          final item = _dietItems[index];
          return Dismissible(
            key: Key(item['id']),
            background: Container(color: Colors.red),
            confirmDismiss: (direction) async {
              return await showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Confirm Delete"),
                  content: const Text("Delete this item permanently?"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text('Delete'),
                    ),
                  ],
                ),
              );
            },
            onDismissed: (direction) => _deleteItem(item['id']),
            child: CheckboxListTile(
              title: Text(
                item['title'],
                style: TextStyle(
                  fontSize: 16,
                  decoration: item['checked']
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
              value: item['checked'],
              onChanged: (value) => setState(() => item['checked'] = value!),
              secondary: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    onPressed: () =>
                        _showEditDialog(item['id'], item['title']),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete_outline, color: Colors.red),
                    onPressed: () => _deleteItem(item['id']),
                  ),
                ],
              ),
              controlAffinity: ListTileControlAffinity.leading,
              activeColor: Colors.orange,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddDialog,
        backgroundColor: Colors.orange,
        icon: const Icon(Icons.add),
        label: const Text('New Item'),
      ),
    );
  }
}