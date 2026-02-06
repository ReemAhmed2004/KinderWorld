import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kinder_world/core/constants/app_constants.dart';
import 'package:kinder_world/core/localization/app_localizations.dart';
import 'package:kinder_world/core/providers/auth_controller.dart';
import 'package:kinder_world/core/providers/child_session_controller.dart';
import 'package:kinder_world/core/providers/locale_provider.dart';
import 'package:kinder_world/core/theme/app_colors.dart';
import 'package:kinder_world/core/widgets/avatar_view.dart';

// ==========================================
// 1. Child Profile Screen (Main Screen)
// ==========================================

class ChildProfileScreen extends ConsumerWidget {
  const ChildProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final textTheme = theme.textTheme;
    final child = ref.watch(currentChildProvider);

    if (child == null) {
      return Scaffold(
        backgroundColor: colors.surfaceContainerLow,
        body: SafeArea(
          child: Stack(
            children: [
              Positioned.fill(child: _buildProfileBackground(context)),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 96,
                        height: 96,
                        decoration: BoxDecoration(
                          color: colors.surface,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: colors.shadow.withValues(alpha: 0.12),
                              blurRadius: 16,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.child_care_outlined,
                          size: 48,
                          color: colors.primary,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        l10n.noChildSelected,
                        style: textTheme.bodyMedium?.copyWith(
                          fontSize: AppConstants.fontSize,
                          color: colors.onSurfaceVariant,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () => context.go('/child/login'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colors.primary,
                          foregroundColor: colors.onPrimary,
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          elevation: 3,
                        ),
                        child: Text(l10n.login),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: colors.surfaceContainerLow,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(child: _buildProfileBackground(context)),
            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              const SizedBox(height: 12),
              Center(
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        colors.primary.withValues(alpha: 0.9),
                        colors.secondary.withValues(alpha: 0.9),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: colors.primary.withValues(alpha: 0.25),
                        blurRadius: 18,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Container(
                    width: 116,
                    height: 116,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: colors.surface,
                      border: Border.all(
                        color: colors.surface,
                        width: 4,
                      ),
                    ),
                    child: AvatarView(
                      avatarId: child.avatar,
                      avatarPath: child.avatarPath,
                      radius: 56,
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Text(
                child.name,
                style: textTheme.headlineSmall?.copyWith(
                  fontSize: AppConstants.largeFontSize * 1.2,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: colors.primaryContainer,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: colors.primary.withValues(alpha: 0.15),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Text(
                  l10n.levelExplorer(child.level),
                  style: textTheme.bodySmall?.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: colors.onPrimaryContainer,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 12,
                runSpacing: 12,
                children: [
                  _buildStatItem(context, '${child.xp}', l10n.xp, AppColors.xpColor, Icons.star),
                  _buildStatItem(context, '${child.streak}', l10n.streak, AppColors.streakColor, Icons.local_fire_department),
                  _buildStatItem(context, '${child.activitiesCompleted}', l10n.activities, AppColors.success, Icons.check_circle),
                ],
              ),
              const SizedBox(height: 20),
              _buildSoftCard(
                context,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.yourProgress,
                      style: textTheme.titleMedium?.copyWith(
                        fontSize: AppConstants.fontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildProgressBar(context, l10n.xpToLevel(child.level + 1), child.xpProgress / 1000, AppColors.xpColor, '${child.xpProgress}/1000'),
                    const SizedBox(height: 14),
                    _buildProgressBar(context, l10n.dailyGoal, 0.7, AppColors.success, '7/10 ${l10n.activities}'),
                    const SizedBox(height: 14),
                    _buildProgressBar(context, l10n.weeklyChallenge, 0.5, AppColors.secondary, '3/6'),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              _buildSoftCard(
                context,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.yourInterests,
                      style: textTheme.titleMedium?.copyWith(
                        fontSize: AppConstants.fontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: child.interests.map((interest) => _buildInterestChip(context, interest)).toList(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              _buildSoftCard(
                context,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.recentAchievements,
                      style: textTheme.titleMedium?.copyWith(
                        fontSize: AppConstants.fontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildAchievementBadge(
                          context,
                          Icons.emoji_events,
                          l10n.achievementFirstQuizTitle,
                          l10n.achievementFirstQuizSubtitle,
                          AppColors.xpColor,
                        ),
                        _buildAchievementBadge(
                          context,
                          Icons.local_fire_department,
                          l10n.achievementStreakTitle,
                          l10n.achievementStreakSubtitle,
                          AppColors.streakColor,
                        ),
                        _buildAchievementBadge(
                          context,
                          Icons.auto_awesome,
                          l10n.achievementMathMasterTitle,
                          l10n.achievementMathMasterSubtitle,
                          AppColors.secondary,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              _buildSoftCard(
                context,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.levels,
                            style: textTheme.titleMedium?.copyWith(
                              fontSize: AppConstants.fontSize,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            l10n.levelsSubtitle,
                            style: textTheme.bodySmall?.copyWith(
                              fontSize: 12,
                              color: colors.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => ChildLevelsScreen(currentLevel: child.level)),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colors.primary,
                        foregroundColor: colors.onPrimary,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                        elevation: 3,
                      ),
                      child: Text(l10n.open),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ChildSettingsScreen()));
                },
                icon: const Icon(Icons.settings),
                label: Text(l10n.settings),
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.primaryContainer,
                  foregroundColor: colors.onPrimaryContainer,
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                  elevation: 2,
                ),
              ),
              const SizedBox(height: 14),
              OutlinedButton.icon(
                onPressed: () async {
                  await ref.read(childSessionControllerProvider.notifier).endChildSession();
                  await ref.read(authControllerProvider.notifier).logout();
                  if (!context.mounted) return;
                  context.go('/welcome');
                },
                icon: const Icon(Icons.logout),
                label: Text(l10n.logout),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                  side: BorderSide(color: colors.outlineVariant),
                ),
              ),
              const SizedBox(height: 28),
            ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileBackground(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                colors.primary.withValues(alpha: 0.14),
                colors.secondary.withValues(alpha: 0.12),
                colors.surfaceContainerLow,
              ],
            ),
          ),
        ),
        Positioned(
          top: -40,
          right: -20,
          child: _decorCircle(120, colors.primary.withValues(alpha: 0.18)),
        ),
        Positioned(
          top: 120,
          left: -50,
          child: _decorCircle(160, colors.secondary.withValues(alpha: 0.16)),
        ),
        Positioned(
          bottom: -60,
          right: -40,
          child: _decorCircle(180, colors.tertiary.withValues(alpha: 0.14)),
        ),
      ],
    );
  }

  Widget _decorCircle(double size, Color color) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
      ),
    );
  }

  Widget _buildSoftCard(BuildContext context, {required Widget child}) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: colors.shadow.withValues(alpha: 0.08),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildStatItem(BuildContext context, String value, String label, Color color, IconData icon) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    return Column(
      children: [
        Container(
          width: 68,
          height: 68,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                color.withValues(alpha: 0.22),
                color.withValues(alpha: 0.08),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: color.withValues(alpha: 0.3)),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.2),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Icon(icon, size: 30, color: color),
        ),
        const SizedBox(height: 10),
        Text(value, style: textTheme.titleMedium?.copyWith(fontSize: AppConstants.fontSize, fontWeight: FontWeight.bold)),
        Text(label, style: textTheme.bodySmall?.copyWith(fontSize: 12, color: colors.onSurfaceVariant)),
      ],
    );
  }

  Widget _buildProgressBar(BuildContext context, String label, double value, Color color, String valueText) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: textTheme.bodyMedium?.copyWith(fontSize: 14, fontWeight: FontWeight.w600)),
            Text(valueText, style: textTheme.bodySmall?.copyWith(fontSize: 12, color: colors.onSurfaceVariant)),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: value,
            backgroundColor: colors.surfaceContainerHighest,
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 8,
          ),
        ),
      ],
    );
  }

  Widget _buildInterestChip(BuildContext context, String interest) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: colors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: colors.primary.withValues(alpha: 0.2)),
      ),
      child: Text(
        interest,
        style: textTheme.bodyMedium?.copyWith(fontSize: 14, color: colors.primary, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _buildAchievementBadge(BuildContext context, IconData icon, String title, String description, Color color) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.2),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Center(child: Icon(icon, size: 28, color: color)),
        ),
        const SizedBox(height: 8),
        Text(title, style: textTheme.bodySmall?.copyWith(fontSize: 12, fontWeight: FontWeight.bold)),
        Text(description, style: textTheme.labelSmall?.copyWith(fontSize: 10, color: colors.onSurfaceVariant), textAlign: TextAlign.center),
      ],
    );
  }
}

