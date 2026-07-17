/// Mock data for the Music showcase.
///
/// Swap for an API source by changing the provider in ../providers.dart.
library;

import 'package:flutter/cupertino.dart';

class MusicCategory {
  const MusicCategory({required this.name, required this.color});
  final String name;
  final Color color;
}

const kBrowseCategories = [
  MusicCategory(name: 'Pop', color: Color(0xFFFF2D55)),
  MusicCategory(name: 'Hip-Hop', color: Color(0xFF5856D6)),
  MusicCategory(name: 'Rock', color: Color(0xFF636366)),
  MusicCategory(name: 'Electronic', color: Color(0xFF007AFF)),
  MusicCategory(name: 'R&B / Soul', color: Color(0xFFAF52DE)),
  MusicCategory(name: 'Country', color: Color(0xFFFF9500)),
  MusicCategory(name: 'Jazz', color: Color(0xFF30B0C7)),
  MusicCategory(name: 'Classical', color: Color(0xFF34C759)),
  MusicCategory(name: 'Latin', color: Color(0xFFFF3B30)),
  MusicCategory(name: 'Alternative', color: Color(0xFF1C1C1E)),
];
