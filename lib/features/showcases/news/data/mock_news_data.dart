/// Mock data for the News showcase.
///
/// Swap these for an API source by changing the providers in
/// ../providers.dart — screens read only through providers.
library;

import 'package:flutter/cupertino.dart';

class Article {
  const Article({
    required this.headline,
    required this.publication,
    required this.imageAsset,
    this.isLive = false,
    this.hasTopStoriesBadge = false,
    this.moreCoverage = false,
  });

  final String headline;
  final String publication;
  final String imageAsset;
  final bool isLive;
  final bool hasTopStoriesBadge;
  final bool moreCoverage;
}

class TopicCategory {
  const TopicCategory({
    required this.name,
    required this.color,
    required this.imageAsset,
  });

  final String name;
  final Color color;
  final String imageAsset;
}

const kTopStories = [
  Article(
    headline:
        'Tehran warns US over Strait of Hormuz threat; Netanyahu suggests Israel helped rescue airman',
    publication: 'The Guardian',
    imageAsset: 'assets/news_images/tehran_guardian.jpg',
    // isLive: true,
    hasTopStoriesBadge: true,
    moreCoverage: true,
  ),
  Article(
    headline:
        'Markets surge after Fed signals three rate cuts this year despite persistent inflation',
    publication: 'The Wall Street Journal',
    imageAsset: 'assets/news_images/markets_wsj.jpg',
    moreCoverage: true,
  ),
  Article(
    headline:
        'Apple announces spatial computing breakthrough at WWDC, Vision Pro 2 coming this fall',
    publication: 'Bloomberg',
    imageAsset: 'assets/news_images/apple_bloomberg.jpg',
  ),
];

const kMoreArticles = [
  Article(
    headline:
        'Scientists discover potential link between gut microbiome and Alzheimer\'s disease risk',
    publication: 'Nature',
    imageAsset: 'assets/news_images/science_nature.jpg',
  ),
  Article(
    headline:
        'UEFA Champions League: Real Madrid face Arsenal in stunning semi-final clash',
    publication: 'BBC Sport',
    imageAsset: 'assets/news_images/soccer_bbc.jpg',
  ),
  Article(
    headline:
        'Climate summit reaches historic agreement on carbon emissions targets ahead of 2030 deadline',
    publication: 'Reuters',
    imageAsset: 'assets/news_images/climate_reuters.jpg',
    isLive: true,
  ),
  Article(
    headline:
        'New AI model writes code faster than senior engineers, raising questions about the future of work',
    publication: 'MIT Technology Review',
    imageAsset: 'assets/news_images/ai_mit.jpg',
  ),
  Article(
    headline:
        'SpaceX Starship completes first fully successful orbital flight and ocean landing',
    publication: 'The Verge',
    imageAsset: 'assets/news_images/spacex_verge.jpg',
  ),
];

const kTopics = [
  TopicCategory(
    name: 'Sport',
    color: Color(0xFF34C759),
    imageAsset: 'assets/news_images/topic_sport.jpg',
  ),
  TopicCategory(
    name: 'Entertainment',
    color: Color(0xFFFF3B30),
    imageAsset: 'assets/news_images/topic_entertainment.jpg',
  ),
  TopicCategory(
    name: 'Business',
    color: Color(0xFF007AFF),
    imageAsset: 'assets/news_images/topic_business.jpg',
  ),
  TopicCategory(
    name: 'Politics',
    color: Color(0xFF3A3A3C),
    imageAsset: 'assets/news_images/topic_politics.jpg',
  ),
  TopicCategory(
    name: 'Food',
    color: Color(0xFFFFCC02),
    imageAsset: 'assets/news_images/topic_food.jpg',
  ),
  TopicCategory(
    name: 'Health',
    color: Color(0xFFFF9500),
    imageAsset: 'assets/news_images/topic_health.jpg',
  ),
  TopicCategory(
    name: 'Lifestyle',
    color: Color(0xFF30B0C7),
    imageAsset: 'assets/news_images/topic_lifestyle.jpg',
  ),
  TopicCategory(
    name: 'Science',
    color: Color(0xFFAF52DE),
    imageAsset: 'assets/news_images/topic_science.jpg',
  ),
  TopicCategory(
    name: 'Climate',
    color: Color(0xFFBF5AF2),
    imageAsset: 'assets/news_images/topic_climate.jpg',
  ),
  TopicCategory(
    name: 'Cars',
    color: Color(0xFF636366),
    imageAsset: 'assets/news_images/topic_cars.jpg',
  ),
  TopicCategory(
    name: 'Home & Garden',
    color: Color(0xFF34C759),
    imageAsset: 'assets/news_images/topic_garden.jpg',
  ),
  TopicCategory(
    name: 'Travel',
    color: Color(0xFF30B0C7),
    imageAsset: 'assets/news_images/topic_travel.jpg',
  ),
];

const kNewsCategories = [
  'Sport',
  'Business',
  'Food',
  'Entertainment',
  'Health',
  'Science',
  'Climate',
];
