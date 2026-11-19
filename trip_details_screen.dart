import 'package:flutter/material.dart';
import '../../data/sample_data.dart';
import '../../utils/app_routes.dart';
import '../../utils/app_spacing.dart';
import '../../utils/app_text_styles.dart';
import '../../utils/validators.dart';
import '../../widgets/app_buttons.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/common.dart';
import '../../widgets/pill_chip.dart';
import '../../widgets/segmented_selector.dart';

/// Step 2 of planning: destination, dates, pace, budget, filters, landmarks.
class TripDetailsScreen extends StatefulWidget {
  const TripDetailsScreen({super.key});

  @override
  State<TripDetailsScreen> createState() => _TripDetailsScreenState();
}

class _TripDetailsScreenState extends State<TripDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _destination = TextEditingController(text: 'Istanbul, Türkiye');
  final _start = TextEditingController();
  final _end = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;

  String _pace = 'Balanced';
  String _budget = 'Mid-range';
  double _maxPrice = 40;
  double _maxDistance = 5;
  final Set<String> _landmarks = {'Hagia Sophia', 'Galata Tower'};

  static const _months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
  ];
  String _fmt(DateTime d) => '${d.day} ${_months[d.month - 1]} ${d.year}';

  @override
  void dispose() {
    _destination.dispose();
    _start.dispose();
    _end.dispose();
    super.dispose();
  }

  Future<void> _pickDate({required bool isStart}) async {
    final now = DateTime.now();
    final first = isStart ? now : (_startDate ?? now);
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime(first.year, first.month, first.day),
      lastDate: DateTime(now.year + 2),
      initialDate: isStart ? (_startDate ?? now) : (_endDate ?? first),
    );
    if (picked == null) return;
    setState(() {
      if (isStart) {
        _startDate = picked;
        _start.text = _fmt(picked);
        if (_endDate != null && _endDate!.isBefore(picked)) {
          _endDate = null;
          _end.clear();
        }
      } else {
        _endDate = picked;
        _end.text = _fmt(picked);
      }
    });
  }

  void _generate() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.pushNamed(context, AppRoutes.generating);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: ResponsiveBody(
          child: Form(
            key: _formKey,
            child: ListView(
              padding: AppSpacing.screenPadding,
              children: [
                const TopNav(step: 'Step 2 of 2'),
                const Gap(AppSpacing.md),
                const ScreenHeader(title: 'Trip details'),
                const Gap(AppSpacing.lg),
                AppTextField(
                  label: 'Destination',
                  hint: 'City, country',
                  controller: _destination,
                  validator: (v) => Validators.required(v, 'Destination'),
                ),
                const Gap(AppSpacing.lg),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: AppTextField(
                        label: 'Start',
                        hint: 'Pick date',
                        controller: _start,
                        readOnly: true,
                        onTap: () => _pickDate(isStart: true),
                        validator: (v) => Validators.required(v, 'Start'),
                      ),
                    ),
                    const Gap.h(AppSpacing.md),
                    Expanded(
                      child: AppTextField(
                        label: 'End',
                        hint: 'Pick date',
                        controller: _end,
                        readOnly: true,
                        onTap: () => _pickDate(isStart: false),
                        validator: (v) => Validators.required(v, 'End'),
                      ),
                    ),
                  ],
                ),
                const Gap(AppSpacing.lg),
                SegmentedSelector(
                  label: 'Pace',
                  options: const ['Relaxed', 'Balanced', 'Packed'],
                  value: _pace,
                  onChanged: (v) => setState(() => _pace = v),
                ),
                const Gap(AppSpacing.lg),
                SegmentedSelector(
                  label: 'Budget range · USD',
                  options: const ['Budget', 'Mid-range', 'Luxury'],
                  value: _budget,
                  onChanged: (v) => setState(() => _budget = v),
                ),
                const Gap(AppSpacing.lg),
                _SliderRow(
                  label: 'Max price per activity',
                  valueLabel: '\$${_maxPrice.round()}',
                  value: _maxPrice,
                  min: 0,
                  max: 100,
                  onChanged: (v) => setState(() => _maxPrice = v),
                ),
                _SliderRow(
                  label: 'Max distance between stops',
                  valueLabel: '${_maxDistance.round()} km',
                  value: _maxDistance,
                  min: 1,
                  max: 20,
                  onChanged: (v) => setState(() => _maxDistance = v),
                ),
                const Gap(AppSpacing.sm),
                ChipGroup(
                  title: 'Landmarks to include (optional)',
                  options: SampleData.landmarks,
                  selected: _landmarks,
                  onToggle: (l) => setState(() {
                    _landmarks.contains(l)
                        ? _landmarks.remove(l)
                        : _landmarks.add(l);
                  }),
                ),
                const Gap(AppSpacing.xl),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomActionBar(
        child: PrimaryButton(label: 'Generate plan', onPressed: _generate),
      ),
    );
  }
}

class _SliderRow extends StatelessWidget {
  final String label;
  final String valueLabel;
  final double value;
  final double min;
  final double max;
  final ValueChanged<double> onChanged;

  const _SliderRow({
    required this.label,
    required this.valueLabel,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(label,
                  style: AppTextStyles.chip,
                  overflow: TextOverflow.ellipsis),
            ),
            Text(valueLabel, style: AppTextStyles.sectionTitle),
          ],
        ),
        Slider(value: value, min: min, max: max, onChanged: onChanged),
      ],
    );
  }
}
