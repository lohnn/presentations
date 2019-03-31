# Check list items
- [ ] Briefly explain async await

- [ ] Init test flow
  - [ ] expect(find.byType(CheckableItem), findsNWidgets(5));
  - [ ] `getw` - CheckableItem x = tester.widget(find.byType(CheckableItem).at(2));
    - [ ] expect(widget.title, "my);

- [ ] Test check item
  - [ ] List<Checkbox>.from(tester.widgetList(find.byType(Checkbox)))
            .map((checkbox) => checkbox.value).toList();
    - [ ] `getwl`
  - [ ] expect(values.contains(true), isFalse);
  - [ ] await tester.tap(find.byType(CheckableItem).last);
    - [ ] Explain what happens without await
  - [ ] expect(values.contains(true), isFalse);
  - [ ] Explain pumpWidget & `pumpAndSettle`
  - [ ] await tester.pumpAndSettle();

- [ ] Run on device
  - [ ] Terminal "flutter run tests/widget_test.dart"
  - [ ] Edit configuration -> Add -> Flutter configuration
    - [ ] Dart entry point = test

- [ ] Test add item flow
  - [ ] Look at last widget - `getw`
    - [ ] expect(item.title, "YO!");
  - [ ] `tapw`
    - [ ] await tester.tap(find.byIcon(Icons.add));
    - [ ] await tester.pumpAndSettle();
  - [ ] await tester.enterText(find.byType(TextField), "An item");
    - [ ] `findw`
  - [ ] Show on device
  - [ ] tap Icons.done
  - [ ] Look at last item again

- [ ] Test flow phone
  - [ ] Create `Test flow phone`
  - [ ] Add sizes and binding - `ssetup`
    - [ ] final TestWidgetsFlutterBinding binding = TestWidgetsFlutterBinding.ensureInitialized();
    - [ ] final Size phone = Size(411.4, 820.6);
    - [ ] final Size tablet = Size(1600, 1024);
  - [ ] Set size of test area - `phone` / `tablet`
    - [ ] await binding.setSurfaceSize(phone);
  - [ ] Initial expectations
    - [ ] MyHomePage -> expectOneWidget
    - [ ] ItemCreator -> expectNothing
  - [ ] Click icon add + pumpAndSettle
  - [ ] New expectations
    - [ ] MyHomePage -> expectNothing
    - [ ] ItemCreator -> expectOneWidget

- [ ] Test flow master-detail
  - [ ] Copy phone test and rename `Test flow master-detail`
  - [ ] Surface size = tablet
  - [ ] Remove interactions
  - [ ] Initial expectations
    - [ ] MyHomePage -> expectOneWidget
    - [ ] ItemCreator -> expectOneWidget
  - [ ] Add OrientationBuilder in _MyHomePageState Scaffold body
    - [ ] `orb`
    - [ ] Reason: if rotation we want to make width check again
    - [ ] if (MediaQuery.of(context).size.width <= 600) { //Phone
      - [ ] `pvt`
      - [ ] Tablet
        - [ ] Row = `Expanded` buildListWidget() + `Expanded` ItemCreator()
      - [ ] REMEMBER `Expanded` in tablet mode

  - [ ] Explain problem with surfaceArea in test does not update MediaQuery

  - [ ] `msize` - await tester.pumpWidget(
          MaterialApp(
            home: MediaQuery(
              data: MediaQueryData(size: phone),
              child: MyHomePage(
                title: "Testing",
              ),
            ),
          ),
        );

#### Pre written tests can be found as `test[1-4]`

## Some extra points worthy explanation:
- [ ] meetsGuideline()
  - [ ] Automatically checks if app is accesibility friendly
- [ ] matchesReferenceImage / matchesGoldenFile
  - [ ] Used for testing if design looks like image/design