// ==========================================
// 2. Child Levels Screen
// ==========================================

class ChildLevelsScreen extends StatelessWidget {
  const ChildLevelsScreen({super.key, required this.currentLevel});

  final int currentLevel;

  static const int maxLevels = 30;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final levels = List<int>.generate(maxLevels, (index) => index + 1).reversed.toList();

    return Scaffold(
      backgroundColor: const Color(0xFFEFF7FF),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: const Color(0xFF23405C),
        elevation: 0,
        title: Text(l10n.levels),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: CustomPaint(
                painter: _WoodBackgroundPainter(),
              ),
            ),
            Column(
              children: [
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _LevelsHeaderBadge(currentLevel: currentLevel),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    itemCount: levels.length,
                    itemBuilder: (context, index) {
                      final level = levels[index];
                      final isLeft = index.isEven;
                      final isCompleted = level < currentLevel;
                      final isCurrent = level == currentLevel;
                      final isLocked = level > currentLevel;

                      return Padding(
                        padding: EdgeInsets.only(
                          left: isLeft ? 24 : 90,
                          right: isLeft ? 90 : 24,
                        ),
                        child: _LevelNode(
                          level: level,
                          isCompleted: isCompleted,
                          isCurrent: isCurrent,
                          isLocked: isLocked,
                          isFirst: index == 0,
                          isLast: index == levels.length - 1,
                          lineColor: isCompleted || isCurrent ? const Color(0xFF6EC46B) : const Color(0xFFBBD7EA),
                          onTap: () {
                            if (isLocked) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(l10n.finishPreviousLevel)),
                              );
                              return;
                            }
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(l10n.levelNumber(level))),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
                  child: _PlayButton(
                    level: currentLevel,
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(l10n.startLevel(currentLevel))),
                      );
                    },
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

class _LevelNode extends StatelessWidget {
  const _LevelNode({
    required this.level,
    required this.isCompleted,
    required this.isCurrent,
    required this.isLocked,
    required this.isFirst,
    required this.isLast,
    required this.lineColor,
    required this.onTap,
  });

