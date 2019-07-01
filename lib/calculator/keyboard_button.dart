import 'package:calculator_app/utils/adapt.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 按钮回调
typedef void OnPress(ButtonDetails detail);
typedef Widget Builder(KeyboardButton keyboardButton);

// 按钮信息
class ButtonDetails {
  final String title;
  final bool isOperator;
  final Color color;
  final Color background;
  final Color pressedBackground;
  final TextStyle style;

  const ButtonDetails({
    @required this.title,
    this.isOperator = false,
    this.color = const Color(0xFFFFFFFF),
    this.background = const Color(0xFF666666),
    this.pressedBackground,
    this.style,
  });

  @override
  String toString() {
    return title;
  }
}

class KeyboardButton extends StatefulWidget {
  final ButtonDetails details;
  final double width;
  final double height;
  final double borderRadius;
  final OnPress onPress;

  const KeyboardButton(
    this.details, {
    Key key,
    @required this.width,
    @required this.height,
    this.onPress,
  })  : assert((width != null && width > 0) && (height != null && height > 0)),
        borderRadius = width < height ? width / 2 : height / 2,
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _KeyboardButtonState();
  }

  static final ButtonDetails ac = ButtonDetails(
    title: 'AC',
    isOperator: true,
    color: Color(0xFF000000),
    background: Color(0xFFAAAAAA),
    pressedBackground: Color(0xFFDDDDDD),
  );

  static final ButtonDetails c = ButtonDetails(
    title: 'C',
    isOperator: true,
    color: Color(0xFF000000),
    background: Color(0xFFAAAAAA),
    pressedBackground: Color(0xFFDDDDDD),
  );

  static final ButtonDetails pm = ButtonDetails(
    title: '±',
    isOperator: true,
    color: Color(0xFF000000),
    background: Color(0xFFAAAAAA),
    pressedBackground: Color(0xFFDDDDDD),
    style: TextStyle(
      fontSize: Adapt.px(34),
    ),
  );

  static final ButtonDetails percent = ButtonDetails(
    title: '%',
    isOperator: true,
    color: Color(0xFF000000),
    background: Color(0xFFAAAAAA),
    pressedBackground: Color(0xFFDDDDDD),
  );

  static final ButtonDetails equal = ButtonDetails(
    title: '=',
    isOperator: true,
    color: Color(0xFFFFFFFF),
    background: Color(0xFFFF9800),
    pressedBackground: Color(0xFFFFCC80),
    style: TextStyle(fontSize: Adapt.px(34)),
  );

  static final ButtonDetails plus = ButtonDetails(
    title: '+',
    isOperator: true,
    color: Color(0xFFFFFFFF),
    background: Color(0xFFFF9800),
    pressedBackground: Color(0xFFFFCC80),
    style: TextStyle(fontSize: Adapt.px(34)),
  );

  static final ButtonDetails minus = ButtonDetails(
    title: '−',
    isOperator: true,
    color: Color(0xFFFFFFFF),
    background: Color(0xFFFF9800),
    pressedBackground: Color(0xFFFFCC80),
    style: TextStyle(fontSize: Adapt.px(34)),
  );

  static final ButtonDetails mul = ButtonDetails(
    title: '×',
    isOperator: true,
    color: Color(0xFFFFFFFF),
    background: Color(0xFFFF9800),
    pressedBackground: Color(0xFFFFCC80),
    style: TextStyle(fontSize: Adapt.px(34)),
  );

  static final ButtonDetails div = ButtonDetails(
    title: '÷',
    isOperator: true,
    color: Color(0xFFFFFFFF),
    background: Color(0xFFFF9800),
    pressedBackground: Color(0xFFFFCC80),
    style: TextStyle(fontSize: Adapt.px(34)),
  );

  static final ButtonDetails zero = ButtonDetails(
    title: '0',
    color: Color(0xFFFFFFFF),
    background: Color(0xFF333333),
    pressedBackground: Color(0xFF777777),
  );

  static final ButtonDetails one = ButtonDetails(
    title: '1',
    color: Color(0xFFFFFFFF),
    background: Color(0xFF333333),
    pressedBackground: Color(0xFF777777),
  );

  static final ButtonDetails two = ButtonDetails(
    title: '2',
    color: Color(0xFFFFFFFF),
    background: Color(0xFF333333),
    pressedBackground: Color(0xFF777777),
  );

  static final ButtonDetails three = ButtonDetails(
    title: '3',
    color: Color(0xFFFFFFFF),
    background: Color(0xFF333333),
    pressedBackground: Color(0xFF777777),
  );

  static final ButtonDetails four = ButtonDetails(
    title: '4',
    color: Color(0xFFFFFFFF),
    background: Color(0xFF333333),
    pressedBackground: Color(0xFF777777),
  );

  static final ButtonDetails five = ButtonDetails(
    title: '5',
    color: Color(0xFFFFFFFF),
    background: Color(0xFF333333),
    pressedBackground: Color(0xFF777777),
  );

  static final ButtonDetails six = ButtonDetails(
    title: '6',
    color: Color(0xFFFFFFFF),
    background: Color(0xFF333333),
    pressedBackground: Color(0xFF777777),
  );

  static final ButtonDetails seven = ButtonDetails(
    title: '7',
    color: Color(0xFFFFFFFF),
    background: Color(0xFF333333),
    pressedBackground: Color(0xFF777777),
  );

  static final ButtonDetails eight = ButtonDetails(
    title: '8',
    color: Color(0xFFFFFFFF),
    background: Color(0xFF333333),
    pressedBackground: Color(0xFF777777),
  );

  static final ButtonDetails nine = ButtonDetails(
    title: '9',
    color: Color(0xFFFFFFFF),
    background: Color(0xFF333333),
    pressedBackground: Color(0xFF777777),
  );

  static final ButtonDetails dot = ButtonDetails(
    title: '.',
    color: Color(0xFFFFFFFF),
    background: Color(0xFF333333),
    pressedBackground: Color(0xFF777777),
    style: TextStyle(fontWeight: FontWeight.bold),
  );
}

class _KeyboardButtonState extends State<KeyboardButton> {
  Color color;
  Color background;

  @override
  void initState() {
    super.initState();
    color = widget.details.color;
    background = widget.details.background;
  }

  // 构建按钮组件
  Widget _buildWidget() {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius)),
      ),
      child: DefaultTextStyle(
        style: TextStyle(
          color: color,
          fontSize: Adapt.px(26.0),
        ),
        child: DefaultTextStyle.merge(
          style: widget.details.style ?? TextStyle(),
          child: SizedBox(
            child: Center(
              child: Text(widget.details.title),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: _buildWidget(),
      onTap: () {
        if (widget.onPress is Function) {
          widget.onPress(widget.details);
        }
      },
      onTapDown: (TapDownDetails details) {
        if (widget.details.pressedBackground != null) {
          setState(() {
            background = widget.details.pressedBackground;
          });
        }
      },
      onTapUp: (TapUpDetails details) {
        if (background != widget.details.background) {
          setState(() {
            background = widget.details.background;
          });
        }
      },
    );
  }
}

// 数值型按钮Map
Map<String, ButtonDetails> valueButtonMap = {
  '0': KeyboardButton.zero,
  '1': KeyboardButton.one,
  '2': KeyboardButton.two,
  '3': KeyboardButton.three,
  '4': KeyboardButton.four,
  '5': KeyboardButton.five,
  '6': KeyboardButton.six,
  '7': KeyboardButton.seven,
  '8': KeyboardButton.eight,
  '9': KeyboardButton.nine,
  '.': KeyboardButton.dot,
};
