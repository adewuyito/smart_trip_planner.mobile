import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smart_trip_planner/domain/entities/itinerary_entities.dart';
import 'package:smart_trip_planner/domain/usecase/ai_usecase.dart';
import 'package:smart_trip_planner/config/env_config.dart';

final itineraryProvider = StateNotifierProvider<ItineraryNotifier, ItineraryState>((ref) {
  final apiKey = EnvConfig.geminiApiKey;
  final createUseCase = CreateItineraryUseCase(apiKey);
  final refineUseCase = RefineItineraryUseCase(apiKey);
  return ItineraryNotifier(createUseCase, refineUseCase);
});

class ItineraryState {
  final bool isLoading;
  final Itinerary? itinerary;
  final String currentChunk;
  final List<String> chatHistory;

  ItineraryState({
    this.isLoading = false,
    this.itinerary,
    this.currentChunk = '',
    this.chatHistory = const [],
  });

  ItineraryState copyWith({
    bool? isLoading,
    Itinerary? itinerary,
    String? currentChunk,
    List<String>? chatHistory,
  }) => ItineraryState(
        isLoading: isLoading ?? this.isLoading,
        itinerary: itinerary ?? this.itinerary,
        currentChunk: currentChunk ?? this.currentChunk,
        chatHistory: chatHistory ?? this.chatHistory,
      );
}

class ItineraryNotifier extends StateNotifier<ItineraryState> {
  final CreateItineraryUseCase _createUseCase;
  final RefineItineraryUseCase _refineUseCase;

  ItineraryNotifier(this._createUseCase, this._refineUseCase) : super(ItineraryState());

  void generate(String prompt) async {
    state = state.copyWith(isLoading: true, currentChunk: '');
    final stream = _createUseCase.execute(prompt);
    String buffer = '';
    await for (final itinerary in stream) {
      buffer = jsonEncode(itinerary.toJson());
      state = state.copyWith(
        currentChunk: buffer,
        itinerary: itinerary,
        chatHistory: [...state.chatHistory, prompt],
      );
    }
    state = state.copyWith(isLoading: false);
  }

  void refine(String prompt) async {
    if (state.itinerary == null) return;
    state = state.copyWith(isLoading: true, currentChunk: '');
    final stream = _refineUseCase.execute(
      prompt: prompt,
      previousItinerary: state.itinerary!,
      chatHistory: state.chatHistory,
    );
    String buffer = '';
    await for (final itinerary in stream) {
      buffer = jsonEncode(itinerary.toJson());
      state = state.copyWith(
        currentChunk: buffer,
        itinerary: itinerary,
        chatHistory: [...state.chatHistory, prompt],
      );
    }
    state = state.copyWith(isLoading: false);
  }
}