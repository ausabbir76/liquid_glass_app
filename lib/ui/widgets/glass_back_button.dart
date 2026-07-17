import 'package:flutter/cupertino.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

/// The standard 40×40 glass back button used in app bars.
///
/// Replaces ~11 identical inline `GlassButton(icon: CupertinoIcons.back...)`
/// declarations across pages and demos.
class GlassBackButton extends StatelessWidget {
  const GlassBackButton({
    super.key,
    this.quality = GlassQuality.premium,
    this.onTap,
  });

  /// Rendering quality (premium by default, matching the catalog pages).
  final GlassQuality quality;

  /// Custom tap handler; defaults to `Navigator.pop`.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GlassButton(
      quality: quality,
      icon: const Icon(CupertinoIcons.back),
      onTap: onTap ?? () => Navigator.of(context).pop(),
      width: 40,
      height: 40,
      iconSize: 20,
    );
  }
}
