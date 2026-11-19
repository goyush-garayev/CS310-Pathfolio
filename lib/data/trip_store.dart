import 'package:flutter/foundation.dart';
import '../models/activity.dart';
import '../models/trip.dart';
import 'sample_data.dart';

/// Keeps the trips in memory while the app runs.
/// Screens listen to it, so a remove or add updates every screen.
/// In Step 3 this class will read and write Firebase instead.
class TripStore extends ChangeNotifier {
  TripStore._();
  static final TripStore instance = TripStore._();

  final List<Trip> _trips = SampleData.trips();

  List<Trip> get trips => List.unmodifiable(_trips);

  Trip? get currentTrip => _trips.isEmpty ? null : _trips.first;

  Trip? findTrip(String id) {
    for (final t in _trips) {
      if (t.id == id) return t;
    }
    return null;
  }

  void removeTrip(Trip trip) {
    _trips.remove(trip);
    notifyListeners();
  }

  void insertTrip(int index, Trip trip) {
    _trips.insert(index.clamp(0, _trips.length), trip);
    notifyListeners();
  }

  void removeActivity(TripDay day, Activity activity) {
    day.activities.remove(activity);
    notifyListeners();
  }

  void insertActivity(TripDay day, int index, Activity activity) {
    day.activities.insert(index.clamp(0, day.activities.length), activity);
    notifyListeners();
  }

  void addActivity(TripDay day, Activity activity) {
    day.activities.add(activity);
    day.activities.sort((a, b) => a.time.compareTo(b.time));
    notifyListeners();
  }

  /// Moves an activity one step up (-1) or down (+1) in its day.
  void moveActivity(TripDay day, Activity activity, int direction) {
    final i = day.activities.indexOf(activity);
    final j = i + direction;
    if (i < 0 || j < 0 || j >= day.activities.length) return;
    day.activities
      ..removeAt(i)
      ..insert(j, activity);
    notifyListeners();
  }
}
