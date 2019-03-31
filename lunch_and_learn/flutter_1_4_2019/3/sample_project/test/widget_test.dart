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
  final tablet = Size(1600, 1024);

  testWidgets('Test init', (WidgetTester tester) async {
    await binding.setSurfaceSize(phone);
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    CheckableItem widget = tester.widget(find.byType(CheckableItem).at(2));
    expect(widget.title, "my");
  });

  testWidgets('Check item', (WidgetTester tester) async {
    await binding.setSurfaceSize(phone);
    await tester.pumpWidget(MyApp());

    var list = List<Checkbox>.from(tester.widgetList(find.byType(Checkbox)))
        .map((checkbox) => checkbox.value)
        .toList();

    expect(list.contains(true), isFalse);

    await tester.tap(find.byType(CheckableItem).last);
    await tester.pumpAndSettle();

    list = List<Checkbox>.from(tester.widgetList(find.byType(Checkbox)))
        .map((checkbox) => checkbox.value)
        .toList();

    expect(list.contains(true), isTrue);
  });

  testWidgets('Add item flow', (WidgetTester tester) async {
    await binding.setSurfaceSize(phone);
    await tester.pumpWidget(MyApp());

    CheckableItem item = tester.widget(find.byType(CheckableItem).last);
    expect(item.title, "YO!");

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), "An item");

    await tester.tap(find.byIcon(Icons.done));
    await tester.pumpAndSettle();

    item = tester.widget(find.byType(CheckableItem).last);
    expect(item.title, "An item");
  });

  testWidgets('Test flow phone', (WidgetTester tester) async {
    await binding.setSurfaceSize(phone);
    await tester.pumpWidget(MyApp());

    expect(find.byType(MyHomePage), findsOneWidget);
    expect(find.byType(ItemCreator), findsNothing);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    expect(find.byType(MyHomePage), findsNothing);
    expect(find.byType(ItemCreator), findsOneWidget);
  });

  testWidgets('Test flow master-detail', (WidgetTester tester) async {
    await binding.setSurfaceSize(tablet);
    await tester.pumpWidget(MyApp());

    await tester.pumpWidget(MaterialApp(
      home: MediaQuery(
          data: MediaQueryData(size: tablet),
          child: MyHomePage(
            title: "This is for testing yo",
          )),
    ));

    expect(find.byType(MyHomePage), findsOneWidget);
    expect(find.byType(ItemCreator), findsOneWidget);
  });
}
