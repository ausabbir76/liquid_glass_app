/// Apple News iOS 26 — High-Fidelity Demo
///
/// Replicates the Apple News app layout with a real GlassBottomBar
/// using the new morphing search feature.
///
/// Routed via the app router (Routes.news).
library;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

import '../../../../constants/sf_symbols.dart';
import '../data/mock_news_data.dart';
import '../providers.dart';

// ─────────────────────────────────────────────────────────────────────────────
// THEME CONSTANTS
// ─────────────────────────────────────────────────────────────────────────────

const _kNewsRed = Color(0xFFFF2D55);
const _kLiveBadge = Color(0xFFFF3B30);
const _kBackground = CupertinoDynamicColor.withBrightness(
  color: Color(0xFFF2F2F7),
  darkColor: Color(0xFF000000),
);
const _kCardBackground = CupertinoDynamicColor.withBrightness(
  color: Color(0xFFFFFFFF),
  darkColor: Color(0xFF1C1C1E),
);
const _kSeparator = CupertinoColors.separator;

// Data models + mock feeds live in ../data/mock_news_data.dart and are
// exposed through the providers in ../providers.dart.

// NOTE: the removed standalone entry point wrapped the app with
// `LiquidGlassWidgets.wrap(adaptiveQuality: true)` and set ThemeData
// primary/surface to _kNewsRed/_kBackground. The real app's global
// bootstrap owns those responsibilities now.

// ─────────────────────────────────────────────────────────────────────────────
// MAIN SCREEN
// ─────────────────────────────────────────────────────────────────────────────

class AppleNewsHomeScreen extends ConsumerStatefulWidget {
  const AppleNewsHomeScreen({super.key});

  @override
  ConsumerState<AppleNewsHomeScreen> createState() =>
      _AppleNewsHomeScreenState();
}

class _AppleNewsHomeScreenState extends ConsumerState<AppleNewsHomeScreen> {
  bool _isSearching = false;
  bool _searchFieldFocused = false; // true = keyboard visible
  int _selectedTab = 0; // 0=Today, 1=News+, 2=Audio, 3=Following

  @override
  Widget build(BuildContext context) {
    // Android 3-button nav requires us to push the bar above the opaque buttons.
    // On iOS and gesture-nav Android, viewPaddingOf returns 0 so no offset applies.
    final platform = Theme.of(context).platform;
    final isIOS =
        platform == TargetPlatform.iOS || platform == TargetPlatform.macOS;
    final sysBottom = isIOS ? 0.0 : MediaQuery.viewPaddingOf(context).bottom;

    return GlassScaffold(
      background: ColoredBox(color: _kBackground.resolveFrom(context)),
      statusBarStyle: CupertinoTheme.of(context).brightness == Brightness.dark
          ? GlassStatusBarStyle.light
          : GlassStatusBarStyle.dark,
      topEdgeFade: true,
      bottomEdgeFade: true,
      resizeToAvoidBottomInset: false,

      // ── Body ────────────────────────────────────────────────────────────────
      body: GestureDetector(
        onTap: () {
          if (_searchFieldFocused) {
            FocusManager.instance.primaryFocus?.unfocus();
          }
        },
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) =>
              FadeTransition(opacity: animation, child: child),
          child: !_isSearching
              ? _buildTodayView(key: const ValueKey('today'))
              : _searchFieldFocused
              ? _buildNoRecentSearches(key: const ValueKey('no-recent'))
              : _buildSearchBrowseView(key: const ValueKey('search-browse')),
        ),
      ),

