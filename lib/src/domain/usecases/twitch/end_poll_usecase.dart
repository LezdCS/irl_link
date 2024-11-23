import 'package:irllink/src/core/resources/data_state.dart';
import 'package:irllink/src/core/usecases/usecase.dart';
import 'package:irllink/src/domain/entities/twitch/twitch_poll.dart';
import 'package:irllink/src/domain/repositories/twitch_repository.dart';

class EndPollUseCaseParams {
  final String accessToken;
  final String broadcasterId;
  final String pollId;
  final String status;

  EndPollUseCaseParams({
    required this.accessToken,
    required this.broadcasterId,
    required this.pollId,
    required this.status,
  });
}

class EndPollUseCase
    implements UseCase<DataState<TwitchPoll>, EndPollUseCaseParams> {
  final TwitchRepository twitchRepository;

  EndPollUseCase({required this.twitchRepository});

  @override
  Future<DataState<TwitchPoll>> call({
    required EndPollUseCaseParams params,
  }) {
    return twitchRepository.endPoll(
      params.accessToken,
      params.broadcasterId,
      params.pollId,
      params.status,
    );
  }
}
