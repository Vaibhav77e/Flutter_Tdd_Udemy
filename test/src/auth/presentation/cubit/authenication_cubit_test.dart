import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_tutorial/core/errors/failure.dart';
import 'package:tdd_tutorial/src/auth/domain/usescases/createuser.dart';
import 'package:tdd_tutorial/src/auth/domain/usescases/get_user.dart';
import 'package:tdd_tutorial/src/auth/presentation/cubit/authenication_cubit.dart';
import 'package:tdd_tutorial/src/auth/presentation/cubit/authenication_state.dart';

class MockGetUsers extends Mock implements GetUsers {}

class MockCreateUser extends Mock implements CreateUser {}

void main() {
  late GetUsers getUsers;
  late CreateUser createUser;
  late AuthenticationCubit authenticationCubit;

  final tCreateUserParams = CreateUserParams.empty();
  final tAPIFailure = ApiFailure(message: 'message', statusCode: 400);

  setUp(() {
    getUsers = MockGetUsers();
    createUser = MockCreateUser();
    authenticationCubit =
        AuthenticationCubit(createUser: createUser, getUsers: getUsers);
    registerFallbackValue(tCreateUserParams);
  });

  test('should be [AuthenticationInitial]', () async {
    expect(authenticationCubit.state, AuthenticationInitial());
  });

  group('CreateUser', () {
    blocTest<AuthenticationCubit, AuthenticationState>(
      "should emit [CreatingUser, UserCreated] when successful",
      build: () {
        when(() => createUser(any()))
            .thenAnswer((_) async => const Right(null));
        return authenticationCubit;
      },
      act: (authenticationCubit) => authenticationCubit.createUser(
          createdAt: tCreateUserParams.createdAt, name: tCreateUserParams.name, avatar: tCreateUserParams.avatar),
      expect: ()=>const [
        CreatingUser(),
        UserCreated(),
      ],
      verify: (_){
          verify(()=>createUser(tCreateUserParams)).called(1);
          verifyNoMoreInteractions(createUser);
      }
    );
  });


  group('getUsers',(){
    blocTest<AuthenticationCubit,AuthenticationState>(
      "should emit [GettingUsers, UsersLoaded] when successful", 
      build: (){
        when(()=> getUsers()).thenAnswer((_) async=> const Right([]));
      return authenticationCubit;
      },
      act: (cubit)=>cubit.getUsers(),
      expect:()=>[
        GettingUsers(),
        UsersLoaded([])
      ],
      verify: (_){
        verify(()=>getUsers()).called(1);
        verifyNoMoreInteractions(getUsers);
      }
      );

    blocTest<AuthenticationCubit,AuthenticationState>('Should emit [GettingUsers, AuthenticationError] when successful', 
    build: (){
      when(()=> getUsers()).thenAnswer((_) async=>  Left(tAPIFailure));
      return authenticationCubit;
    },
    act: (cubit)=>cubit.getUsers(),
    expect: ()=>[
      GettingUsers(),
      AuthenticationError(tAPIFailure.failureMessage),
    ],
    verify: (_){
        verify(()=>getUsers()).called(1);
        verifyNoMoreInteractions(getUsers);
      }
    );
    
  });

  tearDown(() => authenticationCubit.close());
}
