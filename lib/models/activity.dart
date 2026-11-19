/// One stop in a day of the itinerary.
class Activity {
  final String id;
  final String name;
  final String category; // e.g. Landmark, Food, Museum
  final String time; // "09:00"
  final double durationHours;
  final double cost; // estimated cost in USD
  final String description;
  final String tip;

  const Activity({
    required this.id,
    required this.name,
    required this.category,
    required this.time,
    required this.durationHours,
    required this.cost,
    this.description = '',
    this.tip = '',
  });

  /// "Morning", "Afternoon" or "Evening", based on the start time.
  String get partOfDay {
    final hour = int.tryParse(time.split(':').first) ?? 12;
    if (hour < 12) return 'Morning';
    if (hour < 18) return 'Afternoon';
    return 'Evening';
  }

  /// "2 h" or "1.5 h"
  String get durationLabel {
    final d = durationHours;
    return d == d.roundToDouble() ? '${d.toInt()} h' : '$d h';
  }
}
