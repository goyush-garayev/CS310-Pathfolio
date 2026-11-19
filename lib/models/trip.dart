import 'activity.dart';

/// Weather for one day (placeholder data until we use a weather API).
class DayWeather {
  final String day; // "Thu"
  final int tempC;
  final String condition; // "Sunny"

  const DayWeather(this.day, this.tempC, this.condition);
}

/// One day of a trip with its list of activities.
class TripDay {
  final String label; // "Thu 12 Nov"
  final List<Activity> activities;

  TripDay({required this.label, required this.activities});

  double get total => activities.fold(0, (sum, a) => sum + a.cost);
}

/// A saved trip.
class Trip {
  final String id;
  final String city;
  final String country;
  final String dateRange; // "12–15 Nov"
  final String pace; // Relaxed / Balanced / Packed
  final List<TripDay> days;
  final List<DayWeather> weather;

  Trip({
    required this.id,
    required this.city,
    required this.country,
    required this.dateRange,
    required this.pace,
    required this.days,
    this.weather = const [],
  });

  double get totalCost => days.fold(0, (sum, d) => sum + d.total);

  int get dayCount => days.length;
}
