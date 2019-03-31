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

  testWidgets('Init app test', (WidgetTester tester) async {
    await binding.setSurfaceSize(phone);

    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify that our counter starts at 0.
    expect(find.byType(CheckableItem), findsNWidgets(5));

    CheckableItem widget = tester.widget(find.byType(CheckableItem).at(2));
    expect(widget.title, "my");
    expect(widget.isChecked, false);
  });

  testWidgets("Test check item", (WidgetTester tester) async {
    await binding.setSurfaceSize(phone);

    await tester.pumpWidget(MyApp());

    List<bool> values =
        List<Checkbox>.from(tester.widgetList(find.byType(Checkbox)))
            .map((checkbox) => checkbox.value)
            .toList();
    expect(values.contains(true), isFalse);

    await tester.tap(find.byType(CheckableItem).last);
    await tester.pumpAndSettle();

    values = List<Checkbox>.from(tester.widgetList(find.byType(Checkbox)))
        .map((checkbox) => checkbox.value)
        .toList();
    expect(values.contains(true), isTrue);
  });

  testWidgets("Test add item phone", (WidgetTester tester) async {
    await binding.setSurfaceSize(phone);

    await tester.pumpWidget(MyApp());

    //Check item list
    CheckableItem lastWidget = tester.widget(find.byType(CheckableItem).last);
    expect(lastWidget.title, "YO!");

    //Click the plus sign
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    //Enter text
    await tester.enterText(find.byType(TextField), "An item");

    //Click done
    await tester.tap(find.byIcon(Icons.done));
    await tester.pumpAndSettle();

    //Check item list
    expect(find.byType(CheckableItem), findsNWidgets(6));

    lastWidget = tester.widget(find.byType(CheckableItem).last);
    expect(lastWidget.title, "An item");
  });

  testWidgets("Test master-detail spread", (tester) async {
    await binding.setSurfaceSize(tablet);
    await tester.pumpWidget(MaterialApp(
      home: MediaQuery(
          data: MediaQueryData(size: tablet),
          child: MyHomePage(
            title: "Test",
          )),
    ));

    expect(find.byType(MyHomePage), findsOneWidget);
    expect(find.byType(ItemCreator), findsOneWidget);
  });
}
