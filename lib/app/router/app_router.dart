import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/catalog/presentation/containers_page.dart';
import '../../features/catalog/presentation/feedback_page.dart';
import '../../features/catalog/presentation/input_page.dart';
import '../../features/catalog/presentation/interactive_page.dart';
import '../../features/catalog/presentation/overlays_page.dart';
import '../../features/catalog/presentation/surfaces_page.dart';
import '../../features/demos/presentation/bottom_bar_tab_width_demo.dart';
import '../../features/demos/presentation/buttons_and_shadows_demo.dart';
import '../../features/demos/presentation/content_aware_brightness_demo.dart';
import '../../features/demos/presentation/glass_bottom_bar_demo.dart';
import '../../features/demos/presentation/glass_menu_demo.dart';
import '../../features/demos/presentation/glass_modal_sheet_demo.dart';
import '../../features/demos/presentation/glass_tab_bar_scrollable_demo.dart';
import '../../features/demos/presentation/google_maps_demo.dart';
import '../../features/demos/presentation/indicator_parity_demo.dart';
import '../../features/demos/presentation/nav_bar_patterns_demo.dart';
import '../../features/demos/presentation/quality_comparison_demo.dart';
import '../../features/demos/presentation/scaffold_menu_regression_demo.dart';
import '../../features/demos/presentation/searchable_bar_demo.dart';
import '../../features/demos/presentation/shape_debug_demo.dart';
import '../../features/demos/presentation/stretch_test_demo.dart';
import '../../features/demos/presentation/text_field_demo.dart';
import '../../features/demos/presentation/video_player_demo.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/showcases/lockscreen/presentation/keypad_lock_screen_demo.dart';
import '../../features/showcases/messages/presentation/apple_messages_demo.dart';
import '../../features/showcases/music/presentation/apple_music_demo.dart';
import '../../features/showcases/news/presentation/apple_news_demo.dart';
import '../../features/showcases/podcasts/presentation/apple_podcasts_demo.dart';
import 'routes.dart';

/// The app router.
///
/// Every screen is a named route — navigate with:
/// ```dart
/// context.pushNamed(Routes.music);
/// ```
/// All routes use [CupertinoPage] for native iOS swipe-back transitions.
final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: Routes.homePath,
    debugLogDiagnostics: false,
    routes: [
      _route(Routes.home, path: Routes.homePath, child: const HomeScreen()),

      // ── Widget catalog ────────────────────────────────────────────
      _route(Routes.surfaces, child: const SurfacesPage()),
      _route(Routes.interactive, child: const InteractivePage()),
      _route(Routes.input, child: const InputPage()),
      _route(Routes.feedback, child: const FeedbackPage()),
      _route(Routes.containers, child: const ContainersPage()),
      _route(Routes.overlays, child: const OverlaysPage()),

      // ── Component demos ───────────────────────────────────────────
      _route(Routes.navBarPatterns, child: const NavBarPatternsDemo()),
      _route(Routes.glassMenu, child: const MenuDemoPage()),
      _route(Routes.modalSheets, child: const ShowcaseApp()),
      _route(Routes.textFields, child: const TextFieldDemo()),
      _route(Routes.videoPlayer, child: const VideoGlassDemoPage()),
      _route(Routes.tabWidths, child: const TabWidthDemoPage()),
      _route(Routes.platformView, child: const PlatformViewDemo()),
      _route(Routes.buttonsAndShadows, child: const ShadowClippingDemoPage()),
      _route(Routes.adaptiveBrightness, child: const ContentAwareBrightnessDemo()),
      _route(Routes.indicatorParity, child: const IndicatorParityDemoPage()),
      _route(Routes.glassBottomBar, child: const GlassBottomBarDemoPage()),
      _route(Routes.scrollableTabBar, child: const TabBarScrollableHome()),
      _route(Routes.qualityComparison, child: const QualityComparisonDemoPage()),
      _route(Routes.scaffoldMenuRegression,
          child: const ScaffoldMenuRegressionDemo()),
      _route(Routes.searchableBar, child: const SearchableBarDemoPage()),
      _route(Routes.shapeDebug, child: const ShapeDebugPage()),
      _route(Routes.stretchTest, child: const StretchTestDemo()),

      // ── Apple app showcases ───────────────────────────────────────
      _route(Routes.music, child: const AppleMusicHomeScreen()),
      _route(Routes.messages, child: const MessagesScreen()),
      _route(Routes.podcasts, child: const ApplePodcastsHomeScreen()),
      _route(Routes.news, child: const AppleNewsHomeScreen()),
      _route(Routes.lockScreen, child: const KeypadLockScreenDemo()),
    ],
  );
});

/// Builds a named [GoRoute] with a standard native Material page transition.
GoRoute _route(String name, {String? path, required Widget child}) {
  return GoRoute(
    name: name,
    path: path ?? Routes.pathOf(name),
    pageBuilder: (context, state) =>
        MaterialPage<void>(key: state.pageKey, child: child),
  );
}