  final int level;
  final bool isCompleted;
  final bool isCurrent;
  final bool isLocked;
  final bool isFirst;
  final bool isLast;
  final Color lineColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final nodeGradient = isCurrent
        ? const LinearGradient(
            colors: [Color(0xFF7DD3FC), Color(0xFF38BDF8)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )
        : isCompleted
            ? const LinearGradient(
                colors: [Color(0xFFFFD166), Color(0xFFFF9F1C)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : const LinearGradient(
                colors: [Color(0xFFE2E8F0), Color(0xFFCBD5E1)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              );

    final textColor = isCurrent ? Colors.white : const Color(0xFF35536B);
    final nodeSize = isCurrent ? 92.0 : 78.0;

    return Column(
      children: [
        if (!isFirst)
          SizedBox(
            height: 22,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _ConnectorDot(color: lineColor),
                _ConnectorDot(color: lineColor),
                _ConnectorDot(color: lineColor),
              ],
            ),
          ),
        GestureDetector(
          onTap: onTap,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: nodeSize,
                height: nodeSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: nodeGradient,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.18),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.85),
                    width: isCurrent ? 4 : 3,
                  ),
                ),
                child: Center(
                  child: Text(
                    '$level',
                    style: TextStyle(
                      fontSize: isCurrent ? 24 : 20,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                ),
              ),
              if (isCurrent)
                Positioned(
                  top: -8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      l10n.currentLabel,
                      style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF1E88E5)),
                    ),
                  ),
                ),
              if (isCurrent)
                const Positioned(
                  right: 6,
                  top: 8,
                  child: Icon(Icons.auto_awesome, size: 14, color: Colors.white),
                ),
              if (isCompleted)
                Positioned(
                  bottom: 6,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.star, size: 14, color: Color(0xFFF2C14E)),
                        SizedBox(width: 2),
                        Icon(Icons.check, size: 12, color: Color(0xFF4CAF50)),
                      ],
                    ),
                  ),
                ),
              if (isLocked)
                Positioned(
                  top: 6,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.lock, size: 14, color: Color(0xFF5C6F7A)),
                  ),
                ),
            ],
          ),
        ),
        if (!isLast)
          SizedBox(
            height: 22,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _ConnectorDot(color: lineColor),
                _ConnectorDot(color: lineColor),
                _ConnectorDot(color: lineColor),
              ],
            ),
          ),
        const SizedBox(height: 8),
      ],
    );
  }
}

