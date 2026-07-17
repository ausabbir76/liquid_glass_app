import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'data/mock_podcasts_data.dart';

/// "Up Next" shelf. Point at a repository/API when going real.
final upNextProvider = Provider<List<PodcastItem>>((ref) => kUpNext);

/// "Now with Video" shelf.
final nowWithVideoProvider =
    Provider<List<PodcastItem>>((ref) => kNowWithVideo);

/// "You Might Like" shelf.
final youMightLikeProvider =
    Provider<List<PodcastItem>>((ref) => kYouMightLike);

/// "Popular Shows" shelf.
final popularShowsProvider =
    Provider<List<PodcastItem>>((ref) => kPopularShows);
