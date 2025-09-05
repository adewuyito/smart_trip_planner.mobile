import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smart_trip_planner/presentation/chat/chat_response_bubble_widget.dart';
import 'package:smart_trip_planner/presentation/shared/avater_widget.dart';
import 'package:smart_trip_planner/presentation/shared/prompt_input_widget.dart';

class ChatView extends ConsumerWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back_sharp),
        ),
        centerTitle: false,
        title: Text(
          "Home",
          style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: [SAvaterWidget()],
        actionsPadding: EdgeInsets.only(right: 24),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 27),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            ChatResponseThread(),

            const SizedBox(height: 24),

            ChatInputField(
              onSend: (value) { // TODO: Implement chat feature
                ref.read(chatProvider.notifier).state = [
                  ...ref.read(chatProvider),
                  ChatMessage(text: value, isMe: true),
                ];

                // simulate "received" reply
                Future.delayed(const Duration(seconds: 1), () {
                  ref.read(chatProvider.notifier).state = [
                    ...ref.read(chatProvider),
                    ChatMessage(text: "Echo: $value", isMe: false),
                  ];
                });
              },
            ),
            // TwoChatInputField(onSend: (String value) {}),
          ],
        ),
      ),
    );
  }
}

class ChatResponseThread extends ConsumerWidget {
  const ChatResponseThread({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messages = ref.watch(chatProvider);

    return Expanded(
      child: ListView.separated(
        reverse: true,
        // padding: const EdgeInsets.all(12),
        itemCount: messages.length,
        itemBuilder: (context, index) {
          final msg = messages[messages.length - 1 - index];
          if (msg.isMe) {
            return UserMessage(text: msg.text);
          } else {
            return AIMessage(text: msg.text);
          }
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(height: 25);
        },
      ),
    );
  }
}

final chatProvider = StateProvider<List<ChatMessage>>((ref) => []);

/// Chat message model
class ChatMessage {
  final String text;
  final bool isMe;

  ChatMessage({required this.text, required this.isMe});
}
