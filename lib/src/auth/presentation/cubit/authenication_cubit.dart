import 'package:bloc/bloc.dart';
import 'package:tdd_tutorial/src/auth/domain/usescases/get_user.dart';
import 'package:tdd_tutorial/src/auth/presentation/cubit/authenication_state.dart';

import '../../domain/usescases/createuser.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit({
    required CreateUser createUser,
    required GetUsers getUsers,
  }) : _createUser = createUser,
        _getUsers = getUsers,
        super(AuthenticationInitial());

  final CreateUser _createUser;
  final GetUsers _getUsers;

  Future<void> createUser({
  required String createdAt,
  required String name,
  required String avatar,
}) async {
    emit(const CreatingUser());

    final result = await _createUser(CreateUserParams(
      createdAt: createdAt,
      name: name,
      avatar: avatar,
    ));

    result.fold(
          (failure) => emit(AuthenticationError(failure.failureMessage)),
          (_) => emit(const UserCreated()),
    );
  }


  Future<void> getUsers() async {
    emit(const GettingUsers());
    final result = await _getUsers();

    result.fold(
          (failure) => emit(AuthenticationError(failure.failureMessage)),
          (users) => emit(UsersLoaded(users)),
    );
}
}