class _ConnectorDot extends StatelessWidget {
  const _ConnectorDot({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 6,
      height: 6,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}

class _WoodBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final skyPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: const [
          Color(0xFFBFE9FF),
          Color(0xFFEFF9FF),
        ],
      ).createShader(Offset.zero & size);

    canvas.drawRect(Offset.zero & size, skyPaint);

    final sunPaint = Paint()..color = const Color(0xFFFFD166);
    canvas.drawCircle(Offset(size.width * 0.82, size.height * 0.12), 42, sunPaint);

    final cloudPaint = Paint()..color = Colors.white.withValues(alpha: 0.9);
    canvas.drawCircle(Offset(size.width * 0.18, size.height * 0.18), 22, cloudPaint);
    canvas.drawCircle(Offset(size.width * 0.24, size.height * 0.16), 28, cloudPaint);
    canvas.drawCircle(Offset(size.width * 0.30, size.height * 0.19), 20, cloudPaint);

    canvas.drawCircle(Offset(size.width * 0.65, size.height * 0.22), 18, cloudPaint);
    canvas.drawCircle(Offset(size.width * 0.70, size.height * 0.20), 24, cloudPaint);
    canvas.drawCircle(Offset(size.width * 0.76, size.height * 0.23), 16, cloudPaint);

    // Soft pastel floating dots
    final dotPaint = Paint()..color = const Color(0xFFB2F7EF).withValues(alpha: 0.6);
    canvas.drawCircle(Offset(size.width * 0.12, size.height * 0.38), 6, dotPaint);
    canvas.drawCircle(Offset(size.width * 0.28, size.height * 0.32), 4, dotPaint);
    canvas.drawCircle(Offset(size.width * 0.88, size.height * 0.34), 5, dotPaint);
    canvas.drawCircle(Offset(size.width * 0.78, size.height * 0.40), 3, dotPaint);

    final dotPaint2 = Paint()..color = const Color(0xFFFBCFE8).withValues(alpha: 0.6);
    canvas.drawCircle(Offset(size.width * 0.22, size.height * 0.46), 5, dotPaint2);
    canvas.drawCircle(Offset(size.width * 0.60, size.height * 0.36), 4, dotPaint2);

    final dotPaint3 = Paint()..color = const Color(0xFFFFF3B0).withValues(alpha: 0.6);
    canvas.drawCircle(Offset(size.width * 0.40, size.height * 0.28), 4, dotPaint3);
    canvas.drawCircle(Offset(size.width * 0.72, size.height * 0.30), 5, dotPaint3);

    // Pastel balloons
    final balloonPink = Paint()..color = const Color(0xFFF9A8D4).withValues(alpha: 0.8);
    final balloonBlue = Paint()..color = const Color(0xFF93C5FD).withValues(alpha: 0.8);
    final balloonMint = Paint()..color = const Color(0xFF99F6E4).withValues(alpha: 0.8);
    final stringPaint = Paint()
      ..color = const Color(0xFF9AA5B1).withValues(alpha: 0.5)
      ..strokeWidth = 1.2;

    canvas.drawCircle(Offset(size.width * 0.08, size.height * 0.52), 18, balloonPink);
    canvas.drawLine(Offset(size.width * 0.08, size.height * 0.54), Offset(size.width * 0.06, size.height * 0.62), stringPaint);

    canvas.drawCircle(Offset(size.width * 0.90, size.height * 0.50), 16, balloonBlue);
    canvas.drawLine(Offset(size.width * 0.90, size.height * 0.52), Offset(size.width * 0.92, size.height * 0.60), stringPaint);

    canvas.drawCircle(Offset(size.width * 0.78, size.height * 0.56), 14, balloonMint);
    canvas.drawLine(Offset(size.width * 0.78, size.height * 0.58), Offset(size.width * 0.80, size.height * 0.66), stringPaint);

