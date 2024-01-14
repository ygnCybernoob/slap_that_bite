import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class GameLogicController extends GetxController {
  //
  @override
  void onInit() {
    super.onInit();

    _mosquitoList = RxList.generate(
      9,
      (index) => Mosquito(
        controller: _controller,
        index: index,
      ),
    );

    start();
  }

  final RxInt _studyTime = 0.obs;

  String get studyTime {
    int totalSeconds = _studyTime.value;
    int hour = totalSeconds ~/ 60 % 60;
    int minute = totalSeconds % 60;

    return '$hour:${minute > 9 ? minute : '0$minute'}';
  }

  void start() {
    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      _studyTime.value = timer.tick;
    });

    Timer.periodic(const Duration(milliseconds: 900), (timer) {
      _generatePosition();
    });

    _controller.addListener(() {
      print(_controller.index);
    });
  }

  final MosquitoController _controller = MosquitoController();

  late RxList<Mosquito> _mosquitoList;

  RxList<Mosquito> get mosquitoList => _mosquitoList;

  final RxInt _killed = 0.obs;

  int get killed => _killed.value;

  final RxInt _missed = 0.obs;

  int get missed => _missed.value;

  void _generatePosition() {
    bool isFull = true;

    for (var i in _mosquitoList) {
      if (!i.show) {
        isFull = false;
        break;
      }
    }

    if (isFull) return;

    while (true) {
      int index = Random().nextInt(9);

      if (_mosquitoList[index].show) continue;

      _mosquitoList[index] = _mosquitoList[index]
        ..bite(
          onFinished: (isDead) {
            if (!isDead) {
              _missed.value++;
            }
          },
        );

      break;
    }
  }

  void kill(int index) {
    _killed.value++;
    print('kill: $killed');
    _mosquitoList[index] = _mosquitoList[index]..kill();
  }
}

class MosquitoController extends ChangeNotifier {
  late int index;

  makeChanges(int value) {
    index = value;
    notifyListeners();
  }
}

class Mosquito {
  final MosquitoController controller;
  final int index;

  Mosquito({
    required this.controller,
    required this.index,
  });

  int level = 1;
  int _life = 2;
  bool _show = false;

  bool get show => _show;

  bool _dead = false;

  bool get dead => _dead;

  Timer? _duration;

  void kill() {
    _life--;

    if (_life == 0) {
      _dead = true;
    }
  }

  void bite({required void Function(bool isDead) onFinished}) {
    _duration = Timer(const Duration(seconds: 3), () {
      // controller.makeChanges(index);
      _dead = _life == 0;

      onFinished(_dead);

      _show = false;
      _dead = false;

      _duration!.cancel();
    });

    _life = 2;
    _dead = false;
    _show = true;
  }
}
