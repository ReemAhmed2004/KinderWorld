import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kinder_world/core/theme/app_colors.dart';
import 'package:kinder_world/core/constants/app_constants.dart';
import 'package:kinder_world/core/widgets/themed_card.dart';

class PlayScreen extends ConsumerWidget {
  const PlayScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              const SizedBox(height: 20),
              Text(
                'Play & Fun',
                style: textTheme.titleLarge?.copyWith(
                  fontSize: AppConstants.largeFontSize * 1.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Enjoy games, stories, and entertainment!',
                style: textTheme.bodyMedium?.copyWith(
                  fontSize: AppConstants.fontSize,
                  color: colors.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 40),
              
              // Game Categories
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: [
                    _buildGameCard(
                      context,
                      'Educational Games',
                      Icons.games,
                      AppColors.entertaining,
                      'Fun learning games',
                      'games',
                    ),
                    _buildGameCard(
                      context,
                      'Interactive Stories',
                      Icons.book,
                      AppColors.behavioral,
                      'Choose your adventure',
                      'stories',
                    ),
                    _buildGameCard(
                      context,
                      'Music & Songs',
                      Icons.music_note,
                      AppColors.skillful,
                      'Sing and dance',
                      'music',
                    ),
                    _buildGameCard(
                      context,
                      'Educational Videos',
                      Icons.play_circle,
                      AppColors.educational,
                      'Watch and learn',
                      'videos',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGameCard(BuildContext context, String title, IconData icon, Color color, String subtitle, String category) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: () {
        context.go('/child/play/category/$category');
      },
      borderRadius: BorderRadius.circular(20),
      child: ThemedCard(
        padding: const EdgeInsets.all(20),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: colors.shadow.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                icon,
                size: 30,
                color: color,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: textTheme.titleMedium?.copyWith(
                fontSize: AppConstants.fontSize,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: textTheme.bodySmall?.copyWith(
                fontSize: 14,
                color: colors.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}