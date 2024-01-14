# slap_that_bite

final leftSound = await AudioPool.create();
final rightSound = await AudioPool.create();

void playLeftSound() {
  leftSound.play('sound_left.ogg', pan: -1.0); // Pan left
}

void playRightSound() {
  rightSound.play('sound_right.ogg', pan: 1.0); // Pan right
}