# CLAUDE.md — Liquid Glass App Template

This project is built from my personal Flutter template around `liquid_glass_widgets`
(iOS 26 liquid glass design). The architecture is already decided — do NOT re-analyze
or restructure it. Read `README.md` / `implementation_guide.md` / `workflow.md` only
if a task genuinely requires detail not covered here.

## Where to work

- **All app code goes in `lib/features/`.** Everything else (glass rendering, theming,
  routing, networking, storage, logging, errors, l10n) is infrastructure — already wired.
- New feature = copy `lib/features/_template/` → rename model / repository / providers /
  screen → add route name in `lib/app/router/routes.dart` + `_route(...)` entry in
  `lib/app/router/app_router.dart` → navigate with `context.pushNamed(Routes.x)`.
- Features may depend on `core/`, `ui/`, `app/theme` — never on each other.

## Non-negotiable rules

1. **Routes use `MaterialPage`** in the `_route` helper. This is intentional — the
   Cupertino swipe-back transition causes performance problems with the glass shaders.
   Never switch to `CupertinoPage`.
2. **Repositories return `Result<T>`** (`core/errors/result.dart`) and never throw into
   the UI. Screens are `ConsumerWidget`s that watch Riverpod providers and render
   `AsyncValue.when(loading/error/data)`.
3. **Glass styling only via `RecommendedGlassSettings`** (`lib/ui/glass/glass_presets.dart`).
   Never invent per-widget glass values or change `lightAngle` (0.75π everywhere):
   - `.standard` cards in lists · `.interactive` buttons · `.surface` static toolbars
   - `.bottomBar` nav bars · `.sheet` modals/sheets · `.input` text fields
   - `.overlay` overlay layers · `.appBottomBar(brightness)` / `.homeBottomBar` floating bars
4. **No hardcoded metrics/colors/text styles.** Use `AppSpacing` (pageHorizontal 24,
   cardGap 14, section 32, bottomBarClearance 120), `AppColors` / `CupertinoColors`,
   and `AppTextStyles.x(context)`.
5. **Preserve pixel parity**: never "improve" existing `LiquidGlassSettings` values,
   qualities, or shapes.

## Key building blocks

- One import for the design system: `import '.../ui/ui.dart';`
- Pushed screens: `AppPage(title:, children:, appBarActions:)` — full glass page shell.
- Home tab bodies: `TabContentView(title:, subtitle:, children:)` — handles safe area,
  34pt title, 120pt bottom-bar clearance.
- Shared widgets: `SectionTitle`, `LauncherTile`, `InfoCard`/`MetricRow`, `GlassBackButton`,
  `CatalogCard`, `SmallDemoCard`/`LargeDemoCard`, `ChipRow`, `LabeledSliderRow`, `QualityBadge`.
- From the package: `GlassScaffold`, `GlassTabBar.bottom`, `GlassCard`, `GlassButton`,
  `GlassToast.show`, `GlassProgressIndicator.circular()`, `GlassSheet`/`GlassModalSheet`.
- Networking: `ref.watch(apiClientProvider)` (dio, auth+logging interceptors, mapped errors).
  Env via `AppEnv` + `--dart-define` (API_BASE_URL, ENV, NETWORK_LOGS).
- Storage: `keyValueStorageProvider` (SharedPreferences; overridden in `bootstrap()` —
  reading it before bootstrap throws by design) and `secureStorageProvider` (tokens).
- Theme: `ref.read(themeControllerProvider.notifier).toggle()`; `context.isDark`;
  default is dark. Status bar: `GlassThemeHelper.statusBarStyle(context)`.
- Boot order in `bootstrap()`: bindings → `LiquidGlassWidgets.initialize()` (glass
  crashes if painted before this) → SharedPreferences → error handlers → `runApp`.

## Starting a new app from this template

- **Tab-based app**: keep `features/home/`, edit `_tabs` + body switch in
  `home_screen.dart`, rewrite the files in `home/presentation/tabs/`.
- **Single-screen start**: delete `features/home|catalog|demos|showcases`
  (keep `_template/`), reset `routes.dart` + `app_router.dart` to just `/`,
  point it at your first screen. Keep `MaterialPage` in the `_route` helper.

## Testing

Override `keyValueStorageProvider` with an in-memory fake, pump
`ProviderScope(child: App())` — see `test/widget_test.dart`.
