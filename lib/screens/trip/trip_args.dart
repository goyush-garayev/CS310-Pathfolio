/// Arguments passed to Activity details and Add activity screens.
class ActivityArgs {
  final String tripId;
  final int dayIndex;
  final String? activityId; // null when adding a new one

  const ActivityArgs({
    required this.tripId,
    required this.dayIndex,
    this.activityId,
  });
}
