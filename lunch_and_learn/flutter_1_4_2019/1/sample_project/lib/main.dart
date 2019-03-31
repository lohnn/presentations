import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        platform: TargetPlatform.android,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: Theme.of(context).platform == TargetPlatform.iOS
            ? <Widget>[
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => _addItem(""),
                )
              ]
            : null,
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          if (MediaQuery.of(context).size.width <= 600) {
            //Phone
            return _tab1();
          } else {
            //Tablet
            return Row(
              children: <Widget>[
                Expanded(child: _tab1()),
                Expanded(child: ItemCreator(null)),
              ],
            );
          }
        },
      ),
      floatingActionButton: Theme.of(context).platform == TargetPlatform.android
          ? FloatingActionButton(
              onPressed: () => _addItem(""),
              tooltip: 'Increment',
              child: Icon(Icons.add),
            )
          : null,
    );
  }

  Widget _tab1() => ListView.builder(
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
      );

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
    if (_text == null) {
      return Center(
        child: Text("No item selected. Please select one."),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(_text),
      ),
      body: TextField(
        autofocus: true,
        onChanged: (text) {
          _text = text;
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pop(_text);
        },
        tooltip: 'Save',
        child: Icon(Icons.done),
      ),
    );
  }
}
