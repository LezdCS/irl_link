import 'package:irllink/src/core/usecases/usecase.dart';
import 'package:irllink/src/domain/repositories/streamelements_repository.dart';

class StreamElementsResetQueueParams {
  final String token;
  final String channel;

  StreamElementsResetQueueParams({
    required this.token,
    required this.channel,
  });
}

class StreamElementsResetQueueUseCase
    implements UseCase<void, StreamElementsResetQueueParams> {
  final StreamelementsRepository streamelementsRepository;

  StreamElementsResetQueueUseCase({required this.streamelementsRepository});

  @override
  Future<void> call({required StreamElementsResetQueueParams params}) {
    return streamelementsRepository.resetQueue(params.token, params.channel);
  }
}