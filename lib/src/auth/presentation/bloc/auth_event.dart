part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class CreateUserEvent extends AuthEvent {
  final String name;
  final String createdAt;
  final String avatar;

  CreateUserEvent(
      {required this.avatar, required this.name, required this.createdAt});
  
    @override
  List<Object> get props => [name, createdAt, avatar];
}


class GetUserEvent extends AuthEvent {
  
}
