// This is a basic Flutter widget test.
// To perform an interaction with a widget in your test, use the WidgetTester utility that Flutter
// provides. For example, you can send tap and scroll gestures. You can also use WidgetTester to
// find child widgets in the widget tree, read text, and verify that the values of widget properties
// are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sample_project/main.dart';

void main() {
  final TestWidgetsFlutterBinding binding =
      TestWidgetsFlutterBinding.ensureInitialized();
  final Size phone = Size(411.4, 820.6);
  final Size tablet = Size(1600, 1024);

  testWidgets('Check init state', (WidgetTester tester) async {
    await binding.setSurfaceSize(phone);
    await tester.pumpWidget(MyApp());

    var firstWidget =
        tester.widget(find.byType(CheckableItem).at(2)) as CheckableItem;
    expect(firstWidget.title, "my");
    expect(firstWidget.isChecked, false);
  });

  testWidgets("Test add item", (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    expect(find.byType(CheckableItem), findsNWidgets(5));

    var lastWidget =
        tester.widget(find.byType(CheckableItem).last) as CheckableItem;
    expect(lastWidget.title, "YO!");

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), "An item");

    await tester.tap(find.byIcon(Icons.done));
    await tester.pumpAndSettle();

    expect(find.byType(CheckableItem), findsNWidgets(6));

    var titles = List<CheckableItem>.from(
            (tester.widgetList(find.byType(CheckableItem))))
        .map((item) => item.title)
        .toList();

    expect(titles, <String>[
      "This",
      "is",
      "my",
      "list",
      "YO!",
      "An item",
    ]);
  });

  testWidgets("Test check item", (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    var list = List<Checkbox>.from(tester.widgetList(find.byType(Checkbox)))
        .map((checkbox) => checkbox.value);

    expect(list.contains(true), isFalse);

    await tester.tap(find.byType(CheckableItem).last);
    await tester.pumpAndSettle();

    list = List<Checkbox>.from((tester.widgetList(find.byType(Checkbox))))
        .map((checkbox) => checkbox.value);

    expect(list.contains(true), isTrue);
  });

  testWidgets("Test item layout", (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: CheckableItem("This is item", false,
              valueChanged: (bool) {}, onLongPressed: () {}),
        ),
      ),
    );
  });

  testWidgets("Test flow phone", (tester) async {
    await binding.setSurfaceSize(phone);
    await tester.pumpWidget(
      MaterialApp(
        home: MediaQuery(
          data: MediaQueryData(size: phone),
          child: MyHomePage(
            title: "Testing",
          ),
        ),
      ),
    );

    expect(find.byType(MyHomePage), findsOneWidget);
    expect(find.byType(ItemCreator), findsNothing);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    expect(find.byType(MyHomePage), findsNothing);
    expect(find.byType(ItemCreator), findsOneWidget);
  });

  testWidgets("Test master detail", (tester) async {
    await binding.setSurfaceSize(tablet);
    await tester.pumpWidget(
      MaterialApp(
        home: MediaQuery(
          data: MediaQueryData(size: tablet),
          child: MyHomePage(
            title: "Testing",
          ),
        ),
      ),
    );

    expect(find.byType(MyHomePage), findsOneWidget);
    expect(find.byType(ItemCreator), findsOneWidget);
  });
}
