import 'package:flutter/material.dart';
import '../../data/sample_data.dart';
import '../../utils/app_routes.dart';
import '../../utils/app_spacing.dart';
import '../../widgets/app_buttons.dart';
import '../../widgets/common.dart';
import '../../widgets/pill_chip.dart';

/// Step 1 of planning: pick what you like from chip groups.
class PreferencesScreen extends StatefulWidget {
  const PreferencesScreen({super.key});

  @override
  State<PreferencesScreen> createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends State<PreferencesScreen> {
  // A few chips start selected, like in the design
  final Set<String> _selected = {
    'History',
    'Art & museums',
    'Local cuisine',
    'Street food',
    'Markets',
    'Old town',
    'Viewpoints',
  };

  void _toggle(String item) {
    setState(() {
      _selected.contains(item) ? _selected.remove(item) : _selected.add(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    final groups = SampleData.preferenceGroups;

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: ResponsiveBody(
          child: ListView(
            padding: AppSpacing.screenPadding,
            children: [
              const TopNav(step: 'Step 1 of 2'),
              const Gap(AppSpacing.md),
              const ScreenHeader(
                title: 'What do you enjoy?',
                subtitle:
                    'Pick as many as you like. We use these to build your plan.',
              ),
              const Gap(AppSpacing.lg),
              for (final entry in groups.entries) ...[
                ChipGroup(
                  title: entry.key,
                  options: entry.value,
                  selected: _selected,
                  onToggle: _toggle,
                ),
                const Gap(AppSpacing.lg),
              ],
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomActionBar(
        child: PrimaryButton(
          label: _selected.isEmpty
              ? 'Pick at least one'
              : 'Continue (${_selected.length} selected)',
          onPressed: _selected.isEmpty
              ? null
              : () => Navigator.pushNamed(context, AppRoutes.tripDetails),
        ),
      ),
    );
  }
}
