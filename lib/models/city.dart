/// A city shown on the Home screen as an idea card.
class City {
  final String name;
  final String country;
  final String imageUrl; // network image

  const City({
    required this.name,
    required this.country,
    required this.imageUrl,
  });
}
