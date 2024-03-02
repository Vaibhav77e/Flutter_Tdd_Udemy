part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();
  
  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class CreatingUser extends AuthState{}

class GettingUser extends AuthState{}

class CreatedUser extends AuthState{}

class UsersLoaded extends AuthState{
  final List<User> users;
  UsersLoaded({required this.users});

    @override
  List<Object> get props => users.map((user) => user.id).toList();
}

class AuthenticatedError extends AuthState{
  final String message;

  AuthenticatedError({required this.message});

  @override
  List<String> get props => [message];
}


