import 'package:flutter/cupertino.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../ui/ui.dart';
import '../home_screen.dart';

/// Widgets tab — full catalog grid. Visuals identical to `_WidgetsTab`.
class WidgetsTab extends StatelessWidget {
  const WidgetsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return TabContentView(
      title: 'Widgets',
      subtitle: 'Browse the full widget catalog.',
      children: [
        const SizedBox(height: 24),

        // Row 1: Containers + Interactive
        Row(
          children: [
            Expanded(
              child: SmallDemoCard(
                title: 'Containers',
                icon: CupertinoIcons.square_stack_3d_up_fill,
                color: AppColors.blue,
                onTap: () => context.openDemo(AppRoutes.containers),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: SmallDemoCard(
                title: 'Interactive',
                icon: CupertinoIcons.hand_point_right_fill,
                color: AppColors.orange,
                onTap: () => context.openDemo(AppRoutes.interactive),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),

        // Row 2: Feedback + Overlays
        Row(
          children: [
            Expanded(
              child: SmallDemoCard(
                title: 'Feedback',
                icon: CupertinoIcons.hourglass,
                color: AppColors.green,
                onTap: () => context.openDemo(AppRoutes.feedback),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: SmallDemoCard(
                title: 'Overlays',
                icon: CupertinoIcons.square_stack_fill,
                color: AppColors.purple,
                onTap: () => context.openDemo(AppRoutes.overlays),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),

        // Row 3: Surfaces + Input
        Row(
          children: [
            Expanded(
              child: SmallDemoCard(
                title: 'Surfaces',
                icon: CupertinoIcons.rectangle_3_offgrid_fill,
                color: AppColors.cyan,
                onTap: () => context.openDemo(AppRoutes.surfaces),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: SmallDemoCard(
                title: 'Input',
                icon: CupertinoIcons.keyboard,
                color: AppColors.pink,
                onTap: () => context.openDemo(AppRoutes.input),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
