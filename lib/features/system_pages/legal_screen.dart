import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kinder_world/core/constants/app_constants.dart';
import 'package:kinder_world/core/theme/app_colors.dart';
import 'package:kinder_world/core/localization/app_localizations.dart';

class LegalScreen extends ConsumerWidget {
  final String type;

  const LegalScreen({
    super.key,
    required this.type,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final title = _getTitle(type, l10n);
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Text(
          title,
          style: textTheme.titleMedium?.copyWith(
            fontSize: AppConstants.fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: colors.onSurface),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.description,
                  size: 72,
                  color: AppColors.primary,
                ),
                const SizedBox(height: 24),
                Text(
                  l10n.legalNoContent,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  _getPlaceholder(type, l10n),
                  textAlign: TextAlign.center,
                  style: textTheme.bodyMedium?.copyWith(
                    fontSize: 16,
                    color: colors.onSurfaceVariant,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getTitle(String type, AppLocalizations l10n) {
    switch (type) {
      case 'terms':
        return l10n.legalTermsTitle;
      case 'privacy':
        return l10n.legalPrivacyTitle;
      case 'coppa':
        return l10n.legalCoppaTitle;
      default:
        return l10n.legalTitle;
    }
  }

  String _getPlaceholder(String type, AppLocalizations l10n) {
    switch (type) {
      case 'terms':
        return l10n.legalTermsPlaceholder;
      case 'privacy':
        return l10n.legalPrivacyPlaceholder;
      case 'coppa':
        return l10n.legalCoppaPlaceholder;
      default:
        return l10n.legalPlaceholder;
    }
  }
}
