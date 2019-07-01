import 'dart:math';

import 'package:calculator_app/calculator/keyboard_button.dart';
import 'package:calculator_app/utils/string.dart';

class ResultList {
  final List<Result> _results = List<Result>();
  double computedValue = 0.0;

  ResultList() {
    if (_results.isEmpty) {
      _results.add(Result());
    }
  }

  List<Result> get results => _results;

  Result get current => _results[_results.length - 1];

  set current(Result result) {
    _results[_results.length - 1] = result;
  }

  int get length => _results.length;

  void push(Result result) {
    if (result.isOperator && current.isOperator) {
      current = result;
    } else {
      _results.add(result);
    }
  }

  Result pop() {
    return _results.removeLast();
  }

  void reset() {
    _results.clear();
    computedValue = 0.0;
    push(Result());
  }

  double computed() {
    final operand = _results[length - 3];
    final operator = _results[length - 2].operator;
    final beOperand = _results[length - 1];

    if (operator == KeyboardButton.plus) {
      computedValue += (operand + beOperand).toValue();
    } else if (operator == KeyboardButton.minus) {
      computedValue += (operand - beOperand).toValue();
    } else if (operator == KeyboardButton.mul) {
      computedValue += (operand * beOperand).toValue();
    } else if (operator == KeyboardButton.div) {
      computedValue += (operand / beOperand).toValue();
    }

    return computedValue;
  }

  @override
  String toString() {
    if (current.isOperator) {
      return _results[_results.length - 2].toString();
    }
    return current.toString();
  }

  String format() {
    return toThousands(toString());
  }
}

class Result {
  static final int maxLength = 9;

  final List<ButtonDetails> _detailsList = List<ButtonDetails>();
  final bool isOperator;
  int dotIndex;

  Result({this.isOperator = false, ButtonDetails detials}) {
    assert(!isOperator || detials != null);

    if (!isOperator) {
      _detailsList.add(KeyboardButton.zero);
    } else {
      _detailsList.add(detials);
    }
  }

  bool validate(ButtonDetails details) {
    if (dotIndex != null) {
      if (details == KeyboardButton.dot) {
        return false;
      }
      if (_detailsList.length >= Result.maxLength + 1) {
        return false;
      }
    } else {
      if (_detailsList.length >= Result.maxLength) {
        return false;
      }
    }
    return true;
  }

  bool put(ButtonDetails details) {
    if (validate(details)) {
      if (_detailsList.length == 1 &&
          _detailsList[0] == KeyboardButton.zero &&
          !details.isOperator &&
          details != KeyboardButton.dot) {
        _detailsList[0] = details;
      } else {
        _detailsList.add(details);
        if (details == KeyboardButton.dot) {
          dotIndex = _detailsList.length - 1;
        }
      }
      return true;
    }
    return false;
  }

  ButtonDetails pop() {
    ButtonDetails details = _detailsList.removeLast();
    if (details == KeyboardButton.dot) {
      dotIndex = null;
    }
    return details;
  }

  void reset() {
    _detailsList.clear();
    dotIndex = null;
    put(KeyboardButton.zero);
  }

  void replace(List<ButtonDetails> newDetailsList) {
    reset();
    if (newDetailsList.isNotEmpty) {
      newDetailsList.forEach((details) {
        put(details);
      });
    }
  }

  static Result fromString(String string) {
    Result result = Result();
    string.split('').forEach((val) {
      final target = valueButtonMap[val];
      if (target is ButtonDetails) {
        result.put(target);
      }
    });
    return result;
  }

  static Result fromNumber(num number) {
    final string = number.toString().replaceAll(RegExp(r'\.0*$'), '');
    return fromString(string);
  }

  String get result => toString();

  ButtonDetails get operator => _detailsList[0];

  String format() {
    return toThousands(result);
  }

  double toValue() {
    if (isOperator) {
      return 0.0;
    }
    return double.parse(result);
  }

  @override
  String toString() {
    if (isOperator) {
      return operator.toString();
    }
    return _detailsList.map((item) => item.toString()).join('');
  }

  @override
  Result operator +(other) {
    if (other is! Result) {
      return this;
    }
    double value = this.toValue() + other.toValue();
    return Result.fromNumber(value);
  }

  @override
  Result operator -(other) {
    if (other is! Result) {
      return this;
    }
    double value = this.toValue() - other.toValue();
    return Result.fromNumber(value);
  }

  @override
  Result operator *(other) {
    if (other is! Result) {
      return this;
    }
    double value = this.toValue() * other.toValue();
    return Result.fromNumber(value);
  }

  @override
  Result operator /(other) {
    if (other is! Result) {
      return this;
    }
    double value = this.toValue() / other.toValue();
    return Result.fromNumber(value);
  }
}
