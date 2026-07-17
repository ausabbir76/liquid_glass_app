/// Mock data for the Podcasts showcase.
///
/// Swap these for an API source (the itunesId values are real Apple Podcasts
/// Store IDs, ready for the iTunes lookup API) by changing the providers in
/// ../providers.dart — screens read only through providers.
library;

import 'package:flutter/cupertino.dart';

class PodcastItem {
  const PodcastItem({
    required this.title,
    required this.author,
    required this.duration,
    required this.color,
    required this.icon,
    this.progress = 0.0,
    this.itunesId,
  });
  final String title;
  final String author;
  final String duration;
  final Color color;
  final IconData icon;
  final double progress;

  /// iTunes Store podcast ID — artwork is fetched live via the iTunes lookup API.
  final int? itunesId;
}

// ─── Podcast episode / show data ─────────────────────────────────────────────
// itunesId values are the Apple Podcasts Store IDs for each show.

const kUpNext = [
  PodcastItem(
    title: 'The Ricky Gervais Podcast',
    author: 'Ricky Gervais',
    duration: '1h 7m',
    color: Color(0xFF1A1A2E),
    icon: CupertinoIcons.mic_solid,
    progress: 0.15,
    itunesId: 135789411,
  ),
  PodcastItem(
    title: 'The Daily',
    author: 'The New York Times',
    duration: '22m',
    color: Color(0xFF0C0C0E),
    icon: CupertinoIcons.book_solid,
    progress: 0.45,
    itunesId: 1200361736,
  ),
  PodcastItem(
    title: 'Hard Fork',
    author: 'The New York Times',
    duration: '48m',
    color: Color(0xFF1C2340),
    icon: CupertinoIcons.antenna_radiowaves_left_right,
    itunesId: 1528594034,
  ),
  PodcastItem(
    title: 'Lex Fridman Podcast #421',
    author: 'Lex Fridman',
    duration: '2h 14m',
    color: Color(0xFF0D0D0D),
    icon: CupertinoIcons.videocam_fill,
    itunesId: 1434243584,
  ),
];

const kNowWithVideo = [
  PodcastItem(
    title: 'Huberman Lab',
    author: 'Dr. Andrew Huberman',
    duration: '2h 3m',
    color: Color(0xFF1B3A4B),
    icon: CupertinoIcons.flame_fill,
    itunesId: 1545953110,
  ),
  PodcastItem(
    title: 'SmartLess',
    author: 'Jason Bateman, Sean Hayes, Will Arnett',
    duration: '54m',
    color: Color(0xFF2B2B2B),
    icon: CupertinoIcons.star_fill,
    itunesId: 1521578868,
  ),
  PodcastItem(
    title: "Conan O'Brien Needs A Friend",
    author: 'Team Coco & Earwolf',
    duration: '1h 12m',
    color: Color(0xFF3D1A00),
    icon: CupertinoIcons.person_2_fill,
    itunesId: 1438054347,
  ),
  PodcastItem(
    title: 'Crime Junkie',
    author: 'audiochuck',
    duration: '40m',
    color: Color(0xFF2D0000),
    icon: CupertinoIcons.exclamationmark_triangle_fill,
    itunesId: 1322200189,
  ),
];

const kYouMightLike = [
  PodcastItem(
    title: 'Hidden Brain',
    author: 'Shankar Vedantam',
    duration: '45m',
    color: Color(0xFF2E1A00),
    icon: CupertinoIcons.infinite,
    itunesId: 1028908750,
  ),
  PodcastItem(
    title: 'Stuff You Should Know',
    author: 'iHeart Podcasts',
    duration: 'Bi-weekly',
    color: Color(0xFF001A33),
    icon: CupertinoIcons.book_fill,
    itunesId: 278981407,
  ),
  PodcastItem(
    title: 'No Such Thing as a Fish',
    author: 'QI Elves',
    duration: '30m',
    color: Color(0xFF1A2D3D),
    icon: CupertinoIcons.sparkles,
    itunesId: 840986946,
  ),
  PodcastItem(
    title: 'Planet Money',
    author: 'NPR',
    duration: 'Bi-weekly',
    color: Color(0xFF1A1200),
    icon: CupertinoIcons.chart_bar_fill,
    itunesId: 290783428,
  ),
  PodcastItem(
    title: 'Darknet Diaries',
    author: 'Jack Rhysider',
    duration: '1h',
    color: Color(0xFF1C0A1A),
    icon: CupertinoIcons.lock_fill,
    itunesId: 1296350485,
  ),
];

const kPopularShows = [
  PodcastItem(
    title: 'TED Talks Daily',
    author: 'TED',
    duration: 'Daily',
    color: Color(0xFF001A1A),
    icon: CupertinoIcons.waveform,
    itunesId: 160904630,
  ),
  PodcastItem(
    title: 'My Favorite Murder',
    author: 'Exactly Right',
    duration: 'Weekly',
    color: Color(0xFF1A001A),
    icon: CupertinoIcons.star_fill,
    itunesId: 1074507850,
  ),
  PodcastItem(
    title: 'Serial',
    author: 'Serial Productions & The New York Times',
    duration: 'Varies',
    color: Color(0xFF1A2E1A),
    icon: CupertinoIcons.headphones,
    itunesId: 917918570,
  ),
  PodcastItem(
    title: '99% Invisible',
    author: 'Roman Mars',
    duration: 'Bi-weekly',
    color: Color(0xFF2A1A00),
    icon: CupertinoIcons.building_2_fill,
    itunesId: 394775318,
  ),
  PodcastItem(
    title: 'Freakonomics Radio',
    author: 'Freakonomics Radio + Stitcher',
    duration: 'Weekly',
    color: Color(0xFF00141A),
    icon: CupertinoIcons.chart_bar_square_fill,
    itunesId: 354668519,
  ),
];
