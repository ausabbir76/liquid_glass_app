import 'package:flutter/cupertino.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../ui/ui.dart';
import '../home_screen.dart';

/// Examples tab — widget patterns & configuration reference.
/// Visuals identical to `_ExamplesTab`.
class ExamplesTab extends StatelessWidget {
  const ExamplesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return TabContentView(
      title: 'Examples',
      subtitle: 'Widget modes & configuration reference.',
      children: [
        const SizedBox(height: 24),

        // Row 1: Nav Patterns + Context Menus
        Row(
          children: [
            Expanded(
              child: SmallDemoCard(
                title: 'Nav Patterns',
                icon: CupertinoIcons.rectangle_split_3x1,
                color: AppColors.blue,
                onTap: () => context.openDemo(AppRoutes.navBarPatterns),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: SmallDemoCard(
                title: 'Menus',
                icon: CupertinoIcons.ellipsis_circle_fill,
                color: AppColors.orange,
                onTap: () => context.openDemo(AppRoutes.glassMenu),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),

        // Large card: Modal Sheets
        LargeDemoCard(
          title: 'Modal Sheets',
          subtitle: 'Standard, peek, Apple Maps & smart silence modes',
          icon: CupertinoIcons.rectangle_on_rectangle,
          gradient: AppColors.sheetsGradient,
          onTap: () => context.openDemo(AppRoutes.modalSheets),
        ),
        const SizedBox(height: 14),

        // Row 2: Text Fields + Video Player
        Row(
          children: [
            Expanded(
              child: SmallDemoCard(
                title: 'Text Fields',
                icon: CupertinoIcons.textbox,
                color: AppColors.green,
                onTap: () => context.openDemo(AppRoutes.textFields),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: SmallDemoCard(
                title: 'Video Player',
                icon: CupertinoIcons.play_circle_fill,
                color: AppColors.pink,
                onTap: () => context.openDemo(AppRoutes.videoPlayer),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),

        // Row 3: Tab Widths + Platform View
        Row(
          children: [
            Expanded(
              child: SmallDemoCard(
                title: 'Tab Widths',
                icon: CupertinoIcons.slider_horizontal_3,
                color: AppColors.purple,
                onTap: () => context.openDemo(AppRoutes.tabWidths),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: SmallDemoCard(
                title: 'Platform View',
                icon: CupertinoIcons.map_fill,
                color: AppColors.cyan,
                onTap: () => context.openDemo(AppRoutes.platformView),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),

        LargeDemoCard(
          title: 'Buttons & Shadows',
          subtitle: 'Glass elevations and GPU SDF shadows',
          icon: CupertinoIcons.layers_fill,
          gradient: AppColors.amberGradient,
          onTap: () => context.openDemo(AppRoutes.buttonsAndShadows),
        ),
        const SizedBox(height: 14),

        LargeDemoCard(
          title: 'Adaptive Brightness',
          subtitle: 'Content-aware light/dark bar adaptation on scroll',
          icon: CupertinoIcons.sun_dust_fill,
          gradient: AppColors.brightnessGradient,
          onTap: () => context.openDemo(AppRoutes.adaptiveBrightness),
        ),
        const SizedBox(height: 14),

        LargeDemoCard(
          title: 'Indicator Parity',
          subtitle:
              'All 5 pill widgets — live pinch / expansion / aberration tuner',
          icon: CupertinoIcons.dial_fill,
          gradient: AppColors.indicatorGradient,
          onTap: () => context.openDemo(AppRoutes.indicatorParity),
        ),
        const SizedBox(height: 14),
      ],
    );
  }
}
