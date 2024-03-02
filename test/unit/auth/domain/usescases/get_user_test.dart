

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_tutorial/src/auth/domain/entities/user.dart';
import 'package:tdd_tutorial/src/auth/domain/repo/auth_repo.dart';
import 'package:tdd_tutorial/src/auth/domain/usescases/get_user.dart';
import 'mock_autho_repo.mock.dart';



void main() {
  late AuthRepo repository;
  late GetUsers getUsersCase;

  setUp((){
    repository = MockAuthRepo();
    getUsersCase = GetUsers(repository);
  });

  final tRepsonse = [User.empty()];

  test(
    
  'should call [AuthRepo.getUsers] and return [List<Users>]',
  //arrange
   ()async{ 
    when(()=>repository.getUser()).thenAnswer((_) async=> Right(tRepsonse));
  // act
  final result = await getUsersCase();

  expect(result, equals( Right<dynamic,List<User>>(tRepsonse)));
  verify(()=>repository.getUser()).called(1);
  verifyNoMoreInteractions(repository);
   }
  );
}