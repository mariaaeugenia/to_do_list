import 'package:flutter/material.dart';
import 'models/item.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  List<Item> items = [];

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    var inputController = TextEditingController();

    add() {
      setState(() {
        widget.items.add(Item(done: false, title: inputController.text));
        inputController.clear();
      });
    }

    remove(index) {
      widget.items.removeAt(index);
    }

    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          keyboardType: TextInputType.text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18
          ),
          decoration: InputDecoration(
            labelText: "New task",
            labelStyle: TextStyle(
              color: Colors.white70
            )
          ),
          controller: inputController,
        ),
      ),
      body: ListView.builder(
        itemCount: widget.items.length,
        itemBuilder: (BuildContext context, int index) {
          final item = widget.items[index];
          return Dismissible(
            key: Key(item.title),
            background: Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.all(10.0),
              color: Colors.red,
              child: Icon(
                Icons.delete,
                color: Colors.white,
                )
            ),
            onDismissed: (direction) {
                remove(index);
            },
            child: CheckboxListTile(
            title: Text(item.title),
            value: item.done,
            key: Key(item.title),
            onChanged: (value) {
              setState(() {
                item.done = value;
              });
            },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: add,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
