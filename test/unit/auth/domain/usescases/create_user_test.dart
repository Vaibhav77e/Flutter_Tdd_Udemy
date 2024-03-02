// // import 'package:test/test.dart';


// // void main() {
// //   test('', () => null);
// // }


// // what does class depend on
// // how can we create a fake version of the dependency
// // how do we control what our dependencies do


// import 'dart:ffi';

// import 'package:dartz/dartz.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:tdd_tutorial/src/auth/domain/repo/auth_repo.dart';
// import 'package:tdd_tutorial/src/auth/domain/usescases/createuser.dart';

// class MockCreateUser extends Mock implements AuthRepo{


// }

//   void main() {

//     late CreateUser createUserTest;
//     late AuthRepo authRepo;
//     DateTime now = DateTime.now();

//     setUp((){
//       authRepo =MockCreateUser();
//       createUserTest = CreateUser(authRepo);
//     });

//     final params = CreateUserParams.empty();

//     test('should call [AuthRepo.createUser]',
//     ()async{
//       //arrange
//       when(()=>
//       authRepo.createUser
//       (createdAt: any(named:now.toString() ),
//       name: any(named: 'name'), 
//       avatar: any(named: 'avatar'))).thenAnswer((_) async=> const Right(null));

//       //act
//       final result=createUserTest(params);

//       //assert
//       expect(result, equals(const Right<dynamic,void>(null)));

//     });
//   }

// What does the class depend on
//Answer -- AuthenticationRepository
// How can we create a fake version of the dependency
//Answer -- Use Mocktail
// How do we control what our dependencies do
//Answer -- Using the Mocktail's APIs

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_tutorial/src/auth/domain/repo/auth_repo.dart';
import 'package:tdd_tutorial/src/auth/domain/usescases/createuser.dart';
import 'mock_autho_repo.mock.dart';



void main() {
  late CreateUser usecase;
  late AuthRepo repository;

  setUp(() {
    repository = MockAuthRepo();
    usecase = CreateUser(repository);
  });

  final params = CreateUserParams.empty();
  test(
    'should call the [AuthRepo.createUser]',
        () async {
      // Arrange
      // STUB
        when(
                () => repository.createUser(  
                createdAt: any(named: 'createdAt'),
                name: any(named: 'name'),
                avatar: any(named: 'avatar'),
                ),
        ).thenAnswer((_) async =>const Right(null));

      //  Act
        final result = await usecase(params);

      //  Assert
          expect(result, equals(const Right<dynamic, void>(null)));
          verify(
            ()=>repository.createUser(
              createdAt: params.createdAt,
              avatar: params.avatar,
              name: params.name
            )
          ).called(1);


          verifyNoMoreInteractions(repository);
      },
  );
}