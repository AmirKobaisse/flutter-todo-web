import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ToDoListApp(),
    );
  }
}

class ToDoListApp extends StatefulWidget {
  @override
  _ToDoListAppState createState() => _ToDoListAppState();
}

class _ToDoListAppState extends State<ToDoListApp> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _items = [];

  void _addItem() {
    setState(() {
      if (_controller.text.isNotEmpty) {
        _items.add(_controller.text);
        _controller.clear();
      }
    });
  }

  void _deleteItem(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Delete Item"),
        content: Text("Do you want to delete this item?"),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _items.removeAt(index);
              });
              Navigator.pop(context);
            },
            child: Text("Yes"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("No"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Demo Home Page'),
        backgroundColor: Colors.purple[200],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                ElevatedButton(
                  onPressed: _addItem,
                  child: Text('Add'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple[200],  // Use backgroundColor instead of primary
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),

                SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Enter a search term',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Expanded(
              child: _items.isEmpty
                  ? Center(child: Text("There are no items in the list"))
                  : ListView.builder(
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onLongPress: () => _deleteItem(index),
                    child: ListTile(
                      title: Row(
                        children: [
                          Text("Item $index: "),
                          Expanded(
                            child: Text(_items[index]),
                          ),
                        ],
                      ),
                    ),
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