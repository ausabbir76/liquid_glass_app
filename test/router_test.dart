import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:liquid_glass_app/app/router/app_router.dart';
import 'package:liquid_glass_app/app/router/routes.dart';

void main() {
  test('every route name is registered in the router', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    final router = container.read(routerProvider);

    final registered = router.configuration.routes
        .map((r) => r.toString())
        .join('\n');

    const names = [
      Routes.home,
      Routes.surfaces,
      Routes.interactive,
      Routes.input,
      Routes.feedback,
      Routes.containers,
      Routes.overlays,
      Routes.navBarPatterns,
      Routes.glassMenu,
      Routes.modalSheets,
      Routes.textFields,
      Routes.videoPlayer,
      Routes.tabWidths,
      Routes.platformView,
      Routes.buttonsAndShadows,
      Routes.adaptiveBrightness,
      Routes.indicatorParity,
      Routes.glassBottomBar,
      Routes.scrollableTabBar,
      Routes.qualityComparison,
      Routes.scaffoldMenuRegression,
      Routes.searchableBar,
      Routes.shapeDebug,
      Routes.stretchTest,
      Routes.music,
      Routes.messages,
      Routes.podcasts,
      Routes.news,
      Routes.lockScreen,
    ];

    for (final name in names) {
      expect(registered.contains(name), isTrue,
          reason: 'route "$name" is not registered in the router');
    }
  });
}
