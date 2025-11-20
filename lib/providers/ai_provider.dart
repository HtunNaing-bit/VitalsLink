import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/models/ai_message.dart';
import '../core/services/ai_service.dart';
import '../mocks/mock_data.dart';

final aiServiceProvider = Provider<AIService>((ref) => AIService());

final aiHistoryProvider = FutureProvider<List<AIMessage>>((ref) async {
  final service = ref.watch(aiServiceProvider);
  // TODO: Get userId from auth provider
  const userId = 'demo-user-id';
  return service.fetchHistory(userId: userId);
});

final aiActionsProvider = Provider((ref) => MockData.aiActions);

final chatMessagesProvider =
    StateNotifierProvider<ChatNotifier, AsyncValue<List<AIMessage>>>((ref) {
  return ChatNotifier(ref)..initialize();
});

class ChatNotifier extends StateNotifier<AsyncValue<List<AIMessage>>> {
  ChatNotifier(this.ref) : super(const AsyncValue.loading());

  final Ref ref;

  Future<void> initialize() async {
    try {
      final history = await ref.read(aiHistoryProvider.future);
      state = AsyncValue.data(history);
    } catch (error, stack) {
      state = AsyncValue.error(error, stack);
    }
  }

  Future<void> append(AIMessage message) async {
    final current = state.value ?? [];
    state = AsyncValue.data([...current, message]);
  }

  Future<void> send(String content) async {
    await append(
      AIMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        role: ChatRole.user,
        content: content,
        timestamp: DateTime.now(),
      ),
    );
    // TODO: Get userId from auth provider
    const userId = 'demo-user-id';
    final response = await ref.read(aiServiceProvider).sendChat(
          content: content,
          userId: userId,
        );
    await append(response);
  }
}
