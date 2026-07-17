import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

import '../../../app/router/routes.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/theme_controller.dart';
import '../../../ui/ui.dart';
import 'tabs/demos_tab.dart';
import 'tabs/examples_tab.dart';
import 'tabs/explore_tab.dart';
import 'tabs/widgets_tab.dart';

/// Home screen — GlassBottomBar as hero + four content tabs.
///
/// Rebuilt from the old `ShowcaseHomePage` in main.dart:
/// - brightness toggle now via [themeControllerProvider] (was `_BrightnessScope`)
/// - visuals identical: same tabs, same glass settings, same purple accent.
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _selectedTab = 0;

  static const _tabs = [
    GlassTab(
      label: 'Explore',
      icon: Icon(CupertinoIcons.compass),
      activeIcon: Icon(CupertinoIcons.compass_fill),
    ),
    GlassTab(
      label: 'Widgets',
      icon: Icon(CupertinoIcons.square_grid_2x2),
      activeIcon: Icon(CupertinoIcons.square_grid_2x2_fill),
    ),
    GlassTab(
      label: 'Demos',
      icon: Icon(Icons.apple, size: 30),
      activeIcon: Icon(Icons.apple, size: 30),
    ),
    GlassTab(
      label: 'Examples',
      icon: Icon(CupertinoIcons.cube),
      activeIcon: Icon(CupertinoIcons.cube_fill),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = ref.watch(isDarkModeProvider);

    return GlassScaffold(
      background: const ShowcaseBackground(),
      statusBarStyle: GlassThemeHelper.statusBarStyle(context),
      settings: RecommendedGlassSettings.standard,
      topEdgeFade: true,
      bottomBar: GlassTabBar.bottom(
        selectedIndex: _selectedTab,
        onTabSelected: (i) => setState(() => _selectedTab = i),
        interactionBehavior: GlassInteractionBehavior.full,
        selectedIconColor: AppColors.accentPurple,
        iconSize: 28,
        labelFontSize: 10,
        iconLabelSpacing: 0,
        verticalPadding: 0,
        settings: RecommendedGlassSettings.homeBottomBar,
        extraButton: GlassTabBarExtraButton(
          icon: Icon(isDark ? CupertinoIcons.sun_max : CupertinoIcons.moon),
          label: isDark ? 'Light mode' : 'Dark mode',
          onTap: () => ref.read(themeControllerProvider.notifier).toggle(),
        ),
        tabs: _tabs,
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        child: switch (_selectedTab) {
          0 => const ExploreTab(key: ValueKey('explore')),
          1 => const WidgetsTab(key: ValueKey('widgets')),
          2 => const DemosTab(key: ValueKey('demos')),
          _ => const ExamplesTab(key: ValueKey('examples')),
        },
      ),
    );
  }
}

/// Navigation helper shared by the home tabs.
extension HomeNavigation on BuildContext {
  /// Pushes a named route (replaces the old `_openDemo` CupertinoPageRoute
  /// helper — transitions stay Cupertino via the router's CupertinoPage).
  void openDemo(String routeName) => pushNamed(routeName);
}

/// Route names re-exported for the tab files.
typedef AppRoutes = Routes;
