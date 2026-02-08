import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kinder_world/core/theme/app_colors.dart';
import 'package:kinder_world/core/constants/app_constants.dart';
import 'package:kinder_world/core/localization/app_localizations.dart';

class HelpSupportScreen extends ConsumerWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colors.onSurface),
          onPressed: () => context.go('/parent/settings'),
        ),
        title: Text(
          l10n.helpSupportTitle,
          style: textTheme.titleMedium?.copyWith(
            fontSize: AppConstants.fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(
                        Icons.help_outline,
                        size: 30,
                        color: colors.onPrimary,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.helpNeedHelpTitle,
                            style: textTheme.titleLarge?.copyWith(
                              fontSize: AppConstants.largeFontSize,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            l10n.helpNeedHelpSubtitle,
                            style: textTheme.bodyMedium?.copyWith(
                              fontSize: 16,
                              color: colors.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              
              // FAQ Section
              Text(
                l10n.helpFaqTitle,
                style: textTheme.titleMedium?.copyWith(
                  fontSize: AppConstants.fontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              
              _FAQItem(
                question: l10n.helpFaqQ1,
                answer: l10n.helpFaqA1,
              ),
              const SizedBox(height: 12),
              
              _FAQItem(
                question: l10n.helpFaqQ2,
                answer: l10n.helpFaqA2,
              ),
              const SizedBox(height: 12),
              
              _FAQItem(
                question: l10n.helpFaqQ3,
                answer: l10n.helpFaqA3,
              ),
              const SizedBox(height: 12),
              
              _FAQItem(
                question: l10n.helpFaqQ4,
                answer: l10n.helpFaqA4,
              ),
              const SizedBox(height: 12),
              
              _FAQItem(
                question: l10n.helpFaqQ5,
                answer: l10n.helpFaqA5,
              ),
              
              const SizedBox(height: 32),
              
              // Contact Support
              Text(
                l10n.helpContactSupportTitle,
                style: textTheme.titleMedium?.copyWith(
                  fontSize: AppConstants.fontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: colors.surface,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: colors.shadow.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _ContactOption(
                      icon: Icons.email,
                      title: l10n.helpEmailSupportTitle,
                      subtitle: 'support@kinderworld.app',
                      onTap: () {
                        // Open email client
                      },
                    ),
                    const SizedBox(height: 16),
                    _ContactOption(
                      icon: Icons.chat,
                      title: l10n.helpLiveChatTitle,
                      subtitle: l10n.helpLiveChatSubtitle,
                      onTap: () {
                        // Open chat
                      },
                    ),
                    const SizedBox(height: 16),
                    _ContactOption(
                      icon: Icons.phone,
                      title: l10n.helpPhoneSupportTitle,
                      subtitle: l10n.helpPhoneSupportSubtitle,
                      onTap: () {
                        // Make phone call
                      },
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 32),
              
              // Additional Resources
              Text(
                l10n.helpResourcesTitle,
                style: textTheme.titleMedium?.copyWith(
                  fontSize: AppConstants.fontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: colors.surface,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: colors.shadow.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _ResourceItem(
                      icon: Icons.description,
                      title: l10n.helpUserGuide,
                      onTap: () {
                        context.go('/legal?type=guide');
                      },
                    ),
                    const SizedBox(height: 16),
                    _ResourceItem(
                      icon: Icons.privacy_tip,
                      title: l10n.privacyPolicy,
                      onTap: () {
                        context.go('/legal?type=privacy');
                      },
                    ),
                    const SizedBox(height: 16),
                    _ResourceItem(
                      icon: Icons.gavel,
                      title: l10n.termsOfService,
                      onTap: () {
                        context.go('/legal?type=terms');
                      },
                    ),
                    const SizedBox(height: 16),
                    _ResourceItem(
                      icon: Icons.update,
                      title: l10n.helpAppUpdates,
                      onTap: () {
                        // Check for updates
                      },
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 32),
              
              // App version
              Center(
                child: Text(
                  l10n.appVersionLabel(AppConstants.appVersion),
                  style: textTheme.bodySmall?.copyWith(
                    fontSize: 14,
                    color: colors.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FAQItem extends StatefulWidget {
  final String question;
  final String answer;
  
  _FAQItem({
    required this.question,
    required this.answer,
  });

  @override
  State<_FAQItem> createState() => _FAQItemState();
}

class _FAQItemState extends State<_FAQItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: colors.shadow.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.question,
                  style: textTheme.titleSmall?.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                    ),
                  ),
                  Icon(
                    _isExpanded ? Icons.expand_less : Icons.expand_more,
                    size: 24,
                color: colors.onSurfaceVariant,
                  ),
                ],
              ),
            ),
          ),
          
          if (_isExpanded)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Text(
                widget.answer,
                style: textTheme.bodySmall?.copyWith(
                  fontSize: 14,
                  color: colors.onSurfaceVariant,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _ContactOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  
  const _ContactOption({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Icon(
              icon,
              size: 24,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(width: 16),
          
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: textTheme.titleSmall?.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  subtitle,
                  style: textTheme.bodySmall?.copyWith(
                    fontSize: 14,
                    color: colors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          
          Icon(
            Icons.chevron_right,
            size: 24,
            color: colors.onSurfaceVariant,
          ),
        ],
      ),
    );
  }
}

class _ResourceItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  
  const _ResourceItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.secondary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              icon,
              size: 20,
              color: AppColors.secondary,
            ),
          ),
          const SizedBox(width: 16),
          
          Expanded(
            child: Text(
              title,
              style: textTheme.bodyMedium?.copyWith(
                fontSize: 16,
              ),
            ),
          ),
          
          Icon(
            Icons.chevron_right,
            size: 24,
            color: colors.onSurfaceVariant,
          ),
        ],
      ),
    );
  }
}
