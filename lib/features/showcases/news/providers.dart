import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'data/mock_news_data.dart';

/// Top stories feed. Point at a repository/API when going real.
final topStoriesProvider = Provider<List<Article>>((ref) => kTopStories);

/// Secondary article feed.
final moreArticlesProvider = Provider<List<Article>>((ref) => kMoreArticles);

/// Browse topics for the search view.
final newsTopicsProvider = Provider<List<TopicCategory>>((ref) => kTopics);

/// Category chips on the Today feed.
final newsCategoriesProvider =
    Provider<List<String>>((ref) => kNewsCategories);
