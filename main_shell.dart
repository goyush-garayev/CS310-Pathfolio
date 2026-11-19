import 'package:flutter/material.dart';
import '../../widgets/pill_nav_bar.dart';
import 'account_screen.dart';
import 'home_screen.dart';
import 'saved_trips_screen.dart';

/// Holds the 3 tabs (Explore, Trips, Account) with the pill nav bar.
class MainShell extends StatefulWidget {
  final int initialIndex;
  const MainShell({super.key, this.initialIndex = 0});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  late int _index = widget.initialIndex;

  void _goTo(int i) => setState(() => _index = i);

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomeScreen(onOpenTrips: () => _goTo(1)),
      const SavedTripsScreen(),
      const AccountScreen(),
    ];

    return Scaffold(
      extendBody: true, // content goes under the floating bar
      body: IndexedStack(index: _index, children: pages),
      bottomNavigationBar: PillNavBar(currentIndex: _index, onTap: _goTo),
    );
  }
}
