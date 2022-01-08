abstract class Player {
  final String name;
  final PlayerType type;
  int _score;

  Player(
    this.name,
    this.type,
  );

  int get score => _score;

  void setScore(int score) => _score = score;

}

enum PlayerType { Human, Computer}

class Human extends Player {
  Human(String name) : super(name, PlayerType.Human);
}

class Computer extends Player {
  Computer() : super('Computer', PlayerType.Computer);
}
