import 'package:get/get.dart';
import 'package:slap_that_bite/game_logic_controller.dart';

class RootBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GameLogicController>(() => GameLogicController());
  }
}
