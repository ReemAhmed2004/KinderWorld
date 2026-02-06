import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kinder_world/core/localization/app_localizations.dart';
import 'package:kinder_world/core/subscription/plan_info.dart';
import 'package:kinder_world/core/providers/plan_provider.dart';
import 'package:kinder_world/core/widgets/plan_status_banner.dart';
import 'package:kinder_world/core/widgets/premium_badge.dart';
import 'package:kinder_world/core/widgets/premium_section_upsell.dart';

class ParentalControlsScreen extends ConsumerStatefulWidget {
  const ParentalControlsScreen({super.key});

  @override
  ConsumerState<ParentalControlsScreen> createState() =>
      _ParentalControlsScreenState();
}

class _ParentalControlsScreenState
    extends ConsumerState<ParentalControlsScreen> {
  bool _dailyLimitEnabled = true;
  double _hoursPerDay = 2;
  bool _breakRemindersEnabled = true;

  bool _ageAppropriateOnly = true;
  bool _blockEducational = false;
  bool _requireApproval = false;

  bool _sleepMode = true;
  String _bedtime = '8:00 PM';
  String _wakeTime = '7:00 AM';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final textTheme = theme.textTheme;
    final plan =
        ref.watch(planInfoProvider).asData?.value ?? PlanInfo.fromTier(PlanTier.free);
    final isAdvancedLocked = !plan.hasSmartControls;
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(l10n.parentalControls),
        backgroundColor: colors.surface,
        foregroundColor: colors.onSurface,
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      l10n.contentRestrictionsAndScreenTime,
                      style: textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      l10n.manageChildAccess,
                      style: textTheme.bodyMedium?.copyWith(
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const PlanStatusBanner(),
                    const SizedBox(height: 24),

                    _buildControlSection(
                      l10n.screenTimeLimits,
                      Icons.timer,
                      [
                        _buildToggleSetting(
                          l10n.dailyLimit,
                          _dailyLimitEnabled,
                          (value) => setState(() => _dailyLimitEnabled = value),
                        ),
                        _buildSliderSetting(
                          l10n.hoursPerDay,
                          _hoursPerDay,
                          0,
                          6,
                          (value) => setState(() => _hoursPerDay = value),
                        ),
                        _buildToggleSetting(
                          l10n.breakReminders,
                          _breakRemindersEnabled,
                          (value) =>
                              setState(() => _breakRemindersEnabled = value),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    _buildControlSection(
                      l10n.contentFiltering,
                      Icons.filter_list,
                      [
                        _buildToggleSetting(
                          l10n.ageAppropriate,
                          _ageAppropriateOnly,
                          (value) => setState(() => _ageAppropriateOnly = value),
                        ),
                        _buildToggleSetting(
                          l10n.blockContent,
                          _blockEducational,
                          (value) => setState(() => _blockEducational = value),
                        ),
                        _buildToggleSetting(
                          l10n.requireApproval,
                          _requireApproval,
                          (value) => setState(() => _requireApproval = value),
                        ),
                      ],
                      trailing: const PremiumBadge(),
                      isDimmed: isAdvancedLocked,
                      footer: isAdvancedLocked
                          ? PremiumSectionUpsell(
                              title: l10n.planFeatureInPremium,
                              description: l10n.smartControl,
                              buttonLabel: l10n.upgradeNow,
                              showBadge: false,
                              padding: const EdgeInsets.all(12),
                            )
                          : null,
                    ),

                    const SizedBox(height: 24),

                    _buildControlSection(
                      l10n.timeRestrictions,
                      Icons.access_time,
                      [
                        _buildToggleSetting(
                          l10n.sleepMode,
                          _sleepMode,
                          (value) => setState(() => _sleepMode = value),
                        ),
                        _buildTimeSetting(l10n.bedtime, _bedtime,
                            isBedtime: true),
                        _buildTimeSetting(l10n.wakeTime, _wakeTime,
                            isBedtime: false),
                      ],
                      trailing: const PremiumBadge(),
                      isDimmed: isAdvancedLocked,
                      footer: isAdvancedLocked
                          ? PremiumSectionUpsell(
                              title: l10n.planFeatureInPremium,
                              description: l10n.smartControl,
                              buttonLabel: l10n.upgradeNow,
                              showBadge: false,
                              padding: const EdgeInsets.all(12),
                            )
                          : null,
                    ),

                    const SizedBox(height: 40),

                    // Emergency Controls
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: colors.error.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: colors.error.withValues(alpha: 0.4),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.emergencyControls,
                            style: textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: colors.error,
                            ),
                          ),
                          const SizedBox(height: 16),

                          ElevatedButton.icon(
                            onPressed: () {
                              // TODO: Implement emergency lock
                            },
                            icon: const Icon(Icons.lock),
                            label: Text(l10n.lockAppNow),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: colors.error,
                              foregroundColor: colors.onError,
                              minimumSize: const Size(double.infinity, 48),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildControlSection(
    String title,
    IconData icon,
    List<Widget> controls, {
    Widget? trailing,
    Widget? footer,
    bool isDimmed = false,
  }) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: colors.shadow.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: colors.primary, size: 24),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (trailing != null) trailing,
            ],
          ),
          const SizedBox(height: 20),
          Opacity(
            opacity: isDimmed ? 0.55 : 1,
            child: IgnorePointer(
              ignoring: isDimmed,
              child: Column(children: controls),
            ),
          ),
          if (footer != null) footer,
        ],
      ),
    );
  }

  Widget _buildToggleSetting(
    String title,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: textTheme.bodyMedium,
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: colors.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildSliderSetting(
    String title,
    double value,
    double min,
    double max,
    ValueChanged<double> onChanged,
  ) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: textTheme.bodyMedium,
          ),
          const SizedBox(height: 8),
          Slider(
            value: value,
            min: min,
            max: max,
            onChanged: onChanged,
            activeColor: colors.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildTimeSetting(String title, String time, {required bool isBedtime}) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: textTheme.bodyMedium,
          ),
          TextButton(
            onPressed: () {
              _showTimePicker(
                isBedtime,
                (value) => setState(() {
                  if (isBedtime) {
                    _bedtime = value;
                  } else {
                    _wakeTime = value;
                  }
                }),
              );
            },
            child: Text(
              time,
              style: textTheme.bodyMedium?.copyWith(
                color: colors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showTimePicker(bool isBedtime, ValueChanged<String> onSelected) {
    final options = isBedtime
        ? const ['7:00 PM', '7:30 PM', '8:00 PM', '8:30 PM', '9:00 PM']
        : const ['6:00 AM', '6:30 AM', '7:00 AM', '7:30 AM', '8:00 AM'];

    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return SafeArea(
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: options.length,
            separatorBuilder: (context, index) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final value = options[index];
              return ListTile(
                title: Text(value),
                onTap: () {
                  onSelected(value);
                  Navigator.of(context).pop();
                },
              );
            },
          ),
        );
      },
    );
  }
}
