import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tdd_tutorial/src/auth/domain/usescases/get_user.dart';
import '../../domain/entities/user.dart';
import '../../domain/usescases/createuser.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  CreateUser _createUser;
  GetUsers _getUsers;
  AuthBloc(
    {
      required CreateUser createUser,
      required GetUsers getUsers,
    }
  ) : _createUser = createUser,
      _getUsers = getUsers,
  super(AuthInitial()) {
  on<CreateUserEvent>(_createUserHandler);
  on<GetUserEvent>(_getUsersHandler);

  }
    Future<void> _createUserHandler(CreateUserEvent event,
    Emitter<AuthState> emit)async {
       emit(CreatingUser());

      final result = await _createUser(
        CreateUserParams(name: event.name, 
        avatar: event.avatar, 
        createdAt: event.createdAt)
      );


      result.fold((failure) => emit(AuthenticatedError(message: failure.failureMessage
      )), (_) => emit(CreatedUser()));

    }

    Future<void> _getUsersHandler(GetUserEvent event,Emitter<AuthState> emit)async{
      emit(GettingUser());

      final result = await _getUsers();

      result.fold((failure) => emit(AuthenticatedError(message: failure.failureMessage
      )), (users) => emit(UsersLoaded(users:users)));
    }
}
