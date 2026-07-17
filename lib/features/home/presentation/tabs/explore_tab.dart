import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../ui/ui.dart';
import '../home_screen.dart';

/// Explore tab — hero overview (featured Music card, small demo cards,
/// staggered widget catalog). Visuals identical to the old `_ExploreTab`.
class ExploreTab extends StatelessWidget {
  const ExploreTab({super.key});

  @override
  Widget build(BuildContext context) {
    return TabContentView(
      title: 'Liquid Glass',
      subtitle: 'iOS 26 Widget Toolkit',
      subtitleGap: 4,
      subtitleStyle: TextStyle(
        fontSize: 17,
        color: CupertinoColors.secondaryLabel.resolveFrom(context),
        letterSpacing: -0.2,
      ),
      children: [
        const SizedBox(height: 32),

        // ── Featured demo — large card ────────────────────
        GestureDetector(
          onTap: () => context.openDemo(AppRoutes.music),
          child: Container(
            height: 200,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: AppColors.musicGradient,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.apple, color: Colors.white, size: 30),
                    SizedBox(width: 6),
                    Text(
                      'Music',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                const Text(
                  'Apple Music recreation\n with Liquid Glass Widgets',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Searchable bottom bar · Play pill · Tab navigation',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 16),

        // ── Two smaller demo cards ────────────────────────
        Row(
          children: [
            Expanded(
              child: SmallDemoCard(
                title: 'Messages',
                icon: CupertinoIcons.chat_bubble_2_fill,
                color: AppColors.green,
                onTap: () => context.openDemo(AppRoutes.messages),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: SmallDemoCard(
                title: 'Podcasts',
                icon: CupertinoIcons.mic_fill,
                color: AppColors.accentPurple,
                onTap: () => context.openDemo(AppRoutes.podcasts),
              ),
            ),
          ],
        ),

        const SizedBox(height: 32),

        // ── Staggered widget preview ──────────────────────
        Text(
          'Widget Catalog',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: CupertinoColors.label.resolveFrom(context),
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 16),

        // ── Masonry: tall card + two stacked ──────────
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Left: tall card spanning both right cards
              Expanded(
                child: CatalogCard(
                  icon: CupertinoIcons.rectangle_3_offgrid_fill,
                  title: 'Surfaces',
                  subtitle: 'AppBar · BottomBar · SearchBar · TabBar',
                  onTap: () => context.openDemo(AppRoutes.surfaces),
                ),
              ),
              const SizedBox(width: 14),
              // Right: two stacked cards
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CatalogCard(
                      icon: CupertinoIcons.hand_point_right_fill,
                      title: 'Interactive',
                      subtitle: 'Button · Switch · Slider',
                      height: 120,
                      onTap: () => context.openDemo(AppRoutes.interactive),
                    ),
                    const SizedBox(height: 14),
                    CatalogCard(
                      icon: CupertinoIcons.hourglass,
                      title: 'Feedback',
                      subtitle: 'Progress · Toast',
                      height: 120,
                      onTap: () => context.openDemo(AppRoutes.feedback),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── Row of two ──────────────────────────────────
        Row(
          children: [
            Expanded(
              child: CatalogCard(
                icon: CupertinoIcons.keyboard,
                title: 'Input',
                subtitle: 'TextField · SearchBar',
                height: 120,
                onTap: () => context.openDemo(AppRoutes.input),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: CatalogCard(
                icon: CupertinoIcons.square_stack_fill,
                title: 'Overlays',
                subtitle: 'Sheet · Dialog · Menu · Popover',
                height: 120,
                onTap: () => context.openDemo(AppRoutes.overlays),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),

        // ── Full-width card ─────────────────────────────
        Row(
          children: [
            Expanded(
              child: CatalogCard(
                icon: CupertinoIcons.square_stack_3d_up_fill,
                title: 'Containers',
                subtitle: 'Card · Panel · Container',
                height: 100,
                onTap: () => context.openDemo(AppRoutes.containers),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
