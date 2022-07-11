import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stop_watch/shared_preferences/shared_preference_helper.dart';

class StopWatchViewModel extends ChangeNotifier {
  ValueNotifier<Duration> stopWatchTime =
      ValueNotifier(const Duration(seconds: 0));
  late Timer _timer;
  addTime({bool isReset = false}) {
    stopWatchTime.value =
        Duration(seconds: isReset ? 0 : stopWatchTime.value.inSeconds + 1);
    SharedPreferenceHelper.saveStopWatch(stopWatchTime.value.inSeconds);
    stopWatchTime.notifyListeners();
  }

  ValueNotifier<bool> isRunning = ValueNotifier(false);
  set setIsRunning(bool value) {
    isRunning.value = value;
    isRunning.notifyListeners();
  }

  startStopWatch() {
    setIsRunning = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      addTime();
    });
  }

  void resetStopWatch() {
    setIsRunning = false;
    SharedPreferenceHelper.reset();
    if (stopWatchTime.value.inSeconds != 0) {
      _timer.cancel();
      addTime(isReset: true);
    }
  }

  pauseStopWatch() {
    setIsRunning = false;
    _timer.cancel();
  }

  void changeStopWatchStatus() {
    if (!isRunning.value) {
      startStopWatch();
    } else {
      pauseStopWatch();
    }
  }
}
