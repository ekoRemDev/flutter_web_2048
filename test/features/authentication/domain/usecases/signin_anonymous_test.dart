import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_web_2048/core/error/failures.dart';
import 'package:flutter_web_2048/core/usecases/usecase.dart';
import 'package:flutter_web_2048/features/authentication/domain/entities/user.dart';
import 'package:flutter_web_2048/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:flutter_web_2048/features/authentication/domain/usecases/signin_anonymous.dart';
import 'package:mockito/mockito.dart';

class MockAuthenticationRepository extends Mock implements AuthenticationRepository {}

void main() {
  SigninAnonymous usecase;
  MockAuthenticationRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthenticationRepository();
    usecase = SigninAnonymous(mockRepository);
  });

  test('should implements [UseCase<User, NoParams>]', () {
    // ASSERT
    expect(usecase, isA<UseCase<User, NoParams>>());
  });

  test('should throw when initialized with null argument', () async {
    // ACT & ASSERT
    expect(() => SigninAnonymous(null), throwsA(isA<AssertionError>()));
  });

  test('should call the repository', () async {
    // ACT
    await usecase(NoParams());
    // ASSERT
    verify(mockRepository.signinAnonymously()).called(1);
  });

  test('should return [FirebaseFailure] on Left case', () async {
    // ARRANGE
    when(mockRepository.signinAnonymously()).thenAnswer((_) async => Left(FirebaseFailure()));

    // ACT
    var result = await usecase(NoParams());

    // ASSERT
    expect(result, Left(FirebaseFailure()));
  });

  test('should return [User] on Right case', () async {
    // ARRANGE
    var user = User('username', 'email', 'picutre', AuthenticationProvider.Anonymous);
    when(mockRepository.signinAnonymously()).thenAnswer((_) async => Right(user));

    // ACT
    var result = await usecase(NoParams());

    // ASSERT
    expect(result, Right(user));
  });
}
