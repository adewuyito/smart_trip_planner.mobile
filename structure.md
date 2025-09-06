smart_trip_planner_flutter/
 ├─ lib/
 │  ├─ core/
 │  │   ├─ errors/ (AppException, NetworkException, SchemaException)
 │  │   ├─ utils/ (json_schema.dart, diff_util.dart, time.dart, log.dart)
 │  │   ├─ networking/ (dio_client.dart, streaming_decoder.dart)
 │  │   ├─ env/ (env.dart) // keys via --dart-define
 │  ├─ data/
 │  │   ├─ datasources/
 │  │   │   ├─ local/isar_trip_source.dart
 │  │   │   └─ remote/agent_remote.dart // calls AgentBridge
 │  │   ├─ models/ (trip.dart, trip_day.dart, trip_item.dart, chat_message.dart)
 │  │   ├─ repositories/ (trip_repo_impl.dart, agent_repo_impl.dart, metrics_repo_impl.dart)
 │  ├─ domain/
 │  │   ├─ entities/ (trip_entity.dart, etc.)
 │  │   ├─ repositories/ (trip_repository.dart, agent_repository.dart, metrics_repository.dart)
 │  │   └─ usecases/ (create_trip.dart, refine_trip.dart, save_trip.dart, load_trips.dart)
 │  ├─ presentation/
 │  │   ├─ app.dart
 │  │   ├─ routes.dart
 │  │   ├─ providers/ (riverpod global providers)
 │  │   ├─ chat/
 │  │   │   ├─ chat_screen.dart
 │  │   │   ├─ chat_controller.dart // Notifier
 │  │   │   └─ widgets/ (message_bubble.dart, streaming_text.dart)
 │  │   ├─ itinerary/
 │  │   │   ├─ itinerary_view.dart
 │  │   │   ├─ itinerary_controller.dart
 │  │   │   └─ widgets/ (day_card.dart, item_tile.dart, diff_badge.dart)
 │  │   ├─ trips/
 │  │   │   ├─ trips_list_screen.dart
 │  │   │   └─ trip_detail_screen.dart
 │  │   ├─ debug/ (metrics_overlay.dart)
 │  ├─ agent/
 │  │   ├─ bridge/agent_bridge.dart  // common interface
 │  │   ├─ bridge/llm_client_openai.dart
 │  │   ├─ bridge/llm_client_gemini.dart
 │  │   ├─ bridge/llm_client_ollama.dart
 │  │   ├─ tools/web_search_tool.dart // wrapper with provider
 │  │   ├─ tools/maps_tool.dart
 │  │   ├─ prompts/
 │  │   │   └─ itinerary_prompt.dart
 │  │   └─ isolate/
 │  │       ├─ agent_isolate.dart
 │  │       └─ agent_service.dart
 │  └─ main.dart
 ├─ test/ (unit + widget)
 ├─ integration_test/
 ├─ build.yaml
 ├─ pubspec.yaml
 └─ README.md
