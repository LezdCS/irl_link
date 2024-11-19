import 'package:irllink/src/core/usecases/usecase.dart';
import 'package:irllink/src/domain/repositories/twitch_repository.dart';
import 'package:twitch_chat/twitch_chat.dart';

class DeleteMessageUseCaseParams {
  final String accessToken;
  final String broadcasterId;
  final ChatMessage message;

  DeleteMessageUseCaseParams({
    required this.accessToken,
    required this.broadcasterId,
    required this.message,
  });
}

class DeleteMessageUseCase
    implements UseCase<void, DeleteMessageUseCaseParams> {
  final TwitchRepository twitchRepository;

  DeleteMessageUseCase(this.twitchRepository);

  @override
  Future<void> call({
    required DeleteMessageUseCaseParams params,
  }) {
    return twitchRepository.deleteMessage(
      params.accessToken,
      params.broadcasterId,
      params.message,
    );
  }
}