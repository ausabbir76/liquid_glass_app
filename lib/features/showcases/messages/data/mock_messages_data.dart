/// Mock data for the Messages showcase.
///
/// Swap [kConversations] for an API/database source by changing
/// `conversationsProvider` in ../providers.dart — screens read only through
/// the provider.
library;

class Conversation {
  const Conversation({
    required this.name,
    required this.preview,
    required this.time,
    this.initial,
    this.isUnread = false,
    this.hasAttachment = false,
  });
  final String name;
  final String preview;
  final String time;
  final String? initial; // null → generic avatar icon
  final bool isUnread;
  final bool hasAttachment;
}

const kConversations = [
  Conversation(
    name: 'Mum',
    preview: 'Don\'t forget dinner on Sunday! 🍗',
    time: '5:41 pm',
    initial: 'M',
    isUnread: true,
  ),
  Conversation(
    name: 'Work Group 💼',
    preview: 'Jake: Can everyone join the 3pm standup?',
    time: '4:56 pm',
    initial: 'W',
    isUnread: true,
  ),
  Conversation(
    name: 'Alex',
    preview: 'You liked "Sounds good, see you there"',
    time: '11:06 am',
    initial: 'A',
  ),
  Conversation(
    name: 'Priya',
    preview: 'Cheers! Safe travels 🙌',
    time: 'Tuesday',
    initial: 'P',
  ),
  Conversation(
    name: 'Sam',
    preview: 'Attachment: 1 Photo',
    time: 'Tuesday',
    initial: 'S',
    hasAttachment: true,
  ),
  Conversation(
    name: '+61 428 048 980',
    preview:
        'Hi! Just a reminder your appointment is Fri 9 May at 2:30 PM. Reply STOP to opt out.',
    time: 'Monday',
  ),
  Conversation(
    name: '+61 482 092 063',
    preview:
        'Your parcel has been delivered to the front door. Track at auspost.com.au',
    time: 'Monday',
  ),
  Conversation(
    name: 'Jordan',
    preview: 'haha yeah that was wild 😂',
    time: 'Monday',
    initial: 'J',
  ),
  Conversation(
    name: 'Taylor',
    preview: 'Ok sounds good!',
    time: 'Sunday',
    initial: 'T',
  ),
  Conversation(
    name: '+61 409 593 783',
    preview:
        'Hi! FREE flu vaccines are now available for ALL ages at participating pharmacies near you.',
    time: 'Sunday',
  ),
  Conversation(
    name: 'Riley',
    preview: 'The reservation is at 7:30, don\'t be late lol',
    time: 'Saturday',
    initial: 'R',
    isUnread: true,
  ),
  Conversation(
    name: 'Westpac',
    preview: 'Your statement is ready. Log in to view.',
    time: 'Saturday',
  ),
  Conversation(
    name: 'Casey',
    preview: 'Can you send me that recipe again?',
    time: 'Fri',
    initial: 'C',
  ),
  Conversation(
    name: 'Fitness First',
    preview: 'Your class is confirmed for tomorrow at 6:45 AM. See you there!',
    time: 'Fri',
  ),
  Conversation(
    name: 'Dad',
    preview: 'Call me when you get a chance mate',
    time: 'Thu',
    initial: 'D',
    isUnread: true,
  ),
];
