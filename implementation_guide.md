# Developer Guide: How to Build Your App with Liquid Glass

Welcome! This template provides a pre-wired, beautiful **iOS 26 Liquid Glass** shell. It handles all the complex stuff—glass shaders, routing, local storage, API calling, and light/dark theme persistence.

This guide will walk you through starting a fresh app from scratch in a simple, natural way.

---

## Phase 1: Clear the Desk (Stripping the Demo Screens)

Before coding your own app, you want to get rid of all the pre-packaged Apple app clones and widget catalogs. 

### 1. Delete the Demo Folders
Go to `lib/features/` and delete these four folders:
* 🗑️ `catalog/`
* 🗑️ `demos/`
* 🗑️ `home/`
* 🗑️ `showcases/`

*Leave the `_template/` folder alone! We will use it as our copy-paste blueprint.*

### 2. Clean up Route Names
Open [lib/app/router/routes.dart](file:///C:/My_Folder_1/Flutter/Flutter%20Project/liquid_glass_app/lib/app/router/routes.dart) and replace the entire file content with just this clean starting point:

```dart
/// Central registry of all named routes in your app.
abstract final class Routes {
  static const String home = 'home';
  static const String homePath = '/';
  
  // Add your new screens here as you build them!
  // Example: static const String profile = 'profile';
}
```

### 3. Reset the Router Configuration
Open [lib/app/router/app_router.dart](file:///C:/My_Folder_1/Flutter/Flutter%20Project/liquid_glass_app/lib/app/router/app_router.dart) and replace the entire file with this clean template:

```dart
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// Import your own starting screen here!
// import '../../features/my_feature/presentation/my_screen.dart';
import 'routes.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: Routes.homePath,
    debugLogDiagnostics: false,
    routes: [
      // Point your home route to your own Screen widget instead of Placeholder
      _route(
        Routes.home, 
        path: Routes.homePath, 
        child: const Placeholder(child: Center(child: Text('Welcome to your new Glass App!'))),
      ),
    ],
  );
});

/// Helper to build routes with native Cupertino (swipe-back) transitions.
GoRoute _route(String name, {String? path, required Widget child}) {
  return GoRoute(
    name: name,
    path: path ?? '/$name',
    pageBuilder: (context, state) =>
        CupertinoPage<void>(key: state.pageKey, child: child),
  );
}
```

Now you have a clean slate!

---

## Phase 2: Building Your First Screen (Feature Setup)

To build a new feature, follow the **three-step blueprint** inside `lib/features/_template/`. Let’s build a simple **Profile/Dashboard** feature as an example.

### 1. Copy the Template
Copy the folder `lib/features/_template/` and rename it to `lib/features/dashboard/`.

### 2. Set Up Your Data Model
Open `dashboard/data/template_item.dart` (rename it to `dashboard_item.dart`). 
This is just a simple "bucket" class to hold the data you want to display on screen:

```dart
class DashboardItem {
  final String id;
  final String title;
  final String description;

  const DashboardItem({
    required this.id,
    required this.title,
    required this.description,
  });

  // Convert raw API map data into your clean Dart object
  factory DashboardItem.fromJson(Map<String, dynamic> json) => DashboardItem(
        id: json['id'] as String,
        title: json['title'] as String,
        description: json['description'] as String,
      );
}
```

### 3. Handle the Data Retrieval (Repository)
Open `dashboard/data/template_repository.dart` (rename it to `dashboard_repository.dart`).
The Repository acts like a postman. It fetches your data from the web (or local database) and hands it to the screen. 

*Rule: Repositories return a `Result` wrapper and never crash or throw errors into your UI.*

```dart
import '../../../core/errors/result.dart';
import '../../../core/network/api_client.dart';
import 'dashboard_item.dart';

class DashboardRepository {
  final ApiClient _api;
  DashboardRepository(this._api);

  // When your backend server is ready, call this:
  Future<Result<List<DashboardItem>>> fetchRealData() {
    return _api.get<List<DashboardItem>>(
      '/user/dashboard',
      decode: (data) => (data as List<dynamic>)
          .map((e) => DashboardItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  // Use this to design the UI with dummy data BEFORE the server is built:
  Future<Result<List<DashboardItem>>> fetchMockData() async {
    await Future<void>.delayed(const Duration(milliseconds: 500)); // fake delay
    return const Success([
      DashboardItem(id: '1', title: 'Total Steps', description: '8,420 steps today'),
      DashboardItem(id: '2', title: 'Active Calories', description: '340 kcal burned'),
    ]);
  }
}
```

### 4. Hook up State Management (Providers)
Open `dashboard/providers.dart`.
We use Riverpod providers to cleanly pass the data to the UI screen without boilerplate:

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/api_client.dart';
import 'data/dashboard_item.dart';
import 'data/dashboard_repository.dart';
import '../../../core/errors/result.dart';

// 1. Expose the repository
final dashboardRepositoryProvider = Provider<DashboardRepository>(
  (ref) => DashboardRepository(ref.watch(apiClientProvider)),
);

// 2. Load the data asynchronously (automatically handles loading / error / data states)
final dashboardDataProvider = FutureProvider.autoDispose<List<DashboardItem>>((ref) async {
  final repo = ref.watch(dashboardRepositoryProvider);
  
  // Easily swap between mock data and real API here:
  final result = await repo.fetchMockData(); 
  
  return switch (result) {
    Success(:final value) => value,
    Failure(:final error) => throw error, // handed to the UI screen's error state
  };
});
```

---

## Phase 3: Designing Your Glass Screen (Presentation)

Open `dashboard/presentation/template_screen.dart` (rename it to `dashboard_screen.dart`).
Here, we build the beautiful visual interface.

### The UI Template Code
```dart
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

import '../../../app/theme/app_colors.dart';
import '../../../ui/ui.dart';
import '../providers.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. Watch your data provider
    final dashboardData = ref.watch(dashboardDataProvider);

    // 2. AppPage wraps your screen in a beautiful glass status bar,
    //    scrolling physics, standard wallpaper background, and clean app bar.
    return AppPage(
      title: 'Dashboard',
      appBarActions: [
        CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Icon(CupertinoIcons.settings),
          onPressed: () => GlassToast.show(context, message: 'Settings clicked!'),
        ),
      ],
      children: [
        const SectionTitle(title: 'Overview'),
        const SizedBox(height: 12),
        
        // 3. React to loading, error, and data states automatically
        dashboardData.when(
          loading: () => const Center(
            child: Padding(
              padding: EdgeInsets.all(32),
              child: GlassProgressIndicator.circular(),
            ),
          ),
          error: (error, _) => InfoCard(
            child: Text('Failed to load data: $error'),
          ),
          data: (list) => Column(
            children: [
              for (final item in list) ...[
                LauncherTile(
                  title: item.title,
                  subtitle: item.description,
                  icon: CupertinoIcons.heart_fill,
                  accentColor: AppColors.pink,
                  onTap: () {},
                ),
                const SizedBox(height: 12),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
```

---

## Phase 4: Rules for Premium Aesthetics

To make sure your new screen matches the premium **iOS 26 Liquid Glass** feel:

1. **Never Hardcode Spacing**: Use pre-defined spacing tokens from `AppSpacing`:
   - `AppSpacing.pageHorizontal` (24pt) — for screen padding.
   - `AppSpacing.cardGap` (14pt) — for margins between elements.
   
2. **Never Hardcode Custom Colors**: Use standard semantic colors from `AppColors` (e.g. `AppColors.blue`, `AppColors.green`, `AppColors.accentPurple`).

3. **Never Make Custom Glass Parameters**:
   The engine works best with calibrated preset values from `RecommendedGlassSettings`. Pass these config recipes directly:
   - For interactive elements: `RecommendedGlassSettings.interactive`
   - For cards/list tiles: `RecommendedGlassSettings.standard`
   - For bottom sheets/popups: `RecommendedGlassSettings.sheet`
   - For input fields: `RecommendedGlassSettings.input`

4. **Dynamic Themes**: Wires dark and light themes automatically.
   - To toggle the system dark mode: `ref.read(themeControllerProvider.notifier).toggle()`
   - To check context: `context.isDark` (boolean).

---

## Phase 5: Hook it up and Run

1. Open [lib/app/router/routes.dart](file:///C:/My_Folder_1/Flutter/Flutter%20Project/liquid_glass_app/lib/app/router/routes.dart) and define the route:
   ```dart
   static const String dashboard = 'dashboard';
   ```
2. Open [lib/app/router/app_router.dart](file:///C:/My_Folder_1/Flutter/Flutter%20Project/liquid_glass_app/lib/app/router/app_router.dart):
   - Import your new `DashboardScreen`.
   - Change your `/` (home) route to return your new screen:
     ```dart
     _route(Routes.home, path: Routes.homePath, child: const DashboardScreen()),
     ```
3. Run the application from your terminal:
   ```sh
   flutter run
   ```

You are now successfully running a custom liquid glass app! Keep copying the template for any new feature you need.
