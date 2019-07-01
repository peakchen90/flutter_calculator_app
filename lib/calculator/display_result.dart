import 'package:calculator_app/calculator/result.dart';
import 'package:calculator_app/utils/adapt.dart';
import 'package:flutter/cupertino.dart';

class DisplayResult extends StatelessWidget {
  final ResultList results;
  final double padding;

  const DisplayResult({
    Key key,
    @required this.results,
    @required this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: Adapt.px(30.0),
        left: padding,
        right: padding,
      ),
      alignment: Alignment.bottomRight,
      child: FittedBox(
        child: Text(
          results.format(),
          style: TextStyle(
            fontSize: 80.0,
            fontWeight: FontWeight.w200,
          ),
          maxLines: 1,
          textAlign: TextAlign.right,
        ),
      ),
    );
  }
}
