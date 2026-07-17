# Liquid Glass App Template

A **production-ready Flutter starting point** built around
[`liquid_glass_widgets`](https://pub.dev/packages/liquid_glass_widgets) — the
iOS 26 liquid glass design, with clean architecture, centralized reusable
widgets, and all modern app infrastructure wired and ready.

Build a new app by working **only in `lib/features/`** — call classes, pass
data. Everything else (glass rendering, theming, routing, networking, storage,
logging, error handling) is already handled.

## Architecture

```
lib/
├── main.dart              # one line → bootstrap()
├── app/                   # application shell
│   ├── bootstrap.dart     #   init: glass engine, storage, error guards, runApp
│   ├── app.dart           #   root widget: Riverpod + CupertinoApp.router
│   ├── router/            #   go_router: routes.dart (names) + app_router.dart
│   └── theme/             #   theme_controller (dark/light, persisted),
│                          #   app_colors, app_text_styles, app_spacing
├── core/                  # infrastructure (feature-agnostic)
│   ├── config/            #   AppEnv — compile-time env via --dart-define
│   ├── network/           #   ApiClient (dio) + auth/logging interceptors
│   ├── storage/           #   KeyValueStorage + SecureStorage interfaces
│   ├── errors/            #   AppException hierarchy + Result<T>
│   ├── logging/           #   AppLogger
│   ├── connectivity/      #   online/offline providers
│   └── utils/             #   context extensions
├── l10n/                  # localization (.arb files + generated code)
├── ui/                    # ★ centralized design system ★
│   ├── ui.dart            #   ONE import for everything below
│   ├── glass/             #   RecommendedGlassSettings presets, status bar helper
│   ├── backgrounds/       #   ShowcaseBackground, GradientBackground, GlowOrb
│   ├── layout/            #   AppPage (full page shell), TabContentView
│   └── widgets/           #   SectionTitle, GlassBackButton, LauncherTile,
│                          #   cards, control rows, badges, media widgets...
└── features/              # ← YOU WORK HERE
    ├── _template/         #   copy-paste blueprint for any new feature
    ├── home/              #   showcase home (4 tabs)
    ├── catalog/           #   widget catalog pages
    ├── demos/             #   component demos
    └── showcases/         #   Apple app recreations (Music, Messages, ...)
```

### The rules

1. **Features depend on `core/`, `ui/`, `app/theme` — never on each other.**
2. **Screens present; repositories fetch.** Data access returns `Result<T>`
   (never throws into the UI). Screens watch Riverpod providers.
3. **All glass styling comes from `RecommendedGlassSettings`** presets in
   `ui/glass/glass_presets.dart` — the exact values that reproduce the iOS 26
   look on both Skia (standard) and Impeller (premium) renderers. Don't invent
   per-screen glass values.

## Adding a feature (5 minutes)

1. Copy `lib/features/_template/` → `lib/features/my_feature/`.
2. Rename the model, repository, providers and screen.
3. Add a route name in `app/router/routes.dart` and a `_route(...)` entry in
   `app/router/app_router.dart`.
4. Navigate: `context.pushNamed(Routes.myFeature)`.

The template shows the full pattern: model → repository (`Result<T>`,
mock ↔ real API swap in one line) → `FutureProvider` → `AppPage` screen with
loading/error/data states.

## Environment config

```sh
flutter run --dart-define=API_BASE_URL=https://api.example.com --dart-define=ENV=dev
flutter build ipa --dart-define-from-file=env/prod.json
```

Read values via `AppEnv` (`core/config/app_env.dart`). Add new keys there.

## Theming

- Dark/light toggle: `ref.read(themeControllerProvider.notifier).toggle()`
  — persisted across launches.
- Colors: `AppColors` (iOS system palette). Text: `AppTextStyles`.
  Metrics: `AppSpacing`.
- Status bar: `GlassThemeHelper.statusBarStyle(context)`.

## Localization

Add strings to `lib/l10n/app_en.arb`, run `flutter gen-l10n`, use
`AppLocalizations.of(context).yourKey`. Add `app_<locale>.arb` files for more
languages.

## Testing

```sh
flutter test
```

`test/widget_test.dart` shows the pattern: override
`keyValueStorageProvider` with an in-memory fake, pump `App`, assert.

## Developer Guide: Building Your App

This template is designed to give you a head start. You can build your app using two main approaches depending on whether your app needs a **persistent bottom tab bar** or a **custom single-screen/multi-page workflow**.

---

### Alternative A: Building via the Bottom Tab Bar (Recommended)

If your app uses a tab-based layout (like Apple Music or Podcasts), you can build it by keeping the existing `HomeScreen` scaffold and editing the tabs inside `lib/features/home/presentation/`.

#### Step 1: Customize the Tab Bar Structure
Open [lib/features/home/presentation/home_screen.dart](file:///C:/My_Folder_1/Flutter/Flutter%20Project/liquid_glass_app/lib/features/home/presentation/home_screen.dart). This file hosts the main `GlassScaffold` and `GlassTabBar.bottom`.

1. **Rename Tab Labels & Icons**: Update the `_tabs` list (lines 31–52) with your app's custom labels and icons:
   ```dart
   static const _tabs = [
     GlassTab(
       label: 'My Feed',
       icon: Icon(CupertinoIcons.house),
       activeIcon: Icon(CupertinoIcons.house_fill),
     ),
     GlassTab(
       label: 'Search',
       icon: Icon(CupertinoIcons.search),
       activeIcon: Icon(CupertinoIcons.search),
     ),
     GlassTab(
       label: 'Profile',
       icon: Icon(CupertinoIcons.person),
       activeIcon: Icon(CupertinoIcons.person_fill),
     ),
   ];
   ```
2. **Link the Screens**: Update the `switch` statement inside `body` (lines 81–87) to map to your customized tab files:
   ```dart
   body: AnimatedSwitcher(
     duration: const Duration(milliseconds: 250),
     child: switch (_selectedTab) {
       0 => const FeedTab(key: ValueKey('feed')),
       1 => const SearchTab(key: ValueKey('search')),
       _ => const ProfileTab(key: ValueKey('profile')),
     },
   ),
   ```

#### Step 2: Modify the Tab Files
Go to `lib/features/home/presentation/tabs/`. 
Rename the tab files (e.g. `explore_tab.dart` -> `feed_tab.dart`) and swap their contents to represent your new layout.

Every tab layout should return a [TabContentView](file:///C:/My_Folder_1/Flutter/Flutter%20Project/liquid_glass_app/lib/ui/layout/tab_content_view.dart) widget, which automatically provides:
* The standard wallpaper backdrop matching the theme.
* Safe-area padding at the top.
* The 34pt large Cupertino-style title and subtitle.
* Padded scrollable content.
* 120pt bottom clearance to prevent content from getting covered by the floating bottom bar.

```dart
import 'package:flutter/cupertino.dart';
import '../../../../ui/ui.dart';

class FeedTab extends StatelessWidget {
  const FeedTab({super.key});

  @override
  Widget build(BuildContext context) {
    return TabContentView(
      title: 'My Feed',
      subtitle: 'Personalized updates for you',
      children: [
        const SizedBox(height: 24),
        const SectionTitle(title: 'Recent Activity'),
        const SizedBox(height: 12),
        
        // Put your feature widgets here!
        GlassCard(
          child: const Text('Here is your custom card content!'),
        ),
      ],
    );
  }
}
```

#### Step 3: Wire Data into Your Tabs
Copy the `lib/features/_template/` blueprint to create a data model, repository, and providers for your tab features:
1. Fetch items using the pre-configured [ApiClient](file:///C:/My_Folder_1/Flutter/Flutter%20Project/liquid_glass_app/lib/core/network/api_client.dart) or [KeyValueStorage](file:///C:/My_Folder_1/Flutter/Flutter%20Project/liquid_glass_app/lib/core/storage/key_value_storage.dart).
2. Wire Riverpod state providers in `providers.dart`.
3. Watch the providers in your tab screen (convert it to a `ConsumerWidget`):
   ```dart
   final itemsAsync = ref.watch(myDataProvider);
   ```

---

### Alternative B: Stripping down to a Single Screen (Alternative Setup)

If your app does not need a bottom tab bar at launch (e.g., it begins with a Login or a Dashboard screen):

1. **Delete Showcase Folders**:
   Delete these directories:
   - `lib/features/home/`
   - `lib/features/catalog/`
   - `lib/features/demos/`
   - `lib/features/showcases/`

2. **Clean up Routes**:
   Open [lib/app/router/routes.dart](file:///C:/My_Folder_1/Flutter/Flutter%20Project/liquid_glass_app/lib/app/router/routes.dart) and clean out all route names except for:
   ```dart
   static const String home = 'home';
   static const String homePath = '/';
   ```

3. **Redirect the App Router**:
   Copy the `_template/` screen code into a new dashboard feature directory.
   Open [lib/app/router/app_router.dart](file:///C:/My_Folder_1/Flutter/Flutter%20Project/liquid_glass_app/lib/app/router/app_router.dart), import your new `DashboardScreen`, and point `/` directly to it:
   ```dart
   _route(Routes.home, path: Routes.homePath, child: const DashboardScreen()),
   ```

---

## Designing with the Liquid Glass Presets

To maintain the premium iOS 26 glass aesthetics, adhere to these simple styling patterns:

### 1. Preset Parameter Rules
Never hardcode raw shader properties. Wrap containers in a `LiquidGlassContainer` and supply configuration presets from [RecommendedGlassSettings](file:///C:/My_Folder_1/Flutter/Flutter%20Project/liquid_glass_app/lib/ui/glass/glass_presets.dart):
* **Cards inside lists**: `RecommendedGlassSettings.standard`
* **Buttons / Controls**: `RecommendedGlassSettings.interactive`
* **Static toolbars**: `RecommendedGlassSettings.surface`
* **Modals & bottom sheets**: `RecommendedGlassSettings.sheet`
* **Input fields**: `RecommendedGlassSettings.input`

### 2. Spacing & Alignments
Always use the 4-point grid tokens in `AppSpacing` to keep lists and grids visually balanced:
* **Horizontal margins**: `AppSpacing.pageHorizontal` (24pt)
* **Gap between cards**: `AppSpacing.cardGap` (14pt)
* **Section breaks**: `AppSpacing.section` (32pt)

### 3. Styling & Color Tokens
* Use typography methods from `AppTextStyles` (e.g., `AppTextStyles.cardTitle(context)`) so they scale correctly with iOS system accessibility.
* Resolve colors using `CupertinoColors` or variables from `AppColors` instead of hex literals.
* Reference `context.isDark` or watch `isDarkModeProvider` to selectively render light/dark elements.

---

## Build & Run

Ensure compile-time environment configuration flags are supplied at launch:
```sh
flutter run --dart-define=API_BASE_URL=https://api.example.com --dart-define=ENV=dev
```


