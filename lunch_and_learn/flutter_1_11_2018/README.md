## Init project
- [ ] Open path in Terminal
    - [ ] > flutter create sample_project
- [ ] Open folder in Android Studio
- [ ] Start scrcpy
- [ ] Build and run on device

## Start content creation
- [ ] Clean out all comments
    - [ ] (//.\*)
- [ ] Show hot reload
    - [ ] Change increment counter to decrement
    - [ ] Change some texts
 - [ ] Create a column list of texts
    - [ ] Remove counter
    - [ ] children: <Widget>[
            Text("This"),
            Text("Is"),
            Text("My"),
            Text("List"),
            Text("Yo"),
          ],
    - [ ] Move list out to be field
    - [ ] Create funciton _addItem()
        - [ ] onPressed: () => _addItem(),
            - [ ] Explain what _ means
        - [ ] Let it add a widget to the list WITHOUT setState()
            - [ ] _myItems.add(Text("Yohoo");
        - [ ] Tell how setState() works
            - [ ] add setState()

## List builder
- [ ] Change list of widgets to a list of strings
    - [ ] List<String> _myItems = [
    "This",
    "Is",
    "My",
    "List",
    "Yo",
  ];
    - [ ] Add ListView.builder() directly to body
        - [ ] Don't forget to add both item count and item builder

## Prettier view
- [ ] Create stateless widget class with text and isChecked
    - [ ] Name CheckableItem
    - [ ] Let widget receive text and isChecked
    - [ ] Let constructor be CheckableItem(this.text, this.isChecked)
- [ ] Build method in state creates row with checkbox and text
- [ ] Wrap Row in inkWell, onclick calls valueChanged
    - [ ] add final ValueChanged\<bool\> valueChanged;

## Create new items in list
- [ ] Let onClick navigate to new widget
    - [ ] Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => _ItemCreator()));
    - [ ] Copy MyHomePageState builder to this new one
    - [ ] Add TextField with auto focus
        - [ ] Change listener changes field
    - [ ] Add Button "Done"
        - [ ] onPressed -> Navigator.pop(context, _text);
- [ ] Let receiver implement "then()"
- [ ] Show what happens if we enter empty text, and fix > value.toString().isEmpty

## Show iOS
- [ ] MyApp theme
    - [ ] Add platform: TargetPlatform.iOS,
- [ ] Add platform check on FAB
    - [ ] Platform.isAndroid

## Edit list item
 - [ ] If we have time





https://flutter.io/widgets/material/

https://pub.dartlang.org/
