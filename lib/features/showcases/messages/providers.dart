import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'data/mock_messages_data.dart';

/// Conversation list for the Messages showcase.
///
/// Currently mock data; point this at a repository/API when going real —
/// the screen only reads through this provider.
final conversationsProvider =
    Provider<List<Conversation>>((ref) => kConversations);
