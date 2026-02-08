import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kinder_world/core/localization/app_localizations.dart';
import 'package:kinder_world/core/providers/theme_provider.dart';
import 'package:kinder_world/core/theme/theme_palette.dart';

class ParentThemeScreen extends ConsumerWidget {
  const ParentThemeScreen({super.key});


  String _paletteLabel(AppLocalizations l10n, String id) {
    switch (id) {
      case 'default':
        return l10n.paletteDefault;
      case 'blue':
        return l10n.paletteOceanBlue;
      case 'purple':
        return l10n.palettePurpleNight;
      case 'green':
        return l10n.paletteForestGreen;
      case 'sunset':
        return l10n.paletteSunsetOrange;
      default:
        return l10n.paletteDefault;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final themeSettings = ref.watch(themeControllerProvider);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.theme),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.themePalette,
              style: textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            Column(
              children: ThemePalettes.all.map((palette) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _PaletteCard(
                    palette: palette,
                    displayName: _paletteLabel(l10n, palette.id),
                    isSelected: themeSettings.paletteId == palette.id,
                    onTap: () => ref
                        .read(themeControllerProvider.notifier)
                        .setPalette(palette.id),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _PaletteCard extends StatelessWidget {
  final ThemePalette palette;
  final String displayName;
  final bool isSelected;
  final VoidCallback onTap;

  const _PaletteCard({
    required this.palette,
    required this.displayName,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? colors.primary : colors.outlineVariant,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: colors.shadow.withValues(alpha: 0.06),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: palette.seedColor,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    displayName,
                    style: textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
