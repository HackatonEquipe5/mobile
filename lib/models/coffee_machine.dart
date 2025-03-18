class CoffeeMachine {
  final String name;
  final String? imageUrl;
  String id;
  bool isFavorite;
  bool isWorking;

  CoffeeMachine({
    required this.name,
    this.imageUrl,
    this.isFavorite = false,
    this .id = "00-01",
    required this.isWorking,
  });
}