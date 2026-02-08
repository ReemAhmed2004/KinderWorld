import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kinder_world/core/constants/app_constants.dart';
import 'package:kinder_world/core/providers/auth_controller.dart';
import 'package:kinder_world/core/providers/plan_provider.dart';
import 'package:kinder_world/core/providers/subscription_provider.dart';
import 'package:kinder_world/core/subscription/plan_info.dart';
import 'package:kinder_world/core/widgets/themed_card.dart';
import 'package:kinder_world/features/child_mode/paywall/payment_methods_screen.dart';
import 'package:kinder_world/router.dart';
import 'package:kinder_world/core/localization/app_localizations.dart';

class SubscriptionScreen extends ConsumerStatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  ConsumerState<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends ConsumerState<SubscriptionScreen> {
  bool _isProcessing = false;
  PlanTier? _processingTier;

  
  String _planTitle(AppLocalizations l10n, PlanTier tier) {
    switch (tier) {
      case PlanTier.free:
        return l10n.planFree;
      case PlanTier.premium:
        return l10n.planPremium;
      case PlanTier.familyPlus:
        return l10n.planFamilyPlus;
    }
  }

  Future<void> _applyPlan(PlanTier tier) async {
    await ref.read(authControllerProvider.notifier).applyPlanSelection(tier);
    ref.invalidate(planInfoProvider);
  }

  Future<void> _selectPlan({
    required PlanTier tier,
    required bool requiresPayment,
  }) async {
    if (_isProcessing) return;
    setState(() {
      _isProcessing = true;
      _processingTier = tier;
    });
    final l10n = AppLocalizations.of(context)!;
    final messenger = ScaffoldMessenger.of(context);

    try {
      if (requiresPayment) {
        await Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const PaymentMethodsScreen()),
        );
        if (!mounted) return;

        final activated = await ref
            .read(subscriptionServiceProvider)
            .activateSubscription(tier);
        if (!activated) {
          messenger.showSnackBar(
            SnackBar(content: Text(l10n.subscriptionActivationFailed)),
          );
          return;
        }
      }

