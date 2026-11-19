import '../models/activity.dart';
import '../models/city.dart';
import '../models/trip.dart';

/// Placeholder data for Step 2. In Step 3 this will come from Firebase.
class SampleData {
  SampleData._();

  static const List<City> cities = [
    City(
      name: 'Istanbul',
      country: 'Türkiye',
      imageUrl:
          'https://images.unsplash.com/photo-1524231757912-21f4fe3a7200?w=600',
    ),
    City(
      name: 'Lisbon',
      country: 'Portugal',
      imageUrl:
          'https://images.unsplash.com/photo-1585208798174-6cedd86e019a?w=600',
    ),
    City(
      name: 'Prague',
      country: 'Czechia',
      imageUrl:
          'https://images.unsplash.com/photo-1541849546-216549ae216d?w=600',
    ),
    City(
      name: 'Rome',
      country: 'Italy',
      imageUrl:
          'https://images.unsplash.com/photo-1552832230-c0197dd311b5?w=600',
    ),
  ];

  /// Preference groups shown on the Preferences screen.
  static const Map<String, List<String>> preferenceGroups = {
    'Interests': [
      'History',
      'Art & museums',
      'Nature',
      'Nightlife',
      'Photography',
      'Architecture',
      'Family friendly',
    ],
    'Adventure & sports': [
      'Hiking',
      'Scuba diving',
      'Skiing',
      'Surfing',
      'Swimming',
      'Climbing',
      'Running',
    ],
    'Food': [
      'Local cuisine',
      'Street food',
      'Cafés',
      'Fine dining',
      'Vegetarian',
    ],
    'Shopping': [
      'Markets',
      'Local crafts',
      'Malls',
      'Vintage',
    ],
    'Places to visit': [
      'Old town',
      'Parks',
      'Viewpoints',
      'Beaches & coast',
      'Zoos',
      'Amusement parks',
    ],
    'Relaxation & wellness': [
      'Spas',
      'Hot springs',
      'Meditation',
    ],
  };

  static const List<String> landmarks = [
    'Hagia Sophia',
    'Galata Tower',
    'Grand Bazaar',
    'Topkapı Palace',
  ];

  static const List<String> activityCategories = [
    'Landmark',
    'Food',
    'Museum',
    'Shopping',
    'Nature',
  ];

  static List<Trip> trips() => [
        Trip(
          id: 't1',
          city: 'Istanbul',
          country: 'Türkiye',
          dateRange: '12–15 Nov',
          pace: 'Balanced',
          weather: const [
            DayWeather('Thu', 16, 'Sunny'),
            DayWeather('Fri', 15, 'Cloudy'),
            DayWeather('Sat', 13, 'Rain'),
            DayWeather('Sun', 14, 'Cloudy'),
          ],
          days: [
            TripDay(label: 'Thu 12 Nov', activities: [
              const Activity(
                id: 'a1',
                name: 'Hagia Sophia',
                category: 'Landmark',
                time: '09:00',
                durationHours: 2,
                cost: 25,
                description:
                    'A huge church that became a mosque. Famous for its big dome and old mosaics. Go early, the line gets long after 10:00.',
                tip: 'Women need a scarf to enter. You can borrow one at the door.',
              ),
              const Activity(
                id: 'a2',
                name: 'Çiya Sofrası',
                category: 'Local cuisine',
                time: '13:00',
                durationHours: 1.5,
                cost: 18,
                description:
                    'A well-known restaurant in Kadıköy with home-style Anatolian food.',
                tip: 'Take the ferry from Eminönü, it is cheap and the view is great.',
              ),
              const Activity(
                id: 'a3',
                name: 'Galata Tower',
                category: 'Viewpoint',
                time: '16:30',
                durationHours: 1,
                cost: 11,
                description:
                    'A medieval stone tower with a 360° view of the city. Sunset is the best time.',
                tip: 'Buy the ticket online to skip the line.',
              ),
            ]),
            TripDay(label: 'Fri 13 Nov', activities: [
              const Activity(
                id: 'a4',
                name: 'Topkapı Palace',
                category: 'Museum',
                time: '10:00',
                durationHours: 3,
                cost: 30,
                description: 'The old palace of the Ottoman sultans.',
              ),
              const Activity(
                id: 'a5',
                name: 'Grand Bazaar',
                category: 'Shopping',
                time: '14:00',
                durationHours: 2,
                cost: 20,
                description: 'One of the biggest and oldest covered markets.',
              ),
            ]),
            TripDay(label: 'Sat 14 Nov', activities: [
              const Activity(
                id: 'a6',
                name: 'Bosphorus cruise',
                category: 'Nature',
                time: '11:00',
                durationHours: 2,
                cost: 15,
              ),
              const Activity(
                id: 'a7',
                name: 'Karaköy street food',
                category: 'Food',
                time: '19:00',
                durationHours: 1.5,
                cost: 12,
              ),
            ]),
            TripDay(label: 'Sun 15 Nov', activities: [
              const Activity(
                id: 'a8',
                name: 'Balat walk',
                category: 'Old town',
                time: '10:00',
                durationHours: 2.5,
                cost: 0,
              ),
              const Activity(
                id: 'a9',
                name: 'Pierre Loti café',
                category: 'Café',
                time: '15:00',
                durationHours: 1,
                cost: 8,
              ),
            ]),
          ],
        ),
        Trip(
          id: 't2',
          city: 'Lisbon',
          country: 'Portugal',
          dateRange: '3–6 Dec',
          pace: 'Relaxed',
          days: [
            TripDay(label: 'Thu 3 Dec', activities: [
              const Activity(
                id: 'b1',
                name: 'Belém Tower',
                category: 'Landmark',
                time: '10:00',
                durationHours: 1.5,
                cost: 10,
              ),
              const Activity(
                id: 'b2',
                name: 'Pastéis de Belém',
                category: 'Café',
                time: '12:00',
                durationHours: 1,
                cost: 6,
              ),
            ]),
          ],
        ),
        Trip(
          id: 't3',
          city: 'Prague',
          country: 'Czechia',
          dateRange: '20–23 Jan',
          pace: 'Packed',
          days: [
            TripDay(label: 'Wed 20 Jan', activities: [
              const Activity(
                id: 'c1',
                name: 'Charles Bridge',
                category: 'Landmark',
                time: '08:30',
                durationHours: 1,
                cost: 0,
              ),
              const Activity(
                id: 'c2',
                name: 'Prague Castle',
                category: 'Museum',
                time: '10:00',
                durationHours: 3,
                cost: 18,
              ),
            ]),
          ],
        ),
      ];
}
