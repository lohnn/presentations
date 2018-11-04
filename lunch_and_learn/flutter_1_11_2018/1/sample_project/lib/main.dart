import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<_ItemData> _myItems = [
    _ItemData("This"),
    _ItemData("Is"),
    _ItemData("My"),
    _ItemData("List"),
    _ItemData("Yo"),
  ];

  List<_ItemData> _getItemsSorted() {
    return _myItems.where((item) => !item.isChecked).toList()
      ..addAll(_myItems.where((item) => item.isChecked).toList());
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: _getItemsSorted().length,
        itemBuilder: (context, index) {
          _ItemData currentItem = _getItemsSorted()[index];
          return _Item(
            currentItem.text,
            isChecked: currentItem.isChecked,
            onChanged: (value) {
              setState(() {
                currentItem.isChecked = value;
              });
            },
          );
        },
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () => _addItem(),
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ),
    );
  }

  _addItem() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => _ItemCreator()))
        .then((value) {
      if (value.toString().isEmpty) {
        return;
      }
      setState(() {
        _myItems.add(_ItemData(value));
      });
    });
  }
}

class _ItemData {
  final String text;
  bool isChecked;

  _ItemData(this.text, {this.isChecked = false});
}

class _Item extends StatelessWidget {
  final String text;
  final bool isChecked;
  final Function(bool) onChanged;

  _Item(this.text, {this.isChecked = false, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(!isChecked),
      child: Row(
        children: <Widget>[
          Checkbox(value: isChecked, onChanged: (value) => onChanged(value)),
          Text(text),
        ],
      ),
    );
  }
}

class _ItemCreator extends StatefulWidget {
  @override
  _ItemCreatorState createState() => _ItemCreatorState();
}

class _ItemCreatorState extends State<_ItemCreator> {
  String _text = "";

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Add item"),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            decoration:
                InputDecoration(hintText: "What do you want to remember?"),
            onChanged: (value) {
              _text = value;
            },
            autofocus: true,
          ),
          FlatButton(
            child: Text("Done"),
            onPressed: () {
              Navigator.pop(context, _text);
            },
          ),
        ],
      ),
    );
  }
}
