import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        platform: TargetPlatform.android,
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
  List<Item> _myList = [
    Item("This", false),
    Item("is", false),
    Item("my", false),
    Item("todo", false),
    Item("list...", false),
  ];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
        actions: Theme.of(context).platform == TargetPlatform.iOS
            ? <Widget>[
                IconButton(icon: Icon(Icons.add), onPressed: () => _addItem(null))
              ]
            : null,
      ),
      body: ListView.builder(
          itemCount: _myList.length,
          itemBuilder: (context, index) {
            var listItem = _myList[index];
            return CheckableItem(
              listItem.title,
              listItem.isChecked,
              onChanged: (value) {
                setState(() {
                  listItem.isChecked = value;
                });
              },
              onLongPress: () {
                _addItem(listItem.title);
              },
            );
          }),
//      body: new Column(
//        children: _myList,
//      ),
      floatingActionButton: Theme.of(context).platform == TargetPlatform.android
          ? FloatingActionButton(
              onPressed: () => _addItem(null),
              tooltip: 'Increment',
              child: new Icon(Icons.add),
            )
          : null,
    );
  }

  _addItem(String title) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return CreateItem(title: title);
    })).then((value) {
      if (value != null && value.toString().isNotEmpty) {
        setState(() {
          _myList.add(Item(value, false));
        });
      }
    });
    _myList.add(Item("Item", false));
    _myList.add(Item("Item", false));
    _myList.add(Item("Item", false));
    _myList.add(Item("Item", false));
    _myList.add(Item("Item", false));
    _myList.add(Item("Item", false));
    _myList.add(Item("Item", false));
    _myList.add(Item("Item", false));
    _myList.add(Item("Item", false));
    _myList.add(Item("Item", false));
    _myList.add(Item("Item", false));
    _myList.add(Item("Item", false));
    _myList.add(Item("Item", false));
    _myList.add(Item("Item", false));
    _myList.add(Item("Item", false));
    _myList.add(Item("Item", false));
    _myList.add(Item("Item", false));
    _myList.add(Item("Item", false));
    _myList.add(Item("Item", false));
    _myList.add(Item("Item", false));
    _myList.add(Item("Item", false));
    _myList.add(Item("Item", false));
    _myList.add(Item("Item", false));
    _myList.add(Item("Item", false));
    _myList.add(Item("Item", false));
    _myList.add(Item("Item", false));
    _myList.add(Item("Item", false));
  }
}

class Item {
  String title;
  bool isChecked;

  Item(this.title, this.isChecked);
}

class CheckableItem extends StatelessWidget {
  final String _title;
  final bool _isChecked;

  final ValueChanged<bool> onChanged;

  final GestureLongPressCallback onLongPress;

  CheckableItem(this._title, this._isChecked,
      {@required this.onChanged, this.onLongPress});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: onLongPress,
      onTap: () => onChanged(!_isChecked),
      child: Row(
        children: <Widget>[
          Checkbox(
            value: _isChecked,
            onChanged: (value) => onChanged(value),
          ),
          Text(_title, style: Theme.of(context).textTheme.headline,),
        ],
      ),
    );
  }
}

class CreateItem extends StatefulWidget {
  final String title;

  CreateItem({this.title});

  @override
  _CreateItemState createState() => _CreateItemState(this.title);
}

class _CreateItemState extends State<CreateItem> {
  String _text;

  _CreateItemState(this._text);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(_text ?? "Add item"),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            autofocus: true,
            onChanged: (text) {
              _text = text;
            },
          ),
          FlatButton(
              onPressed: () {
                Navigator.of(context).pop(_text);
              },
              child: Text("Done")),
        ],
      ),
    );
  }
}
