class CoffeeMachine {
  final String name;
  final String imageUrl;
  bool isFavorite;
  bool isWorking;

  CoffeeMachine({
    required this.name,
    required this.imageUrl,
    this.isFavorite = false,
    required this.isWorking,
  });
}