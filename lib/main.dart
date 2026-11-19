import 'package:flutter/material.dart';
import 'screens/auth/log_in_screen.dart';
import 'screens/auth/sign_up_screen.dart';
import 'screens/auth/welcome_screen.dart';
import 'screens/main/main_shell.dart';
import 'screens/plan/generating_screen.dart';
import 'screens/plan/preferences_screen.dart';
import 'screens/plan/trip_details_screen.dart';
import 'screens/trip/activity_details_screen.dart';
import 'screens/trip/add_activity_screen.dart';
import 'screens/trip/itinerary_screen.dart';
import 'screens/trip/trip_args.dart';
import 'utils/app_routes.dart';
import 'utils/app_theme.dart';

void main() {
  runApp(const PathFolioApp());
}

class PathFolioApp extends StatelessWidget {
  const PathFolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PathFolio',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      initialRoute: AppRoutes.welcome,
      onGenerateRoute: _onGenerateRoute,
    );
  }

  /// All navigation goes through here. Screens that need data get it as arguments.
  static Route<dynamic> _onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;

    Widget page;
    switch (settings.name) {
      case AppRoutes.welcome:
        page = const WelcomeScreen();
        break;
      case AppRoutes.signUp:
        page = const SignUpScreen();
        break;
      case AppRoutes.logIn:
        page = const LogInScreen();
        break;
      case AppRoutes.main:
        page = MainShell(initialIndex: args is int ? args : 0);
        break;
      case AppRoutes.preferences:
        page = const PreferencesScreen();
        break;
      case AppRoutes.tripDetails:
        page = const TripDetailsScreen();
        break;
      case AppRoutes.generating:
        page = const GeneratingScreen();
        break;
      case AppRoutes.itinerary:
        page = ItineraryScreen(tripId: args is String ? args : null);
        break;
      case AppRoutes.activityDetails:
        page = ActivityDetailsScreen(args: args as ActivityArgs);
        break;
      case AppRoutes.addActivity:
        page = AddActivityScreen(args: args as ActivityArgs);
        break;
      default:
        page = const WelcomeScreen();
    }

    return MaterialPageRoute(builder: (_) => page, settings: settings);
  }
}
