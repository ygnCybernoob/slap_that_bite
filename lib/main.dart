import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:slap_that_bite/game_logic_controller.dart';
import 'package:slap_that_bite/root_binding.dart';

import 'package:vibration/vibration.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const GameApp());
  // runApp(GameWidget(game: LevelsExample()));
}

class GameApp extends StatelessWidget {
  const GameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Slap that Bite',
      initialBinding: RootBinding(),
      home: GamePage(),
    );
  }
}

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    double side = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.deepOrange.shade100,
          ),
          Positioned(
            left: 32,
            top: 60,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Study Time',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Obx(
                      () => Text(
                        '${Get.find<GameLogicController>().studyTime}',
                        style: TextStyle(
                          fontSize: 32,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Slap',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Obx(
                      () => Text(
                        '${Get.find<GameLogicController>().killed}',
                        style: TextStyle(
                          fontSize: 32,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Missed',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Obx(
                      () => Text(
                        '${Get.find<GameLogicController>().missed}',
                        style: TextStyle(
                          fontSize: 32,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            right: 32,
            top: 60,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.pause),
                  iconSize: 40,
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.music_off),
                  iconSize: 40,
                ),
                const SizedBox(height: 24),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.star),
                  iconSize: 40,
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: side,
              height: side,
              alignment: Alignment.center,
              // color: Colors.amber.shade100,
              child: SizedBox(
                // color: Colors.blue.shade100,
                width: 320,
                height: 320,
                child: GridView(
                  padding: const EdgeInsets.all(0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 24,
                    crossAxisSpacing: 24,
                  ),
                  children: [
                    buildButton(0),
                    buildButton(1),
                    buildButton(2),
                    buildButton(3),
                    buildButton(4),
                    buildButton(5),
                    buildButton(6),
                    buildButton(7),
                    buildButton(8),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  buildButton(int index) {
    final player = AudioPlayer();
    return Obx(
      () {
        final gameControl = Get.find<GameLogicController>();

        return Container(
          decoration: const BoxDecoration(
            color: Colors.black12,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: gameControl.mosquitoList[index].show
              ? InkWell(
                  onTap: () async {
                    gameControl.kill(index);

                    Vibration.vibrate(duration: 40, amplitude: 100);

                    await player.play(AssetSource('audios/squish.wav'));
                  },
                  child: Image.asset(
                    gameControl.mosquitoList[index].dead
                        ? 'assets/images/splash.png'
                        : 'assets/images/mosquito.png',
                    width: 60,
                    height: 60,
                  ),
                )
              : null,
        );
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.blue.shade100,
            ),
          ),
          Positioned(
            left: 32,
            top: 60,
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.shop),
              iconSize: 40,
            ),
          ),
          Positioned(
            right: 32,
            top: 60,
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.volume_off),
              iconSize: 40,
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Slap that Bite',
                  style: TextStyle(
                    fontSize: 40,
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: 180,
                  height: 54,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('Play'),
                    style: ButtonStyle(
                      shape: MaterialStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