    final hillPaintBack = Paint()..color = const Color(0xFFBDECB6);
    final hillPaintFront = Paint()..color = const Color(0xFF8ED081);

    final backHill = Path()
      ..moveTo(0, size.height * 0.72)
      ..quadraticBezierTo(size.width * 0.25, size.height * 0.60, size.width * 0.5, size.height * 0.70)
      ..quadraticBezierTo(size.width * 0.75, size.height * 0.80, size.width, size.height * 0.68)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(backHill, hillPaintBack);

    final frontHill = Path()
      ..moveTo(0, size.height * 0.78)
      ..quadraticBezierTo(size.width * 0.3, size.height * 0.70, size.width * 0.6, size.height * 0.80)
      ..quadraticBezierTo(size.width * 0.85, size.height * 0.90, size.width, size.height * 0.82)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(frontHill, hillPaintFront);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _LevelsHeaderBadge extends StatelessWidget {
  const _LevelsHeaderBadge({required this.currentLevel});

  final int currentLevel;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: const Color(0xFF4FC3F7),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.flag, color: Colors.white, size: 22),
          ),
          const SizedBox(width: 12),
            Expanded(
              child: Text(
                l10n.levelKeepGoing(currentLevel),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF35536B),
                ),
              ),
            ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFF7BC96F),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              l10n.newLabel,
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class _PlayButton extends StatelessWidget {
  const _PlayButton({required this.level, required this.onPressed});

  final int level;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF5CC46A),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 5,
        ),
        child: Text(
          l10n.playLevel(level),
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

// ==========================================
// 3. Child Settings Screen
// ==========================================

class ChildSettingsScreen extends ConsumerStatefulWidget {
  const ChildSettingsScreen({super.key});

  @override
  ConsumerState<ChildSettingsScreen> createState() => _ChildSettingsScreenState();
}

class _ChildSettingsScreenState extends ConsumerState<ChildSettingsScreen> {
  bool _soundEnabled = true;
  bool _musicEnabled = true;
  bool _notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final textTheme = theme.textTheme;
    final l10n = AppLocalizations.of(context)!;
    final currentLocale = ref.watch(localeProvider);
    final currentLanguageName =
        currentLocale.languageCode == 'ar' ? l10n.arabic : l10n.english;

    return Scaffold(
      backgroundColor: colors.surfaceContainerLow,
      appBar: AppBar(
        backgroundColor: colors.surface,
        title: Text(l10n.settings, style: TextStyle(fontWeight: FontWeight.bold, color: colors.onSurface)),
        centerTitle: true,
        leading: IconButton(icon: Icon(Icons.arrow_back, color: colors.onSurface), onPressed: () => Navigator.of(context).pop()),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // 1. Account Section
          _buildSectionHeader(context, l10n.accountSection),
          const SizedBox(height: 10),
          _buildSettingsCard(
            context,
            children: [
              _buildListTile(context, title: l10n.editProfile, icon: Icons.person_outline, onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsEditProfileScreen()));
              }),
              _buildDivider(),
              _buildListTile(context, title: l10n.changeAvatar, icon: Icons.face_retouching_natural_outlined, onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsAvatarSelectionScreen()));
              }),
            ],
          ),
          const SizedBox(height: 30),

          // 2. Preferences Section
          _buildSectionHeader(context, l10n.preferencesSection),
          const SizedBox(height: 10),
          _buildSettingsCard(
            context,
            children: [
              _buildSwitchTile(context, title: l10n.soundEffects, icon: Icons.volume_up_outlined, value: _soundEnabled, onChanged: (val) => setState(() => _soundEnabled = val)),
              _buildDivider(),
              _buildSwitchTile(context, title: l10n.backgroundMusic, icon: Icons.music_note_outlined, value: _musicEnabled, onChanged: (val) => setState(() => _musicEnabled = val)),
              _buildDivider(),
              _buildSwitchTile(context, title: l10n.notifications, icon: Icons.notifications_outlined, value: _notificationsEnabled, onChanged: (val) => setState(() => _notificationsEnabled = val)),
            ],
          ),
          const SizedBox(height: 30),

          // 3. App Section
          _buildSectionHeader(context, l10n.appSettings),
          const SizedBox(height: 10),
          _buildSettingsCard(
            context,
            children: [
              _buildListTile(context, title: l10n.language, subtitle: currentLanguageName, icon: Icons.language_outlined, onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsLanguageScreen()));
              }),
              _buildDivider(),
              _buildListTile(context, title: l10n.about, icon: Icons.info_outline, onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsAboutUsScreen()));
              }),
              _buildDivider(),
              _buildListTile(context, title: l10n.privacyPolicy, icon: Icons.lock_outline, onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsPrivacyPolicyScreen()));
              }),
            ],
          ),
          const SizedBox(height: 30),

          // 4. Danger Zone
          _buildSettingsCard(
            context,
            color: Colors.red[50],
            children: [
              _buildListTile(context, title: l10n.resetProgress, icon: Icons.refresh, iconColor: Colors.red, titleColor: Colors.red, onTap: () {
                _showResetDialog(context);
              }),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Text(title, style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
    );
  }

  Widget _buildSettingsCard(BuildContext context, {required List<Widget> children, Color? color}) {
    return Container(
      decoration: BoxDecoration(
        color: color ?? Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Theme.of(context).colorScheme.shadow.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _buildListTile(BuildContext context, {required String title, String? subtitle, required IconData icon, Color? iconColor, Color? titleColor, VoidCallback? onTap}) {
    final colors = Theme.of(context).colorScheme;
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(color: (iconColor ?? colors.primary).withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
        child: Icon(icon, color: iconColor ?? colors.primary, size: 24),
      ),
      title: Text(title, style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600, color: titleColor)),
      subtitle: subtitle != null ? Text(subtitle) : null,
      trailing: onTap != null ? Icon(Icons.arrow_forward_ios, size: 16, color: colors.onSurfaceVariant) : null,
      onTap: onTap,
    );
  }

  Widget _buildSwitchTile(BuildContext context, {required String title, required IconData icon, required bool value, required ValueChanged<bool> onChanged}) {
    final colors = Theme.of(context).colorScheme;
    return SwitchListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      secondary: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(color: colors.primary.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
        child: Icon(icon, color: colors.primary, size: 24),
      ),
      title: Text(title, style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600)),
      value: value,
      onChanged: onChanged,
      activeColor: colors.primary,
    );
  }

  Widget _buildDivider() {
    return Divider(height: 1, thickness: 1, indent: 70, endIndent: 20, color: Theme.of(context).colorScheme.outlineVariant);
  }

  void _showResetDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(l10n.resetProgressTitle),
        content: Text(l10n.resetProgressMessage),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(), child: Text(l10n.cancel)),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l10n.progressReset)));
            },
            child: Text(l10n.reset, style: const TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// 3. NEW: Settings Language Selection Screen (Renamed to avoid conflict)
// ==========================================

class SettingsLanguageScreen extends ConsumerWidget {
  const SettingsLanguageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final currentLocale = ref.watch(localeProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.language, style: const TextStyle(fontWeight: FontWeight.bold)),
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context)),
      ),
      body: ListView(
        children: [
          _buildLanguageTile(
            context,
            ref,
            title: l10n.english,
            languageCode: 'en',
            isSelected: currentLocale.languageCode == 'en',
          ),
          _buildLanguageTile(
            context,
            ref,
            title: l10n.arabic,
            languageCode: 'ar',
            isSelected: currentLocale.languageCode == 'ar',
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageTile(
    BuildContext context,
    WidgetRef ref, {
    required String title,
    required String languageCode,
    required bool isSelected,
  }) {
    final colors = Theme.of(context).colorScheme;

    return InkWell(
      onTap: () {
        ref.read(localeProvider.notifier).state = Locale(languageCode);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          color: isSelected ? colors.primary.withValues(alpha: 0.1) : Colors.transparent,
        ),
        child: Row(
          children: [
            // Placeholder for Flag Image
            Container(
              width: 40,
              height: 30,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Icon(Icons.flag, size: 20),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Text(title, style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600)),
            ),
            if (isSelected) Icon(Icons.check_circle, color: colors.primary),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// 4. NEW: Settings Avatar Selection Screen (Renamed)
// ==========================================

class SettingsAvatarSelectionScreen extends StatefulWidget {
  const SettingsAvatarSelectionScreen({super.key});

  @override
  State<SettingsAvatarSelectionScreen> createState() => _SettingsAvatarSelectionScreenState();
}

class _SettingsAvatarSelectionScreenState extends State<SettingsAvatarSelectionScreen> {
  int _selectedAvatarIndex = 0;

  final List<String> _mockAvatars = List.generate(8, (index) => 'assets/images/avatar_${index + 1}.png');

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.chooseAvatar, style: const TextStyle(fontWeight: FontWeight.bold)),
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context)),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l10n.avatarSaved)));
            },
            child: Text(l10n.save, style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          childAspectRatio: 1.0,
        ),
        itemCount: _mockAvatars.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedAvatarIndex = index;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: _selectedAvatarIndex == index ? Theme.of(context).colorScheme.primary : Colors.transparent,
                  width: 4,
                ),
              ),
              child: CircleAvatar(
                backgroundColor: Colors.grey[200],
                backgroundImage: AssetImage(_mockAvatars[index]),
                onBackgroundImageError: (exception, stackTrace) {},
              ),
            ),
          );
        },
      ),
    );
  }
}

