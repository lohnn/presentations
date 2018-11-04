import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
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
  List<Item> myList = [
    Item("This", false),
    Item("is", false),
    Item("my", false),
    Item("list", false),
    Item("YO!", false),
  ];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
        actions: Theme.of(context).platform == TargetPlatform.iOS
            ? <Widget>[
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => _addItem(""),
                )
              ]
            : null,
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          var myItem = myList[index];
          return CheckableItem(
            myItem.title,
            myItem.isChecked,
            valueChanged: (value) {
              setState(() {
                myItem.isChecked = value;
              });
            },
            onLongPressed: () {
              _addItem(myItem.title);
            },
          );
        },
        itemCount: myList.length,
      ),
      floatingActionButton: Theme.of(context).platform == TargetPlatform.android
          ? new FloatingActionButton(
              onPressed: () => _addItem(""),
              tooltip: 'Increment',
              child: new Icon(Icons.add),
            )
          : null,
    );
  }

  _addItem(String text) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => ItemCreator(text)))
        .then((value) {
      if (value != null && value.toString().isNotEmpty) {
        setState(() {
          myList.add(Item(value, false));
        });
      }
    });
  }
}

class Item {
  String title;
  bool isChecked;

  Item(this.title, this.isChecked);
}

class CheckableItem extends StatelessWidget {
  final String title;
  final bool isChecked;
  final ValueChanged<bool> valueChanged;
  final Function onLongPressed;

  CheckableItem(this.title, this.isChecked,
      {@required this.valueChanged, @required this.onLongPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () => onLongPressed(),
      onTap: () => valueChanged(!isChecked),
      child: Row(
        children: <Widget>[
          Checkbox(value: isChecked, onChanged: valueChanged),
          Text(title),
        ],
      ),
    );
  }
}

class ItemCreator extends StatefulWidget {
  final String text;

  ItemCreator(this.text);

  @override
  _ItemCreatorState createState() => _ItemCreatorState(this.text);
}

class _ItemCreatorState extends State<ItemCreator> {
  String _text;

  _ItemCreatorState(this._text);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(_text),
      ),
      body: TextField(
        autofocus: true,
        onChanged: (text) {
          _text = text;
        },
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pop(_text);
        },
        tooltip: 'Save',
        child: new Icon(Icons.done),
      ),
    );
  }
}