      // ── Bottom navigation bar ──────────────────────────────────────────────
      bottomBar: Padding(
        padding: EdgeInsets.only(bottom: sysBottom),
        child: GlassTabBar.searchable(
          selectedIndex: _selectedTab,
          isSearchActive: _isSearching,
          onTabSelected: (index) => setState(() {
            _selectedTab = index;
            _isSearching = false;
          }),
          selectedIconColor: Color.fromRGBO(255, 90, 130, 1),
          unselectedIconColor: CupertinoColors.label.resolveFrom(context),
          labelFontSize: 10,
          iconSize: 26,
          magnification: 1.15,
          iconLabelSpacing: 0,
          spacing: 8,
          indicatorColor: CupertinoColors.tertiaryLabel.resolveFrom(context),
          quality: GlassQuality.premium,
          interactionBehavior: GlassInteractionBehavior.full,
          settings: LiquidGlassSettings(
            glassColor: CupertinoTheme.of(context).brightness == Brightness.dark
                ? const Color(0xAA1C1C1E)
                : const Color(0xCCFFFFFF),
            thickness: 30,
            blur: 2,
            chromaticAberration:
                0.15, // iOS 26 has subtle iridescent rainbow fringing
            lightAngle: GlassDefaults.lightAngle,
            lightIntensity: .3,
            ambientStrength: 0,
            refractiveIndex: 1.2,
            saturation: 1.2,
            specularSharpness: GlassSpecularSharpness.medium,
          ),
          searchConfig: GlassSearchBarConfig(
            hintText: 'Apple News',
            onSearchToggle: (active) => setState(() {
              _isSearching = active;
              if (!active) _searchFieldFocused = false;
            }),
            onSearchFocusChanged: (focused) =>
                setState(() => _searchFieldFocused = focused),
            searchIconColor: CupertinoColors.label.resolveFrom(context),
            // Slightly larger (26 pt) to match Apple News's proportionally bold
            // magnifying-glass icon in the collapsed search pill.
            searchIcon: Icon(
              CupertinoIcons.search,
              size: 30,
              color: CupertinoColors.label.resolveFrom(context),
            ),
            textInputAction: TextInputAction.search,
            autoFocusOnExpand: false,
            showsCancelButton: true,
            onMicTap: () {},
          ),
          tabs: [
            GlassTab(
              label: 'Today',
              icon: SizedBox(
                width: 24,
                height: 24,
                child: SvgPicture.asset(
                  'assets/news_logo.svg',
                  fit: BoxFit.contain,
                  colorFilter: ColorFilter.mode(
                    CupertinoColors.label.resolveFrom(context),
                    BlendMode.srcIn,
                  ),
                ),
              ),
              activeIcon: SizedBox(
                width: 24,
                height: 24,
                child: SvgPicture.asset(
                  'assets/news_logo.svg',
                  fit: BoxFit.contain,
                  colorFilter: const ColorFilter.mode(
                    Color.fromRGBO(255, 90, 130, 1),
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            GlassTab(
              label: 'News+',
              icon: SizedBox(
                width: 28,
                height: 28,
                child: Icon(SFSymbols.newspaper_fill, size: 28),
              ),
              activeIcon: SizedBox(
                width: 28,
                height: 28,
                child: Icon(SFSymbols.newspaper_fill, size: 28),
              ),
            ),
            GlassTab(
              label: 'Audio',
              icon: SizedBox(
                width: 26,
                height: 26,
                child: SvgPicture.asset(
                  'assets/audio.svg',
                  fit: BoxFit.contain,
                  colorFilter: ColorFilter.mode(
                    CupertinoColors.label.resolveFrom(context),
                    BlendMode.srcIn,
                  ),
                ),
              ),
              activeIcon: SizedBox(
                width: 26,
                height: 26,
                child: SvgPicture.asset(
                  'assets/audio.svg',
                  fit: BoxFit.contain,
                  colorFilter: const ColorFilter.mode(
                    Color.fromRGBO(255, 90, 130, 1),
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            GlassTab(
              label: 'Following',
              icon: SizedBox(
                width: 26,
                height: 26,
                child: SvgPicture.asset(
                  'assets/following.svg',
                  fit: BoxFit.contain,
                  colorFilter: ColorFilter.mode(
                    CupertinoColors.label.resolveFrom(context),
                    BlendMode.srcIn,
                  ),
                ),
              ),
              activeIcon: SizedBox(
                width: 26,
                height: 26,
                child: SvgPicture.asset(
                  'assets/following.svg',
                  fit: BoxFit.contain,
                  colorFilter: const ColorFilter.mode(
                    Color.fromRGBO(255, 90, 130, 1),
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  // TODAY VIEW
  // ─────────────────────────────────────────────────────────────────────────

  Widget _buildTodayView({Key? key}) {
    return CustomScrollView(
      key: key,
      slivers: [
        SliverToBoxAdapter(
          child: SizedBox(height: MediaQuery.paddingOf(context).top + 8),
        ),
        SliverToBoxAdapter(child: _buildNewsHeader()),
        SliverToBoxAdapter(child: _buildCategoryChips()),
        SliverToBoxAdapter(
          child: _buildSectionHeader(
            'Top Stories',
            'Chosen by the Apple News editors.',
          ),
        ),
        SliverToBoxAdapter(child: _buildHeroArticleCard(ref.watch(topStoriesProvider)[0])),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) =>
                _buildCompactArticleCard(ref.watch(topStoriesProvider)[index + 1]),
            childCount: ref.watch(topStoriesProvider).length - 1,
          ),
        ),
        SliverToBoxAdapter(
          child: _buildSectionHeader('Trending Stories', null),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => _buildCompactArticleCard(ref.watch(moreArticlesProvider)[index]),
            childCount: ref.watch(moreArticlesProvider).length,
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(height: MediaQuery.paddingOf(context).bottom + 100),
        ),
      ],
    );
  }

  Widget _buildNewsHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 8, 16, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.apple,
                    color: CupertinoColors.label.resolveFrom(context),
                    size: 38,
                  ),
                  //  SizedBox(width: 4),
                  Text(
                    'News',
                    style: TextStyle(
                      color: CupertinoColors.label.resolveFrom(context),
                      fontSize: 36,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.5,
                    ),
                  ),
                ],
              ),
              Text(
                '16 April',
                style: TextStyle(
                  color: CupertinoColors.secondaryLabel.resolveFrom(context),
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            decoration: BoxDecoration(
              color: _kNewsRed,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Text(
              'Try News+ Free',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChips() {
    return SizedBox(
      height: 48,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: ref.watch(newsCategoriesProvider).length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) =>
            _CategoryChip(label: ref.watch(newsCategoriesProvider)[index]),
      ),
    );
  }

  Widget _buildSectionHeader(String title, String? subtitle) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: _kNewsRed,
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),
          if (subtitle != null)
            Text(
              subtitle,
              style: TextStyle(
                color: CupertinoColors.secondaryLabel.resolveFrom(context),
                fontSize: 14,
              ),
            ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildHeroArticleCard(Article article) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.asset(article.imageAsset, fit: BoxFit.cover),
            ),
            Container(
              color: _kCardBackground.resolveFrom(context),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (article.isLive) _buildLiveBadge(),
                  if (article.isLive) const SizedBox(height: 8),
                  Text(
                    article.publication,
                    style: TextStyle(
                      color: CupertinoColors.secondaryLabel.resolveFrom(
                        context,
                      ),
                      fontSize: 13,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    article.headline,
                    style: TextStyle(
                      color: CupertinoColors.label.resolveFrom(context),
                      fontSize: 19,
                      fontWeight: FontWeight.w700,
                      height: 1.3,
                    ),
                  ),
                  if (article.moreCoverage) ...[
                    const SizedBox(height: 12),
                    Container(
                      height: 1,
                      color: _kSeparator.resolveFrom(context),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'MORE COVERAGE',
                      style: TextStyle(
                        color: CupertinoColors.tertiaryLabel.resolveFrom(
                          context,
                        ),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompactArticleCard(Article article) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Container(
          color: _kCardBackground.resolveFrom(context),
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (article.isLive) ...[
                      _buildLiveBadge(),
                      const SizedBox(height: 6),
                    ],
                    Text(
                      article.publication,
                      style: TextStyle(
                        color: CupertinoColors.secondaryLabel.resolveFrom(
                          context,
                        ),
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      article.headline,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: CupertinoColors.label.resolveFrom(context),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        height: 1.35,
                      ),
                    ),
                    if (article.moreCoverage) ...[
                      const SizedBox(height: 10),
                      Text(
                        'MORE COVERAGE',
                        style: TextStyle(
                          color: CupertinoColors.tertiaryLabel.resolveFrom(
                            context,
                          ),
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  article.imageAsset,
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLiveBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: _kLiveBadge,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        'Live',
        style: TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  // SEARCH VIEW
  // ─────────────────────────────────────────────────────────────────────────

  // State 2 — searching but keyboard not open: show topic browse grid
  Widget _buildSearchBrowseView({Key? key}) {
    return CustomScrollView(
      key: key,
      slivers: [
        SliverToBoxAdapter(
          child: SizedBox(height: MediaQuery.paddingOf(context).top + 8),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 16, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Apple News logo row — matches reference screenshot
                Row(
                  children: [
                    Icon(
                      Icons.apple,
                      color: CupertinoColors.label.resolveFrom(context),
                      size: 22,
                    ),
                    SizedBox(width: 4),
                    Text(
                      'News',
                      style: TextStyle(
                        color: CupertinoColors.label.resolveFrom(context),
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                Text(
                  'Search',
                  style: TextStyle(
                    color: CupertinoColors.secondaryLabel.resolveFrom(
                      context,
                    ), // iOS secondary-label grey
                    fontSize: 34,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.5,
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.fromLTRB(
            16,
            0,
            16,
            MediaQuery.paddingOf(context).bottom + 100,
          ),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.65,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) => _TopicCard(topic: ref.watch(newsTopicsProvider)[index]),
              childCount: ref.watch(newsTopicsProvider).length,
            ),
          ),
        ),
      ],
    );
  }

  // State 3 — searching + keyboard visible: show "No Recent Searches"
  Widget _buildNoRecentSearches({Key? key}) {
    // viewInsetsOf gives the keyboard height each frame (no setState needed).
    // Adding it as bottom padding to the outer container makes Center()
    // center its content in the remaining space ABOVE the keyboard — exactly
    // what Apple News does. The extra 50 leaves room for the floating bar.
    final keyboardH = MediaQuery.viewInsetsOf(context).bottom;
    return Container(
      key: key,
      color: _kBackground.resolveFrom(context),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.only(bottom: keyboardH + 50),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  CupertinoIcons.search,
                  size: 64,
                  color: CupertinoColors.tertiaryLabel.resolveFrom(context),
                ),
                const SizedBox(height: 16),
                Text(
                  'No Recent Searches',
                  style: TextStyle(
                    color: CupertinoColors.label.resolveFrom(context),
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.3,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Your recent searches will appear here.',
                  style: TextStyle(
                    color: CupertinoColors.tertiaryLabel.resolveFrom(context),
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// SUB-WIDGETS
// ─────────────────────────────────────────────────────────────────────────────

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: CupertinoColors.systemFill.resolveFrom(context),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: CupertinoColors.label.resolveFrom(context),
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

// Full image-backed topic cards — matches iOS 26 Apple News search grid.
class _TopicCard extends StatelessWidget {
  const _TopicCard({required this.topic});

  final TopicCategory topic;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: Stack(
        fit: StackFit.expand,
        children: [
          ColoredBox(color: topic.color),
          // Image at partial opacity so the category colour dominates.
          Opacity(
            opacity: 0.45,
            child: Image.asset(topic.imageAsset, fit: BoxFit.cover),
          ),
          Positioned(
            left: 12,
            bottom: 10,
            right: 12,
            child: Text(
              topic.name,
              style: TextStyle(
                color: CupertinoColors.label.resolveFrom(context),
                fontSize: 17,
                fontWeight: FontWeight.w700,
                shadows: [
                  Shadow(
                    blurRadius: 6,
                    color: CupertinoColors.black.withValues(alpha: 0.54),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
