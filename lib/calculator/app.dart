import 'package:calculator_app/calculator/display_result.dart';
import 'package:calculator_app/calculator/keyboard.dart';
import 'package:calculator_app/calculator/result.dart';
import 'package:calculator_app/utils/adapt.dart';
import 'package:flutter/material.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  ResultList results = ResultList();

  @override
  void initState() {
    super.initState();
  }

  // 更新UI
  void update(ResultList results) {
    setState(() {
      this.results = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    // 间距
    final padding = Adapt.px(30.0);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: DefaultTextStyle(
            style: TextStyle(
              color: Color(0xFFFFFFFF),
            ),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: DisplayResult(
                    results: results,
                    padding: padding,
                  ),
                ),
                Keyboard(
                  results: results,
                  padding: padding,
                  update: update,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
