/// Central route name/path registry.
///
/// Use these constants with `context.goNamed(...)` / `context.pushNamed(...)`
/// instead of raw strings so typos become compile errors.
abstract final class Routes {
  // ── Shell ──────────────────────────────────────────────────────────
  static const String home = 'home';
  static const String homePath = '/';

  // ── Widget catalog ─────────────────────────────────────────────────
  static const String surfaces = 'surfaces';
  static const String interactive = 'interactive';
  static const String input = 'input';
  static const String feedback = 'feedback';
  static const String containers = 'containers';
  static const String overlays = 'overlays';

  // ── Component demos ────────────────────────────────────────────────
  static const String navBarPatterns = 'nav-bar-patterns';
  static const String glassMenu = 'glass-menu';
  static const String modalSheets = 'modal-sheets';
  static const String textFields = 'text-fields';
  static const String videoPlayer = 'video-player';
  static const String tabWidths = 'tab-widths';
  static const String platformView = 'platform-view';
  static const String buttonsAndShadows = 'buttons-and-shadows';
  static const String adaptiveBrightness = 'adaptive-brightness';
  static const String indicatorParity = 'indicator-parity';
  static const String glassBottomBar = 'glass-bottom-bar';
  static const String scrollableTabBar = 'scrollable-tab-bar';
  static const String qualityComparison = 'quality-comparison';
  static const String scaffoldMenuRegression = 'scaffold-menu-regression';
  static const String searchableBar = 'searchable-bar';
  static const String shapeDebug = 'shape-debug';
  static const String stretchTest = 'stretch-test';

  // ── Apple app showcases ────────────────────────────────────────────
  static const String music = 'music';
  static const String messages = 'messages';
  static const String podcasts = 'podcasts';
  static const String news = 'news';
  static const String lockScreen = 'lock-screen';

  /// Path for a top-level route: `/surfaces`, `/music`, ...
  static String pathOf(String name) => '/$name';
}
