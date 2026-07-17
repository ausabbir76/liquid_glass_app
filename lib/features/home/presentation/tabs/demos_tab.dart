import 'package:flutter/cupertino.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../ui/ui.dart';
import '../home_screen.dart';

/// Demos tab — Apple app reproductions. Visuals identical to `_DemosTab`.
class DemosTab extends StatelessWidget {
  const DemosTab({super.key});

  @override
  Widget build(BuildContext context) {
    return TabContentView(
      title: 'Demos',
      subtitle: 'Polished Apple app reproductions.',
      children: [
        const SizedBox(height: 24),

        // Large featured card
        LargeDemoCard(
          title: 'Apple Music',
          subtitle: 'Searchable bottom bar, play pill, tab navigation',
          icon: CupertinoIcons.music_note_2,
          gradient: AppColors.musicGradient,
          onTap: () => context.openDemo(AppRoutes.music),
        ),
        const SizedBox(height: 14),

        LargeDemoCard(
          title: 'Messages',
          subtitle: 'Conversations, edit menus & filter controls',
          icon: CupertinoIcons.chat_bubble_2_fill,
          gradient: AppColors.messagesGradient,
          onTap: () => context.openDemo(AppRoutes.messages),
        ),
        const SizedBox(height: 14),

        LargeDemoCard(
          title: 'Podcasts',
          subtitle: 'Mini-player, now playing sheet & scroll collapse',
          icon: CupertinoIcons.mic_fill,
          gradient: AppColors.podcastsGradient,
          onTap: () => context.openDemo(AppRoutes.podcasts),
        ),
        const SizedBox(height: 14),

        Row(
          children: [
            Expanded(
              child: SmallDemoCard(
                title: 'News',
                icon: CupertinoIcons.news_solid,
                color: AppColors.red,
                onTap: () => context.openDemo(AppRoutes.news),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: SmallDemoCard(
                title: 'Lock Screen',
                icon: CupertinoIcons.lock_fill,
                color: AppColors.indigo,
                onTap: () => context.openDemo(AppRoutes.lockScreen),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
