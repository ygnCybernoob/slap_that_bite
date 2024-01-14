class Util {
  static String studyTimeFromSecond(int totalSeconds) {
    int hour = totalSeconds ~/ 60 ~/ 60;
    int minute = totalSeconds ~/ 60;

    return '$hour:$minute';
  }
}
