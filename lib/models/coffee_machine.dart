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

  static Future<List<CoffeeMachine>> fromJson(dynamic e) async {
    if (e == null) {
      return [];
    }

    try {
      if (e is List) {
        return e.map((item) => CoffeeMachine(
          name: item['name'] ?? '',
          imageUrl: item['imageUrl'],
          isFavorite: item['isFavorite'] ?? false,
          id: item['id_device'] ?? '00-01',
          isWorking: item['isWorking'] ?? true,
        )).toList();
      } else if (e is Map<String, dynamic>) {
        return [CoffeeMachine(
          name: e['name'] ?? '',
          imageUrl: e['imageUrl'],
          isFavorite: e['isFavorite'] ?? false,
          id: e['id_device'] ?? '00-01',
          isWorking: e['isWorking'] ?? true,
        )];
      }

      return [];
    } catch (error) {
      print('Erreur lors du parsing des machines à café: $error');
      return [];
    }
  }
}