      await _applyPlan(tier);
      if (!mounted) return;
      messenger.showSnackBar(
        SnackBar(content: Text(l10n.planActivated(_planTitle(l10n, tier)))),
      );
    } finally {
      if (!mounted) return;
      setState(() {
        _isProcessing = false;
        _processingTier = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final textTheme = theme.textTheme;
    final plan =
        ref.watch(planInfoProvider).asData?.value ?? PlanInfo.fromTier(PlanTier.free);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(l10n.subscriptionTitle),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              
              // Current Plan
              ThemedCard(
                padding: const EdgeInsets.all(20),
                borderRadius: BorderRadius.circular(16),
                surfaceColor: colors.secondaryContainer,
                border: Border.all(color: colors.secondary),
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: colors.secondary.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.star,
                        size: 30,
                        color: colors.secondary,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _planTitle(l10n, plan.tier),
                            style: textTheme.titleMedium?.copyWith(
                              fontSize: AppConstants.fontSize,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            l10n.subscriptionActiveLabel,
                            style: textTheme.bodySmall?.copyWith(
                              fontSize: 14,
                              color: colors.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: colors.primary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        l10n.activeLabel,
                        style: textTheme.labelSmall?.copyWith(
                          color: colors.onPrimary,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              
              // Features
              Text(
                l10n.yourPlanIncludes,
                style: textTheme.titleMedium?.copyWith(
                  fontSize: AppConstants.fontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              
              _buildFeatureItem(
                context,
                Icons.people,
                l10n.planChildProfiles(plan.maxChildren),
              ),
              _buildFeatureItem(context, Icons.school, l10n.unlimitedActivities),
              _buildFeatureItem(context, Icons.bar_chart, l10n.advancedReportsLabel),
              _buildFeatureItem(context, Icons.psychology, l10n.aiInsights),
              _buildFeatureItem(context, Icons.download, l10n.offlineDownloadsLabel),
              _buildFeatureItem(context, Icons.support, l10n.prioritySupportLabel),
              
              const SizedBox(height: 32),
              
              // Billing Information
              ThemedCard(
                padding: const EdgeInsets.all(20),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: colors.shadow.withValues(alpha: 0.08),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.billingInformation,
                      style: textTheme.titleMedium?.copyWith(
                        fontSize: AppConstants.fontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    _buildBillingRow(context, l10n.nextPayment, l10n.nextPaymentSampleDate),
                    _buildBillingRow(context, l10n.amountLabel, l10n.sampleAmountPerMonth),
                    _buildBillingRow(context, l10n.paymentMethodLabel, l10n.samplePaymentMethod),
                    
                    const SizedBox(height: 20),
                    
                    OutlinedButton(
                      onPressed: () {
                        context.push(Routes.parentBilling);
                      },
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 48),
                      ),
                      child: Text(l10n.manageBilling),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 32),
              
              // Available Plans
              Text(
                l10n.availablePlans,
                style: textTheme.titleMedium?.copyWith(
                  fontSize: AppConstants.fontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              
              _buildPlanCard(
                context,
                plan,
                l10n.planFree,
                '\$0',
                l10n.basicFeaturesOnly,
                [
                  l10n.limitedActivities,
                  l10n.oneChildProfile,
                  'Basic reports',
                ],
                PlanTier.free,
              ),
              const SizedBox(height: 16),
              
              _buildPlanCard(
                context,
                plan,
                l10n.planFamilyPlus,
                '\$9.99',
                l10n.bestForFamilies,
                [
                  l10n.unlimitedActivities,
                  l10n.upToThreeChildren,
                  l10n.advancedReportsLabel,
                  l10n.aiInsights,
                  l10n.offlineDownloadsLabel,
                  l10n.prioritySupportLabel,
                ],
                PlanTier.familyPlus,
              ),
              
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureItem(BuildContext context, IconData icon, String text) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: colors.secondaryContainer,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 16, color: colors.secondary),
          ),
          const SizedBox(width: 12),
          Text(
            text,
            style: textTheme.bodyMedium?.copyWith(
              fontSize: AppConstants.fontSize,
              color: colors.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBillingRow(
    BuildContext context,
    String label,
    String value,
  ) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: textTheme.bodyMedium?.copyWith(
              fontSize: AppConstants.fontSize,
              color: colors.onSurfaceVariant,
            ),
          ),
          Text(
            value,
            style: textTheme.bodyMedium?.copyWith(
              fontSize: AppConstants.fontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlanCard(
    BuildContext context,
    PlanInfo currentPlan,
    String title,
    String price,
    String subtitle,
    List<String> features,
    PlanTier tier,
  ) {
    final l10n = AppLocalizations.of(context)!;
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final isRecommended = tier == PlanTier.familyPlus;
    final isCurrent = currentPlan.tier == tier;
    return ThemedCard(
      padding: const EdgeInsets.all(20),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: isRecommended ? colors.primary : colors.outlineVariant,
        width: isRecommended ? 2 : 1,
      ),
      boxShadow: [
        BoxShadow(
          color: colors.shadow.withValues(alpha: 0.08),
          blurRadius: 10,
          offset: const Offset(0, 5),
        ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isRecommended)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: colors.primary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                l10n.recommendedLabel,
                style: textTheme.labelSmall?.copyWith(
                  color: colors.onPrimary,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          if (isRecommended) const SizedBox(height: 12),
          
          Row(
            children: [
              Text(
                title,
                style: textTheme.titleMedium?.copyWith(
                  fontSize: AppConstants.fontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    price,
                    style: textTheme.titleLarge?.copyWith(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: textTheme.bodySmall?.copyWith(
                      fontSize: 12,
                      color: colors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          
          ...features.map((feature) => _buildFeatureText(context, feature)),
          
          const SizedBox(height: 20),
          
          ElevatedButton(
            onPressed: isCurrent || _isProcessing
                ? null
                : () => _selectPlan(
                      tier: tier,
                      requiresPayment: tier != PlanTier.free,
                    ),
            style: ElevatedButton.styleFrom(
              backgroundColor: isRecommended
                  ? colors.primary
                  : colors.surfaceContainerHighest,
              foregroundColor:
                  isRecommended ? colors.onPrimary : colors.onSurface,
              minimumSize: const Size(double.infinity, 48),
            ),
            child: Text(
              isCurrent
                  ? l10n.currentPlanLabel
                  : _processingTier == tier
                      ? l10n.processingLabel
                      : l10n.choosePlanLabel,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureText(BuildContext context, String text) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(Icons.check, size: 16, color: colors.primary),
          const SizedBox(width: 8),
          Text(
            text,
            style: textTheme.bodySmall?.copyWith(
              fontSize: 14,
              color: colors.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
