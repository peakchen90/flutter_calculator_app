// 转千分位
String toThousands(String string) {
  final arr = string.split('.');
  String integerStr = arr[0];
  String decimalStr = '';
  bool hasDot = false;
  if (arr.length >= 2) {
    decimalStr = arr.sublist(1).join('');
    hasDot = true;
  }

  String temp = '';
  int len = integerStr.length;
  int lastIndex = len - 1;
  for (int i = 0; i <= len - 1; i++) {
    final val = integerStr[lastIndex - i];
    temp = val + temp;
    if (i != lastIndex &&
        (i + 1) % 3 == 0 &&
        (i != lastIndex && integerStr[lastIndex - 1] != '-')) {
      temp = ',' + temp;
    }
  }
  integerStr = temp;

  if (hasDot) {
    return integerStr + '.' + decimalStr;
  }
  return integerStr;
}
