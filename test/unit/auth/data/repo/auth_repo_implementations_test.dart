import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_tutorial/core/errors/exceptions.dart';
import 'package:tdd_tutorial/core/errors/failure.dart';
import 'package:tdd_tutorial/src/auth/data/datasources/auth_remote_data_sourecs.dart';
import 'package:tdd_tutorial/src/auth/data/repos/auth_repo_implementations.dart';
import 'package:tdd_tutorial/src/auth/domain/entities/user.dart';

class MockAuthRepoDataSources extends Mock implements AuthenticationRemoteSource{}

void main() {
  late AuthenticationRemoteSource remoteDataSource;
  late AuthenticationRepositoryImplementation remoteRepositoryImpl;

  setUp((){
    remoteDataSource = MockAuthRepoDataSources();
    remoteRepositoryImpl = AuthenticationRepositoryImplementation(remoteDataSource);
  });

  final tException = ServerExceptions(
    message: 'Unknown Error Occured',
    statusCode: 500,
  );


  const createdAt = 'whatever.createdAt';
  const name = 'whatever.name';
  const avatar = 'whatever.avatar';

  group('createUser', () {
    test('should call the [RemoteDataSource.createUser] and complete '
    'successfully when the call to the remote source is successful',
    ()async{
      //arrange
      when(()=>remoteDataSource.createUser(name: any(named:'name'),
      createdAt: any(named:'createdAt'),
      avatar: any(named:'avatar'))).thenAnswer(
        // when the return createUser is type of void we should use Future.value()
        (_) async=> Future.value()
      );

      //act
      final result = await remoteRepositoryImpl.createUser(createdAt:createdAt ,name: name,avatar: avatar);

      // assert
      expect(result,Right(null));
      verify(()=>remoteDataSource.createUser(createdAt: createdAt, name: name, avatar: avatar)).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });
  });
  
  group('getUser',()async{
    test('should return [ServerFailure] when the call to the remote '
    'source is unsuccessful',()async{
      when(()=>remoteDataSource.createUser(name: any(named:'name'),
      createdAt: any(named:'createdAt'),
      avatar: any(named:'avatar'))).thenThrow(tException);

    });

    final result = await remoteRepositoryImpl.createUser(createdAt: createdAt, name: name, avatar: avatar);

    expect( result, equals(Left(tException)));

    verify(()=>remoteDataSource.createUser(createdAt: createdAt, name: name, avatar: avatar)).called(1);

    verifyNoMoreInteractions(remoteDataSource);
  });


    group('getUser', () async{

    test('should call [RemoteDataSource] and return [List<User>]'
    ' when call to remote', () async{
      when(()=>remoteDataSource.getUser()).thenAnswer((_) async => []);

      final result = await remoteRepositoryImpl.getUser();
      expect(result, isA<Right<dynamic,List<User>>>());
      verify(()=>remoteDataSource.getUser()).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });
 
      test(
        'should return a [APIFailure] when the call to the remote '
            'source is unsuccessful',
            () async {
          //  arrange
          when(() => remoteDataSource.getUser()).thenThrow(tException);

          final result = await remoteRepositoryImpl.getUser();

          expect(result, equals(Left(ApiFailure.fromException(tException))));
          verify(() => remoteDataSource.getUser()).called(1);
          verifyNoMoreInteractions(remoteDataSource);
        },
      );

  });

}
