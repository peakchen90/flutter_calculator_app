import 'package:calculator_app/calculator/keyboard_button.dart';
import 'package:calculator_app/calculator/result.dart';
import 'package:calculator_app/utils/adapt.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef void Update(ResultList results);

class Keyboard extends StatefulWidget {
  final ResultList results;
  final double padding;
  final Update update;

  const Keyboard({
    Key key,
    @required this.results,
    @required this.padding,
    this.update,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _KeyboardState();
  }
}

class _KeyboardState extends State<Keyboard> {
  double screenWidth;
  double padding;
  double baseWidth;

  @override
  void initState() {
    super.initState();

    Adapt.init(375);
    screenWidth = Adapt.width;
    padding = widget.padding;
    baseWidth = (screenWidth - 5 * padding) / 4;
  }

  void handleOperate(ButtonDetails details) {
    final results = widget.results;

    if (details == KeyboardButton.ac) {
      results.reset();
    } else if (details == KeyboardButton.c) {
      if (results.length > 0 && !results.current.isOperator) {
        results.pop();
      }
    } else if (details == KeyboardButton.pm) {
    } else if (details == KeyboardButton.percent) {
    } else if (details == KeyboardButton.equal) {
      if (results.length >= 3) {
        final value = results.computed();
        results.reset();
        results.push(Result.fromNumber(value));
      }
    } else {
      results.push(Result(
        isOperator: true,
        detials: details,
      ));
    }

    widget.update(results);
  }

  void handlePutValue(ButtonDetails details) {
    final results = widget.results;
    if (results.current.isOperator) {
      results.push(Result());
    }
    results.current.put(details);
    widget.update(results);
  }

  Widget _buildButton(ButtonDetails details, {int rowSpan: 1, int colSpan: 1}) {
    final width = baseWidth * rowSpan + padding * (rowSpan - 1);
    final height = baseWidth * colSpan + padding * (colSpan - 1);

    return Container(
      margin: EdgeInsets.only(
        left: padding,
        bottom: padding,
      ),
      child: KeyboardButton(
        details,
        width: width,
        height: height,
        onPress: (ButtonDetails details) {
          if (details.isOperator) {
            handleOperate(details);
          } else {
            handlePutValue(details);
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            _buildButton(KeyboardButton.ac),
            _buildButton(KeyboardButton.pm),
            _buildButton(KeyboardButton.percent),
            _buildButton(KeyboardButton.div),
          ],
        ),
        Row(
          children: <Widget>[
            _buildButton(KeyboardButton.seven),
            _buildButton(KeyboardButton.eight),
            _buildButton(KeyboardButton.nine),
            _buildButton(KeyboardButton.mul),
          ],
        ),
        Row(
          children: <Widget>[
            _buildButton(KeyboardButton.four),
            _buildButton(KeyboardButton.five),
            _buildButton(KeyboardButton.six),
            _buildButton(KeyboardButton.minus),
          ],
        ),
        Row(
          children: <Widget>[
            _buildButton(KeyboardButton.one),
            _buildButton(KeyboardButton.two),
            _buildButton(KeyboardButton.three),
            _buildButton(KeyboardButton.plus),
          ],
        ),
        Row(
          children: <Widget>[
            _buildButton(KeyboardButton.zero, rowSpan: 2),
            _buildButton(KeyboardButton.dot),
            _buildButton(KeyboardButton.equal),
          ],
        ),
      ],
    );
  }
}
