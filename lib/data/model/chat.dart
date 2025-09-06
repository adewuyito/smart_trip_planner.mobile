class ChatMessage {
  final String id;
  final bool fromUser;
  final String text; // rendered text (may be partial during stream)
  final Map<String, dynamic>? jsonPayload; // itinerary or tool-calls
  final DateTime ts;
  ChatMessage({
    required this.id,
    required this.fromUser,
    required this.text,
    this.jsonPayload,
    required this.ts,
  });
}
