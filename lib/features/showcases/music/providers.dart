import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'data/mock_music_data.dart';

/// Browse categories for the search view.
/// Point at a repository/API when going real.
final browseCategoriesProvider =
    Provider<List<MusicCategory>>((ref) => kBrowseCategories);
