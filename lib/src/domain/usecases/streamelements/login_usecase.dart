import 'package:dartz/dartz.dart';
import 'package:irllink/src/core/failure.dart';
import 'package:irllink/src/core/params/streamelements_auth_params.dart';
import 'package:irllink/src/core/usecases/usecase.dart';
import 'package:irllink/src/domain/entities/stream_elements/se_credentials.dart';
import 'package:irllink/src/domain/repositories/streamelements_repository.dart';

class StreamElementsLoginUseCase
    implements
        UseCase<Either<Failure, SeCredentials>, StreamelementsAuthParams> {
  final StreamelementsRepository streamelementsRepository;

  StreamElementsLoginUseCase({required this.streamelementsRepository});

  @override
  Future<Either<Failure, SeCredentials>> call({
    required StreamelementsAuthParams params,
  }) {
    return streamelementsRepository.login(params);
  }
}
