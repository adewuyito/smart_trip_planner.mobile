import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smart_trip_planner/core/constants/colors.dart';

class NoteInputField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;

  const NoteInputField({super.key, this.controller, this.hintText});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 171,
      child: Scrollbar(
        child: TextField(
          controller: controller,
          keyboardType: TextInputType.multiline,
          maxLines: null, // allows multiple lines
          expands: true, // makes it fill the fixed height
          textAlignVertical: TextAlignVertical.top,
          decoration: InputDecoration(
            hintText: hintText ?? 'Write your note...',
            contentPadding: const EdgeInsets.all(16),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Colors.green, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Colors.green, width: 1),
            ),
          ),
        ),
      ),
    );
  }
}

class ChatInputField extends HookConsumerWidget {
  final ValueChanged<String> onSend;

  const ChatInputField({super.key, required this.onSend});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController();
    final hasText = useState(false);

    // Watch text changes
    useEffect(() {
      void listener() {
        hasText.value = controller.text.trim().isNotEmpty;
      }

      controller.addListener(listener);
      return () => controller.removeListener(listener);
    }, [controller]);

    void handleSend() {
      final text = controller.text.trim();
      if (text.isEmpty) return;
      onSend(text);
      controller.clear();
      FocusScope.of(context).unfocus();
    }

    final borderRadius = BorderRadius.circular(30);

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        child: Row(
          children: [
            // Input field
            Expanded(
              child: Container(
                constraints: const BoxConstraints(minHeight: 60),
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: borderRadius,
                  border: Border.all(color: appColors.appGreen, width: 1),
                ),
                child: TextField(
                  controller: controller,
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                  minLines: 1,
                  maxLines: null,
                  style: const TextStyle(height: 1.5),
                  decoration: const InputDecoration(
                    hintText: "Follow up to refine",
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 18, // centers hint & text in minHeight: 60
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),

            // Send button
            SizedBox.square(
              dimension: 56,
              child: Material(
                color:
                    hasText.value
                        ? appColors.appGreen
                        : appColors.appGreen.withValues(alpha: .4),
                shape: const CircleBorder(),
                child: InkWell(
                  onTap: hasText.value ? handleSend : null,
                  customBorder: const CircleBorder(),
                  child: const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Icon(Icons.send, size: 20, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
