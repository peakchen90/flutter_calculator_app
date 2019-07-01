import 'dart:async';

int _timer = 0;

final timerMap = Map<int, Timer>();

typedef void Callback();

// 设置定时器
int setTimeout(Callback callback, [milliseconds = 0]) {
  final nextTimer = ++_timer;
  timerMap[nextTimer] = Timer(Duration(milliseconds: milliseconds), () {
    callback();
  });
  return nextTimer;
}

// 取消定时器
void clearTimeout(int timer) {
  final target = timerMap[timer];
  if (target is Timer) {
    target.cancel();
  }
}
