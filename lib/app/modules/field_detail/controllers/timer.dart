// import 'dart:async';

// import 'package:get/get.dart';

// class Countdown {
//   late Timer _timer;
//   int _totalSeconds = 0;
//   Function(String) onTimeChanged;

//   Countdown(int days, int _totalSeconds, this.onTimeChanged) {
//     _totalSeconds = _totalSeconds;
//     _startTimer();
//   }

//   void _startTimer() {
//     _timer = Timer.periodic(Duration(seconds: 1), (timer) {
//       _totalSeconds--;
//       if (_totalSeconds == 0) {
//         timer.cancel();
//       }
//       _displayTime();
//     });
//   }

//   void _displayTime() {
//     int days = _totalSeconds ~/ (24 * 60 * 60);
//     int hours = (_totalSeconds % (24 * 60 * 60)) ~/ 3600;
//     int minutes = (_totalSeconds % 3600) ~/ 60;
//     int seconds = _totalSeconds % 60;

//     String time =
//         '$days天 ${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
//     onTimeChanged(time);
//   }
// }

import 'dart:async';

class Countdown {
  late Timer _timer;
  int _totalSeconds = 0;
  Function(String) onTimeChanged;

  Countdown(int totalSeconds, this.onTimeChanged) {
    _totalSeconds = totalSeconds;
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _totalSeconds--;
      if (_totalSeconds == 0) {
        timer.cancel();
      }
      _displayTime();
    });
  }

  void _displayTime() {
    int days = _totalSeconds ~/ (24 * 60 * 60);
    int hours = (_totalSeconds % (24 * 60 * 60)) ~/ 3600;
    int minutes = (_totalSeconds % 3600) ~/ 60;
    int seconds = _totalSeconds % 60;

    String time =
        '$days天 ${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    onTimeChanged(time);
  }

  void dispose() {
    if (_timer.isActive) {
      _timer.cancel();
    }
  }
}