// ==========================================
// 5. NEW: Settings Edit Profile Screen (Renamed)
// ==========================================

class SettingsEditProfileScreen extends StatefulWidget {
  const SettingsEditProfileScreen({super.key});

  @override
  State<SettingsEditProfileScreen> createState() => _SettingsEditProfileScreenState();
}

class _SettingsEditProfileScreenState extends State<SettingsEditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController(text: "Ava"); // Mock initial value

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.editProfile, style: const TextStyle(fontWeight: FontWeight.bold)),
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(l10n.nameLabel, style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: l10n.enterYourName,
                  filled: true,
                  fillColor: colors.surfaceContainerHighest,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return l10n.pleaseEnterName;
                  return null;
                },
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l10n.profileUpdated)));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors.primary,
                    foregroundColor: colors.onPrimary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: Text(l10n.saveChanges, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

// ==========================================
// 6. NEW: Settings About Us Screen
// ==========================================

class SettingsAboutUsScreen extends StatelessWidget {
  const SettingsAboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final lastUpdatedDate = isArabic ? 'أكتوبر 2023' : 'October 2023';
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.about, style: const TextStyle(fontWeight: FontWeight.bold)),
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Center(child: Icon(Icons.child_care, size: 80, color: theme.colorScheme.primary)),
            const SizedBox(height: 20),
            Text(l10n.aboutAppName, style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text(l10n.versionLabel('1.0.0'), style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey)),
            const SizedBox(height: 30),
            Text(
              l10n.aboutDescription,
              style: theme.textTheme.bodyLarge?.copyWith(height: 1.5),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 20),
            Text(l10n.contactUs, style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            _buildContactRow(Icons.email, "support@kinderworld.com"),
            const SizedBox(height: 10),
            _buildContactRow(Icons.language, "www.kinderworld.com"),
          ],
        ),
      ),
    );
  }

  Widget _buildContactRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey[600]),
        const SizedBox(width: 15),
        Text(text, style: const TextStyle(fontSize: 16)),
      ],
    );
  }
}

// ==========================================
// 7. NEW: Settings Privacy Policy Screen
// ==========================================

class SettingsPrivacyPolicyScreen extends StatelessWidget {
  const SettingsPrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final lastUpdatedDate = isArabic ? 'أكتوبر 2023' : 'October 2023';
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.privacyPolicy, style: const TextStyle(fontWeight: FontWeight.bold)),
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.lastUpdated(lastUpdatedDate), style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey)),
            const SizedBox(height: 20),
            Text(l10n.privacyIntroTitle, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(
              l10n.privacyIntroBody,
              style: theme.textTheme.bodyMedium?.copyWith(height: 1.5),
            ),
            const SizedBox(height: 20),
            Text(l10n.privacyDataCollectionTitle, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(
              l10n.privacyDataCollectionBody,
              style: theme.textTheme.bodyMedium?.copyWith(height: 1.5),
            ),
            const SizedBox(height: 20),
            Text(l10n.privacySecurityTitle, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(
              l10n.privacySecurityBody,
              style: theme.textTheme.bodyMedium?.copyWith(height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}
